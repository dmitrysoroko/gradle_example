package ru.gradle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.gradle.exception.IncorrectNameOrPasswordException;
import ru.gradle.exception.UserAlreadyExistsException;
import ru.gradle.model.Role;
import ru.gradle.model.User;
import ru.gradle.repository.RoleRepository;
import ru.gradle.repository.UserRepository;

import java.util.List;

@RestController
public class UserController {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    public UserController(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @RequestMapping(value = "/api/users", method = RequestMethod.GET)
    public Iterable<User> getUsers() {
        return userRepository.findAll();
    }

    @RequestMapping(value = "/api/users", method = RequestMethod.POST)
    public User createUser(@RequestBody User user) {
        if(userRepository.findByName(user.getName()) == null) {
            user.setRole(roleRepository.findOne(2L));
            return userRepository.save(user);
        }
        else {
            throw new UserAlreadyExistsException();
        }
    }

    @RequestMapping(value = "/api/users/{id}", method = RequestMethod.GET)
    public User getUser(@PathVariable Long id) {
        return userRepository.findOne(id);
    }

    @RequestMapping(value = "/api/users/{id}", method = RequestMethod.DELETE)
    public Long deleteUser(@PathVariable Long id) {
        return userRepository.deleteById(id);
    }
}
