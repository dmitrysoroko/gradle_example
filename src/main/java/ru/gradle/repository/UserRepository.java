package ru.gradle.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.gradle.model.User;

public interface UserRepository extends CrudRepository<User, Long> {

    @Query("SELECT c.name FROM User c where c.id = :id")
    String findNameById(@Param("id") Long id);

    User findByNameAndPassword(String name, String password);

    @Transactional
    Long deleteById(Long id);

    User findByName(String name);
}
