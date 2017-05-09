package ru.gradle.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import ru.gradle.model.Employer;

public interface EmployerRepository extends CrudRepository<Employer, Long> {


}
