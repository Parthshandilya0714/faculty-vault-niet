package com.niet.facultyvault.repository;

import com.niet.facultyvault.model.JournalPaper;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface JournalRepository extends JpaRepository<JournalPaper, Long> {
    List<JournalPaper> findByFacultyFacultyId(Long facultyId);

    @Query("SELECT COUNT(j) FROM JournalPaper j WHERE j.faculty.facultyId = :facultyId")
    long countByFaculty(@Param("facultyId") Long facultyId);
}