package com.niet.facultyvault.repository;



import com.niet.facultyvault.model.ConferencePaper;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;



@Repository

public interface ConferenceRepository extends JpaRepository<ConferencePaper, Long> {

}