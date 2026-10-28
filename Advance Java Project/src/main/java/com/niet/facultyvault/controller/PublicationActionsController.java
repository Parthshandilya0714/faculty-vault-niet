package com.niet.facultyvault.controller;

import com.niet.facultyvault.model.Faculty;
import com.niet.facultyvault.model.ResearchPublication;
import com.niet.facultyvault.repository.FacultyRepository;
import com.niet.facultyvault.repository.ResearchPublicationRepository;
import com.niet.facultyvault.service.FileStorageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

/**
 * Edit and delete for records in the Publications Vault.
 * Both actions only work on the logged-in faculty's own records.
 */
@Controller
public class PublicationActionsController {

    @Autowired
    private FacultyRepository facultyRepo;

    @Autowired
    private ResearchPublicationRepository publicationRepo;

    @Autowired
    private FileStorageService fileStorageService;

    private Faculty currentFaculty(HttpSession session) {
        Faculty f = (Faculty) session.getAttribute("facultyUser");
        if (f == null) {
            String erp = (String) session.getAttribute("loggedInUser");
            if (erp != null) f = facultyRepo.findByErpId(erp).orElse(null);
        }
        return f;
    }

    private static String nz(String s) {
        return s == null ? "" : s.trim();
    }

    private boolean owns(Faculty me, ResearchPublication p) {
        return p.getFaculty() != null && me.getFacultyId() != null
                && me.getFacultyId().equals(p.getFaculty().getFacultyId());
    }

    @PostMapping("/publications/delete")
    public String delete(@RequestParam("publicationId") Long publicationId, HttpSession session) {
        Faculty me = currentFaculty(session);
        if (me == null) return "redirect:/auth?error=session_expired";

        publicationRepo.findById(publicationId).ifPresent(p -> {
            if (owns(me, p)) publicationRepo.delete(p);
        });
        return "redirect:/dashboard?pane=publications&done=deleted";
    }

    @PostMapping("/publications/update")
    public String update(@RequestParam("publicationId") Long publicationId,
                         @RequestParam(value = "category", required = false) String category,
                         @RequestParam(value = "title", required = false) String title,
                         @RequestParam(value = "authors", required = false) String authors,
                         @RequestParam(value = "venueOrPublisher", required = false) String venueOrPublisher,
                         @RequestParam(value = "journalName", required = false) String journalName,
                         @RequestParam(value = "conferenceName", required = false) String conferenceName,
                         @RequestParam(value = "presentationMode", required = false) String presentationMode,
                         @RequestParam(value = "conferenceVenue", required = false) String conferenceVenue,
                         @RequestParam(value = "doiAndVolume", required = false) String doiAndVolume,
                         @RequestParam(value = "patentNumber", required = false) String patentNumber,
                         @RequestParam(value = "ipAuthority", required = false) String ipAuthority,
                         @RequestParam(value = "bookEditor", required = false) String bookEditor,
                         @RequestParam(value = "chapterAuthor", required = false) String chapterAuthor,
                         @RequestParam(value = "fdpName", required = false) String fdpName,
                         @RequestParam(value = "organizer", required = false) String organizer,
                         @RequestParam(value = "date", required = false) String dateStr,
                         @RequestParam(value = "proofFiles", required = false) MultipartFile[] proofFiles,
                         HttpSession session) {

        Faculty me = currentFaculty(session);
        if (me == null) return "redirect:/auth?error=session_expired";

        ResearchPublication pub = publicationRepo.findById(publicationId).orElse(null);
        if (pub == null || !owns(me, pub)) return "redirect:/dashboard?pane=publications";

        String cat = nz(category).isEmpty() ? pub.getCategory() : nz(category).toUpperCase();
        pub.setCategory(cat);
        if (!nz(title).isEmpty()) pub.setTitle(nz(title));
        if (!nz(authors).isEmpty()) pub.setAuthors(nz(authors));

        // venue / publisher: same meaning as on the add form, but keep the old value if the field is empty
        String venue = null;
        switch (cat) {
            case "JOURNAL":
                venue = !nz(venueOrPublisher).isEmpty() ? nz(venueOrPublisher) : nz(journalName);
                break;
            case "CONFERENCE":
                venue = !nz(conferenceVenue).isEmpty()
                        ? nz(conferenceName) + " (" + (nz(presentationMode).isEmpty() ? "Offline" : nz(presentationMode)) + ", " + nz(conferenceVenue) + ")"
                        : nz(conferenceName);
                break;
            case "PATENT":
                venue = nz(ipAuthority);
                break;
            case "BOOK_CHAPTER":
                venue = !nz(chapterAuthor).isEmpty()
                        ? "Editor: " + nz(bookEditor) + " | Chapter Author: " + nz(chapterAuthor)
                        : nz(bookEditor);
                break;
            default:
                venue = !nz(organizer).isEmpty() ? nz(organizer) : nz(fdpName);
        }
        if (venue != null && !venue.isEmpty()) pub.setPublisherOrVenue(venue);

        if ("JOURNAL".equals(cat) && !nz(doiAndVolume).isEmpty()) pub.setIndexingStatus(nz(doiAndVolume));
        if ("PATENT".equals(cat) && !nz(patentNumber).isEmpty()) pub.setIndexingStatus(nz(patentNumber));

        try {
            if (!nz(dateStr).isEmpty()) pub.setEventOrPublishDate(LocalDate.parse(nz(dateStr)));
        } catch (Exception ignored) {
            // keep the old date if the new one cannot be read
        }

        // new proof files are added to the existing ones
        StringBuilder paths = new StringBuilder();
        String old = nz(pub.getProofDocumentPath());
        if (!old.isEmpty() && !"default_proof.pdf".equals(old)) paths.append(old);
        if (proofFiles != null) {
            for (MultipartFile file : proofFiles) {
                if (file != null && !file.isEmpty()) {
                    try {
                        String stored = fileStorageService.storeFile(file);
                        if (paths.length() > 0) paths.append(",");
                        paths.append(stored);
                    } catch (Exception e) {
                        System.err.println("File Upload Error: " + e.getMessage());
                    }
                }
            }
        }
        pub.setProofDocumentPath(paths.toString());

        publicationRepo.save(pub);
        return "redirect:/dashboard?pane=publications&done=updated";
    }
}
