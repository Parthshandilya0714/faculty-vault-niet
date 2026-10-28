package com.niet.facultyvault.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "research_publications")
public class ResearchPublication {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty faculty;

    @Column(nullable = false, length = 50)
    private String category; // JOURNAL, CONFERENCE, BOOK_CHAPTER, PATENT, FDP_STTP, OUTREACH, OTHER

    @Column(nullable = false, length = 500)
    private String title;

    @Column(length = 500)
    private String authors;

    @Column(length = 100)
    private String affiliation;

    private String correspondingAuthor;
    private String venueOrPublisher;
    private String indexing;
    private String isbnIssn;
    private String doiOrUrl;
    private String applicationNumber;
    private String status;

    private LocalDate eventOrPublishDate;
    private Integer academicYearStart;

    private String proofDocumentPath;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    // Default Constructor
    public ResearchPublication() {
    }

    // All Arguments Constructor
    public ResearchPublication(Long id, Faculty faculty, String category, String title, String authors, 
                               String affiliation, String correspondingAuthor, String venueOrPublisher, 
                               String indexing, String isbnIssn, String doiOrUrl, String applicationNumber, 
                               String status, LocalDate eventOrPublishDate, Integer academicYearStart, 
                               String proofDocumentPath, LocalDateTime createdAt) {
        this.id = id;
        this.faculty = faculty;
        this.category = category;
        this.title = title;
        this.authors = authors;
        this.affiliation = affiliation;
        this.correspondingAuthor = correspondingAuthor;
        this.venueOrPublisher = venueOrPublisher;
        this.indexing = indexing;
        this.isbnIssn = isbnIssn;
        this.doiOrUrl = doiOrUrl;
        this.applicationNumber = applicationNumber;
        this.status = status;
        this.eventOrPublishDate = eventOrPublishDate;
        this.academicYearStart = academicYearStart;
        this.proofDocumentPath = proofDocumentPath;
        this.createdAt = createdAt;
    }

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthors() {
        return authors;
    }

    public void setAuthors(String authors) {
        this.authors = authors;
    }

    public String getAffiliation() {
        return affiliation;
    }

    public void setAffiliation(String affiliation) {
        this.affiliation = affiliation;
    }

    public String getCorrespondingAuthor() {
        return correspondingAuthor;
    }

    public void setCorrespondingAuthor(String correspondingAuthor) {
        this.correspondingAuthor = correspondingAuthor;
    }

    public String getVenueOrPublisher() {
        return venueOrPublisher;
    }

    public void setVenueOrPublisher(String venueOrPublisher) {
        this.venueOrPublisher = venueOrPublisher;
    }

    public String getIndexing() {
        return indexing;
    }

    public void setIndexing(String indexing) {
        this.indexing = indexing;
    }

    public String getIsbnIssn() {
        return isbnIssn;
    }

    public void setIsbnIssn(String isbnIssn) {
        this.isbnIssn = isbnIssn;
    }

    public String getDoiOrUrl() {
        return doiOrUrl;
    }

    public void setDoiOrUrl(String doiOrUrl) {
        this.doiOrUrl = doiOrUrl;
    }

    public String getApplicationNumber() {
        return applicationNumber;
    }

    public void setApplicationNumber(String applicationNumber) {
        this.applicationNumber = applicationNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getEventOrPublishDate() {
        return eventOrPublishDate;
    }

    public void setEventOrPublishDate(LocalDate eventOrPublishDate) {
        this.eventOrPublishDate = eventOrPublishDate;
    }

    public Integer getAcademicYearStart() {
        return academicYearStart;
    }

    public void setAcademicYearStart(Integer academicYearStart) {
        this.academicYearStart = academicYearStart;
    }

    public String getProofDocumentPath() {
        return proofDocumentPath;
    }

    public void setProofDocumentPath(String proofDocumentPath) {
        this.proofDocumentPath = proofDocumentPath;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // Controller Compatibility Alias Methods
    public Long getPublicationId() {
        return this.id;
    }

    public void setPublicationId(Long id) {
        this.id = id;
    }

    public String getIndexingStatus() {
        return this.indexing;
    }

    public void setIndexingStatus(String indexingStatus) {
        this.indexing = indexingStatus;
    }

    public String getPublisherOrVenue() {
        return this.venueOrPublisher;
    }

    public void setPublisherOrVenue(String venueOrPublisher) {
        this.venueOrPublisher = venueOrPublisher;
    }
}