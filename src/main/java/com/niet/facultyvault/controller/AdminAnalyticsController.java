package com.niet.facultyvault.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Live data feed for /WEB-INF/views/analytics.jsp
 * GET /admin/api/analytics  ->  { generatedAt, faculty: [...], records: [...] }
 *
 * !! BEFORE USING, CHECK THE 3 THINGS MARKED "ADJUST" BELOW against your real database !!
 */
@RestController
@RequestMapping("/admin/api")
public class AdminAnalyticsController {

    // ADJUST 1: the session attribute your ADMIN LOGIN stores (look for session.setAttribute(...) in your admin login controller).
    private static final String ADMIN_SESSION_KEY = "adminUser";

    // ADJUST 2: table / column names of your faculty table (see Supabase -> Table Editor).
    // Output aliases ("id","name","erpId",...) are what the JSP reads - do not rename those.
    private static final String FACULTY_SQL =
            "SELECT id AS \"id\", " +
            "       full_name AS \"name\", " +
            "       erp_id AS \"erpId\", " +
            "       department AS \"department\", " +
            "       designation AS \"designation\", " +
            "       official_email AS \"email\" " +
            "FROM faculty " +
            "WHERE COALESCE(is_admin, false) = false " +
            "ORDER BY full_name";

    // ADJUST 3: table / column names of the table where faculty research submissions are saved.
    private static final String RECORDS_SQL =
            "SELECT r.id AS \"id\", " +
            "       r.faculty_id AS \"facultyId\", " +
            "       f.full_name AS \"facultyName\", " +
            "       f.department AS \"department\", " +
            "       r.category AS \"category\", " +
            "       r.title AS \"title\", " +
            "       r.authors AS \"authors\", " +
            "       r.venue AS \"venue\", " +
            "       r.indexing AS \"indexing\", " +
            "       r.academic_year AS \"year\", " +
            "       r.status AS \"status\", " +
            "       to_char(r.submitted_at, 'YYYY-MM-DD\"T\"HH24:MI:SS') AS \"submittedAt\", " +
            "       to_char(r.submitted_at, 'YYYY-MM-DD') AS \"date\" " +
            "FROM research_records r " +
            "JOIN faculty f ON f.id = r.faculty_id " +
            "ORDER BY r.submitted_at DESC";

    private final JdbcTemplate jdbc;

    public AdminAnalyticsController(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    @GetMapping(value = "/analytics", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> analytics(HttpSession session) {
        if (session == null || session.getAttribute(ADMIN_SESSION_KEY) == null) {
            return ResponseEntity.status(401).body(Map.of("error", "unauthorized"));
        }

        List<Map<String, Object>> faculty = jdbc.queryForList(FACULTY_SQL);
        List<Map<String, Object>> records = jdbc.queryForList(RECORDS_SQL);

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("generatedAt", Instant.now().toString());
        body.put("faculty", faculty);
        body.put("records", records);

        return ResponseEntity.ok()
                .cacheControl(CacheControl.noStore())
                .body(body);
    }
}
