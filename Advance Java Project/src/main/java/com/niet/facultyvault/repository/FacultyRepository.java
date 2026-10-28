package com.niet.facultyvault.repository;

import com.niet.facultyvault.model.Faculty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository interface for managing Faculty entities in the database.
 * Provides standard CRUD operations and custom query methods for ERP ID, Official Email,
 * Department filter, and Search lookups.
 */
@Repository
public interface FacultyRepository extends JpaRepository<Faculty, Long> {

    /**
     * Finds a faculty member by their unique ERP ID.
     * 
     * @param erpId the faculty ERP ID (e.g., ERP101)
     * @return an Optional containing the Faculty entity if found
     */
    Optional<Faculty> findByErpId(String erpId);

    /**
     * Finds a faculty member by their institutional official email address.
     * 
     * @param officialEmail the faculty email address (e.g., faculty@niet.co.in)
     * @return an Optional containing the Faculty entity if found
     */
    Optional<Faculty> findByOfficialEmail(String officialEmail);

    /**
     * Finds a faculty member matching either ERP ID or Official Email.
     * Useful for single login inputs accepting either credential.
     * 
     * @param identifier ERP ID or Official Email string
     * @return an Optional containing the Faculty entity if found
     */
    @Query("SELECT f FROM Faculty f WHERE f.erpId = :identifier OR f.officialEmail = :identifier")
    Optional<Faculty> findByErpIdOrOfficialEmail(@Param("identifier") String identifier);

    /**
     * Checks if a faculty record exists with the given ERP ID.
     * 
     * @param erpId the faculty ERP ID
     * @return true if exists, false otherwise
     */
    boolean existsByErpId(String erpId);

    /**
     * Checks if a faculty record exists with the given institutional official email.
     * 
     * @param officialEmail the faculty email address
     * @return true if exists, false otherwise
     */
    boolean existsByOfficialEmail(String officialEmail);

    /**
     * Retrieves all faculty members belonging to a specific department.
     * 
     * @param department department name
     * @return list of matching Faculty entities
     */
    List<Faculty> findByDepartment(String department);

    /**
     * Retrieves all faculty members with a specific designation.
     * 
     * @param designation designation title (e.g., Professor)
     * @return list of matching Faculty entities
     */
    List<Faculty> findByDesignation(String designation);

    /**
     * Searches faculty members by partial name match (case-insensitive).
     * 
     * @param keyword search keyword
     * @return list of matching Faculty entities
     */
    List<Faculty> findByFullNameContainingIgnoreCase(String keyword);

    /**
     * Counts total faculty members in a given department.
     * 
     * @param department department name
     * @return total count
     */
    long countByDepartment(String department);
}