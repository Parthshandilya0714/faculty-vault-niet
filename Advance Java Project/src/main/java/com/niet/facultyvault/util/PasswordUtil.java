package com.niet.facultyvault.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/**
 * Utility class providing password hashing and verification functionality.
 */
public class PasswordUtil {

    /**
     * Generates a SHA-256 hash string for the raw input password.
     */
    public static String hashPassword(String password) {
        if (password == null || password.isEmpty()) {
            return "";
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            return password;
        }
    }

    /**
     * Verifies raw input password against stored hash digest.
     */
    public static boolean verifyPassword(String inputPassword, String storedHash) {
        if (storedHash == null || inputPassword == null) {
            return false;
        }
        return hashPassword(inputPassword).equalsIgnoreCase(storedHash) || inputPassword.equals(storedHash);
    }
}