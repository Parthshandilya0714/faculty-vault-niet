package com.niet.facultyvault.config;

import com.niet.facultyvault.model.Faculty;
import com.niet.facultyvault.repository.FacultyRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initDatabase(FacultyRepository repository) {
        return args -> {
            if (repository.findByErpId("ERP101").isEmpty()) {
                Faculty demoFaculty = new Faculty();
                demoFaculty.setErpId("ERP101");
                demoFaculty.setFullName("Dr. Rajesh Sharma");
                demoFaculty.setOfficialEmail("rajesh.sharma@niet.co.in");
                demoFaculty.setMobileNumber("9876543210");
                demoFaculty.setDepartment("Computer Science & Engineering");
                demoFaculty.setDesignation("Professor & Dean R&D");
                demoFaculty.setHighestQualification("Ph.D. in Computer Science");
                demoFaculty.setSpecialization("AI, Data Science & IoT");
                demoFaculty.setOrcidId("0000-0002-1825-0097");
                demoFaculty.setScopusId("57200293810");
                demoFaculty.setPasswordHash("admin123");
                demoFaculty.setIsVerified(true);
                demoFaculty.setRole("FACULTY");
                
                repository.save(demoFaculty);
                System.out.println(">>> Default Demo Faculty Created: ERP101 / admin123");
            }
        };
    }
}