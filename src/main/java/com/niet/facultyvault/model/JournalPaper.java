package com.niet.facultyvault.model;

import jakarta.persistence.*;

@Entity
@Table(name = "journal_papers")
public class JournalPaper {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long paperId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty faculty;

    @Column(name = "paper_title", nullable = false, columnDefinition = "TEXT")
    private String paperTitle;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String authors;

    @Column(name = "journal_name", nullable = false)
    private String journalName;

    @Column(name = "pub_year", nullable = false)
    private Integer pubYear;

    @Column(length = 255)
    private String doi;

    @Column(length = 10)
    private String quartile;

    @Column(nullable = false, length = 100)
    private String domain;

    private String status = "Published";

    private Integer citations = 0;

    public JournalPaper() {
    }

    public JournalPaper(Long paperId, Faculty faculty, String paperTitle, String authors, 
                        String journalName, Integer pubYear, String doi, String quartile, 
                        String domain, String status, Integer citations) {
        this.paperId = paperId;
        this.faculty = faculty;
        this.paperTitle = paperTitle;
        this.authors = authors;
        this.journalName = journalName;
        this.pubYear = pubYear;
        this.doi = doi;
        this.quartile = quartile;
        this.domain = domain;
        this.status = status != null ? status : "Published";
        this.citations = citations != null ? citations : 0;
    }

    // Getters and Setters
    public Long getPaperId() {
        return paperId;
    }

    public void setPaperId(Long paperId) {
        this.paperId = paperId;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }

    public String getPaperTitle() {
        return paperTitle;
    }

    public void setPaperTitle(String paperTitle) {
        this.paperTitle = paperTitle;
    }

    public String getAuthors() {
        return authors;
    }

    public void setAuthors(String authors) {
        this.authors = authors;
    }

    public String getJournalName() {
        return journalName;
    }

    public void setJournalName(String journalName) {
        this.journalName = journalName;
    }

    public Integer getPubYear() {
        return pubYear;
    }

    public void setPubYear(Integer pubYear) {
        this.pubYear = pubYear;
    }

    public String getDoi() {
        return doi;
    }

    public void setDoi(String doi) {
        this.doi = doi;
    }

    public String getQuartile() {
        return quartile;
    }

    public void setQuartile(String quartile) {
        this.quartile = quartile;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCitations() {
        return citations;
    }

    public void setCitations(Integer citations) {
        this.citations = citations;
    }
}