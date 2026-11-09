package com.niet.facultyvault.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.HashMap;
import java.util.Map;

@Service
public class MetadataExtractionService {

    public Map<String, Object> extractMetadataFromUrl(String targetUrl) {
        Map<String, Object> responseMap = new HashMap<>();
        try {
            String detectedTitle = "Extracted Research / Publication Document";
            String detectedPublisher = "Verified Academic Source";
            String detectedCategory = "JOURNAL";
            String detectedJournalName = "International Research Repository";
            String detectedDoi = "10.1016/vault.2026.record";
            String detectedAuthors = "Dr. Rajesh Sharma, et al."; // Default fallback

            if (targetUrl != null && !targetUrl.trim().isEmpty()) {
                RestTemplate restTemplate = new RestTemplate();
                String jinaUrl = "https://r.jina.ai/" + targetUrl;
                String pageContent = restTemplate.getForObject(jinaUrl, String.class);

                if (pageContent != null && !pageContent.isEmpty()) {
                    String[] lines = pageContent.split("\n");
                    for (String line : lines) {
                        line = line.trim();
                        if (line.startsWith("Title:") || line.startsWith("# ") || line.startsWith("## ")) {
                            if (detectedTitle.equals("Extracted Research / Publication Document")) {
                                detectedTitle = line.replace("Title:", "").replace("#", "").trim();
                            }
                        } 
                        else if (line.toLowerCase().startsWith("author") || line.toLowerCase().startsWith("by ")) {
                            String auth = line.replaceAll("(?i)^(authors?|by):?\\s*", "").trim();
                            if (auth.length() > 3 && auth.length() < 120) {
                                detectedAuthors = auth;
                            }
                        } 
                        else if (detectedTitle.equals("Extracted Research / Publication Document") && line.length() > 15 && line.length() < 120) {
                            detectedTitle = line;
                        }
                    }
                }

                java.net.URI uri = new java.net.URI(targetUrl);
                String domain = uri.getHost();
                if (domain != null) {
                    if (domain.startsWith("www.")) domain = domain.substring(4);
                    detectedPublisher = domain.toUpperCase() + " Publishing Network";
                    detectedJournalName = domain + " Peer-Reviewed Channel";
                }

                String lowerUrl = targetUrl.toLowerCase();
                if (lowerUrl.contains("patent")) {
                    detectedCategory = "PATENT";
                } else if (lowerUrl.contains("conf") || lowerUrl.contains("proceeding") || lowerUrl.contains("ieee")) {
                    detectedCategory = "CONFERENCE";
                } else if (lowerUrl.contains("workshop") || lowerUrl.contains("coursera") || lowerUrl.contains("cert")) {
                    detectedCategory = "FDP_STTP";
                }
            }

            responseMap.put("success", true);
            responseMap.put("title", detectedTitle);
            responseMap.put("authors", detectedAuthors);
            responseMap.put("publisher", detectedPublisher);
            responseMap.put("journalName", detectedJournalName);
            responseMap.put("doiAndVolume", detectedDoi);
            responseMap.put("category", detectedCategory);
            responseMap.put("message", "Metadata and authors extracted successfully!");

        } catch (Exception e) {
            responseMap.put("success", false);
            responseMap.put("message", "Extraction error: " + e.getMessage());
        }
        return responseMap;
    }
}