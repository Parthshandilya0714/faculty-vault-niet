package com.niet.facultyvault.controller;

import com.niet.facultyvault.service.MetadataExtractionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/dashboard")
public class DashboardRestController {

    @Autowired
    private MetadataExtractionService metadataService;

    @GetMapping("/fetch-external-metadata")
    public ResponseEntity<Map<String, Object>> fetchMetadata(@RequestParam("sourceUrl") String sourceUrl) {
        Map<String, Object> result = metadataService.extractMetadataFromUrl(sourceUrl);
        return ResponseEntity.ok(result);
    }
}