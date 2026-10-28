package com.niet.facultyvault.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

import java.time.LocalDateTime;

/**
 * JPA Entity representing a Faculty member in the database.
 * Includes security credentials, profile information, and audit metadata.
 */
@Entity
@Table(name = "faculty")
public class Faculty {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long facultyId;

    @Column(name = "erp_id", unique = true, nullable = false, length = 50)
    private String erpId;

    @Column(name = "full_name", nullable = false, length = 150)
    private String fullName;

    @Column(name = "official_email", unique = true, nullable = false, length = 150)
    private String officialEmail;

    @Column(name = "mobile_number", length = 20)
    private String mobileNumber;

    @Column(nullable = false, length = 100)
    private String department;

    @Column(nullable = false, length = 100)
    private String designation;

    @Column(name = "highest_qualification", length = 100)
    private String highestQualification;

    @Column(name = "specialization", length = 150)
    private String specialization;

    @Column(name = "orcid_id", length = 50)
    private String orcidId;

    @Column(name = "scopus_id", length = 50)
    private String scopusId;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "is_verified")
    private Boolean isVerified = false;

    @Column(length = 20)
    private String role = "FACULTY";

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    public Faculty() {
    }

    public Faculty(Long facultyId, String erpId, String fullName, String officialEmail, 
                   String mobileNumber, String department, String designation, 
                   String highestQualification, String specialization, String orcidId, 
                   String scopusId, String passwordHash, Boolean isVerified, 
                   String role, LocalDateTime createdAt) {
        this.facultyId = facultyId;
        this.erpId = erpId;
        this.fullName = fullName;
        this.officialEmail = officialEmail;
        this.mobileNumber = mobileNumber;
        this.department = department;
        this.designation = designation;
        this.highestQualification = highestQualification;
        this.specialization = specialization;
        this.orcidId = orcidId;
        this.scopusId = scopusId;
        this.passwordHash = passwordHash;
        this.isVerified = isVerified;
        this.role = role;
        this.createdAt = createdAt;
    }

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getFacultyId() {
        return facultyId;
    }

    public void setFacultyId(Long facultyId) {
        this.facultyId = facultyId;
    }

    public String getErpId() {
        return erpId;
    }

    public void setErpId(String erpId) {
        this.erpId = erpId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getOfficialEmail() {
        return officialEmail;
    }

    public void setOfficialEmail(String officialEmail) {
        this.officialEmail = officialEmail;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getHighestQualification() {
        return highestQualification;
    }

    public void setHighestQualification(String highestQualification) {
        this.highestQualification = highestQualification;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getOrcidId() {
        return orcidId;
    }

    public void setOrcidId(String orcidId) {
        this.orcidId = orcidId;
    }

    public String getScopusId() {
        return scopusId;
    }

    public void setScopusId(String scopusId) {
        this.scopusId = scopusId;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Boolean getIsVerified() {
        return isVerified;
    }

    public void setIsVerified(Boolean isVerified) {
        this.isVerified = isVerified;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}