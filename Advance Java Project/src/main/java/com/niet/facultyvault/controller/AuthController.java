package com.niet.facultyvault.controller;

import com.niet.facultyvault.service.EmailOtpService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private EmailOtpService emailOtpService;

    @PostMapping("/send-otp")
    public ResponseEntity<Map<String, String>> sendOtp(@RequestParam("email") String email, HttpSession session) {
        Map<String, String> response = new HashMap<>();

        if (email == null || !email.endsWith("@niet.co.in")) {
            response.put("status", "INVALID_DOMAIN");
            response.put("message", "Please use a valid official @niet.co.in email.");
            return ResponseEntity.badRequest().body(response);
        }

        String otp = emailOtpService.sendOtpToFaculty(email);

        if (otp != null) {
            session.setAttribute("serverOtp", otp);
            session.setAttribute("targetEmail", email);

            response.put("status", "SUCCESS");
            response.put("message", "OTP sent successfully to " + email);
            return ResponseEntity.ok(response);
        } else {
            response.put("status", "FAILED");
            response.put("message", "Failed to send email. Check your App Password.");
            return ResponseEntity.status(500).body(response);
        }
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<Map<String, String>> verifyOtp(@RequestParam("otp") String userOtp, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        String serverOtp = (String) session.getAttribute("serverOtp");

        if (serverOtp != null && serverOtp.equals(userOtp)) {
            session.setAttribute("isEmailVerified", true);
            response.put("status", "SUCCESS");
            response.put("message", "Email verified successfully!");
            return ResponseEntity.ok(response);
        } else {
            response.put("status", "INVALID_OTP");
            response.put("message", "Incorrect OTP. Please try again.");
            return ResponseEntity.badRequest().body(response);
        }
    }
}