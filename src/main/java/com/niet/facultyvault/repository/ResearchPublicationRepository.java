package com.niet.facultyvault.repository;

import com.niet.facultyvault.model.ResearchPublication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResearchPublicationRepository extends JpaRepository<ResearchPublication, Long> {

    List<ResearchPublication> findByFacultyFacultyId(Long facultyId);

    long countByFacultyFacultyIdAndCategory(Long facultyId, String category);

    // Real-time Search Query for Dashboard Search Bar
    @Query("SELECT r FROM ResearchPublication r WHERE r.faculty.facultyId = :facultyId AND " +
           "(LOWER(r.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(r.venueOrPublisher) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(r.category) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<ResearchPublication> searchByKeyword(@Param("keyword") String keyword, @Param("facultyId") Long facultyId);

    // Multi-criteria filter for Admin/Dean Dashboard
    @Query("SELECT r FROM ResearchPublication r WHERE " +
           "(:facultyId IS NULL OR r.faculty.facultyId = :facultyId) AND " +
           "(:category IS NULL OR :category = '' OR r.category = :category) AND " +
           "(:academicYear IS NULL OR r.academicYearStart = :academicYear) " +
           "ORDER BY r.eventOrPublishDate DESC")
    List<ResearchPublication> findWithFilters(@Param("facultyId") Long facultyId,
                                              @Param("category") String category,
                                              @Param("academicYear") Integer academicYear);
}