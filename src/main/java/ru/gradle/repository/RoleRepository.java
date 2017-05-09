package ru.gradle.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import ru.gradle.model.Role;

public interface RoleRepository extends CrudRepository<Role, Long> {

    Iterable<Role> findAllByIdGreaterThan(Long id);
    Role findByName(String name);
}
