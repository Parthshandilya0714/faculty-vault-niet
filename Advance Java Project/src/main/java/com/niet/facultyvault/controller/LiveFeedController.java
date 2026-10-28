package com.niet.facultyvault.controller;

import com.niet.facultyvault.model.Faculty;
import com.niet.facultyvault.model.ResearchPublication;
import com.niet.facultyvault.repository.FacultyRepository;
import com.niet.facultyvault.repository.ResearchPublicationRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Powers the live "Department Updates" feed and the department / college ranking.
 * Uses only your existing repositories - no new table needed.
 * Congratulations are kept in memory, so they reset when the server restarts.
 */
@RestController
@RequestMapping("/dashboard")
public class LiveFeedController {

    @Autowired
    private FacultyRepository facultyRepo;

    @Autowired
    private ResearchPublicationRepository publicationRepo;

    private final Map<Long, Set<String>> congrats = new ConcurrentHashMap<>();
    private final Map<String, List<Map<String, Object>>> inbox = new ConcurrentHashMap<>();
    private final AtomicLong noticeSeq = new AtomicLong();

    private Faculty currentFaculty(HttpSession session) {
        Faculty f = (Faculty) session.getAttribute("facultyUser");
        if (f == null) {
            String erp = (String) session.getAttribute("loggedInUser");
            if (erp != null) f = facultyRepo.findByErpId(erp).orElse(null);
        }
        return f;
    }

    private int points(String category) {
        if (category == null) return 3;
        switch (category) {
            case "JOURNAL": return 10;
            case "CONFERENCE": return 5;
            case "PATENT": return 15;
            default: return 3;
        }
    }

    @GetMapping("/feed-api")
    public ResponseEntity<Map<String, Object>> feed(@RequestParam(value = "since", defaultValue = "0") long since,
                                                    HttpSession session) {
        Faculty me = currentFaculty(session);
        if (me == null) return ResponseEntity.status(401).build();

        List<ResearchPublication> all = publicationRepo.findAll();

        // ---- feed: newest first, only items newer than "since" ----
        List<ResearchPublication> fresh = new ArrayList<>();
        for (ResearchPublication p : all) {
            if (p.getPublicationId() != null && p.getPublicationId() > since && p.getFaculty() != null) fresh.add(p);
        }
        fresh.sort((a, b) -> Long.compare(b.getPublicationId(), a.getPublicationId()));

        List<Map<String, Object>> feed = new ArrayList<>();
        for (ResearchPublication p : fresh.subList(0, Math.min(30, fresh.size()))) {
            Faculty owner = p.getFaculty();
            Set<String> claps = congrats.getOrDefault(p.getPublicationId(), Collections.emptySet());
            Map<String, Object> m = new HashMap<>();
            m.put("id", p.getPublicationId());
            m.put("facultyName", owner.getFullName());
            m.put("department", owner.getDepartment());
            m.put("category", p.getCategory());
            m.put("title", p.getTitle());
            m.put("eventDate", p.getEventOrPublishDate() != null ? p.getEventOrPublishDate().toString() : null);
            m.put("mine", Objects.equals(owner.getFacultyId(), me.getFacultyId()));
            m.put("congratsCount", claps.size());
            m.put("congratulatedByMe", claps.contains(me.getErpId()));
            feed.add(m);
        }

        // ---- live clap counts for every item ----
        Map<Long, Integer> counts = new HashMap<>();
        congrats.forEach((id, set) -> counts.put(id, set.size()));

        // ---- college-wide leaderboard (page derives the department view) ----
        Map<Long, Integer> scoreByFaculty = new HashMap<>();
        for (ResearchPublication p : all) {
            if (p.getFaculty() == null) continue;
            scoreByFaculty.merge(p.getFaculty().getFacultyId(), points(p.getCategory()), Integer::sum);
        }
        List<Map<String, Object>> leaderboard = new ArrayList<>();
        for (Faculty f : facultyRepo.findAll()) {
            Map<String, Object> row = new HashMap<>();
            row.put("erp", f.getErpId());
            row.put("name", f.getFullName());
            row.put("dept", f.getDepartment());
            row.put("score", scoreByFaculty.getOrDefault(f.getFacultyId(), 0));
            row.put("mine", Objects.equals(f.getFacultyId(), me.getFacultyId()));
            leaderboard.add(row);
        }

        // ---- "X congratulated you" notifications (delivered once) ----
        List<Map<String, Object>> pending = inbox.remove(me.getErpId());

        Map<String, Object> out = new HashMap<>();
        out.put("feed", feed);
        out.put("counts", counts);
        out.put("leaderboard", leaderboard);
        out.put("inbox", pending != null ? pending : Collections.emptyList());
        return ResponseEntity.ok(out);
    }

    @PostMapping("/congratulate")
    public ResponseEntity<Map<String, Object>> congratulate(@RequestParam("feedId") long feedId, HttpSession session) {
        Faculty me = currentFaculty(session);
        if (me == null) return ResponseEntity.status(401).build();

        ResearchPublication pub = publicationRepo.findById(feedId).orElse(null);
        if (pub == null || pub.getFaculty() == null) return ResponseEntity.status(404).build();
        if (Objects.equals(pub.getFaculty().getFacultyId(), me.getFacultyId())) {
            return ResponseEntity.ok(Map.of("ok", false));
        }

        Set<String> set = congrats.computeIfAbsent(feedId, k -> ConcurrentHashMap.newKeySet());
        if (set.add(me.getErpId())) {
            Map<String, Object> notice = new HashMap<>();
            notice.put("id", System.currentTimeMillis() + "-" + noticeSeq.incrementAndGet());
            notice.put("title", me.getFullName() + " congratulated you");
            notice.put("sub", pub.getTitle());
            inbox.computeIfAbsent(pub.getFaculty().getErpId(), k -> new CopyOnWriteArrayList<>()).add(notice);
        }
        return ResponseEntity.ok(Map.of("ok", true));
    }
}
