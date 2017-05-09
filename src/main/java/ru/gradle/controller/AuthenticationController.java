package ru.gradle.controller;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.gradle.exception.IncorrectNameOrPasswordException;
import ru.gradle.exception.UserAlreadyExistsException;
import ru.gradle.model.Employee;
import ru.gradle.model.Employer;
import ru.gradle.model.Role;
import ru.gradle.model.User;
import ru.gradle.repository.EmployeeRepository;
import ru.gradle.repository.EmployerRepository;
import ru.gradle.repository.RoleRepository;
import ru.gradle.repository.UserRepository;

import java.io.IOException;

@RestController
public class AuthenticationController {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final EmployeeRepository employeeRepository;
    private final EmployerRepository employerRepository;

    @Autowired
    public AuthenticationController(UserRepository userRepository, RoleRepository roleRepository,
                                    EmployerRepository employerRepository, EmployeeRepository employeeRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.employeeRepository = employeeRepository;
        this.employerRepository = employerRepository;
    }

    @RequestMapping(value = "/api/authenticate", method = RequestMethod.POST)
    public User authenticate(@RequestBody User user) {
        user = userRepository.findByNameAndPassword(user.getName(),user.getPassword());
        if(user == null) {
            throw new IncorrectNameOrPasswordException();
        }
        else {
            return user;
        }
    }

    @RequestMapping(value = "/api/register/employee", method = RequestMethod.POST)
    public User registerEmployee(@RequestBody String body) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode node = mapper.readTree(body);
        User user = mapper.convertValue(node.get("user"), User.class);
        Employee employee = mapper.convertValue(node.get("employee"), Employee.class);
        if(userRepository.findByName(user.getName()) == null) {
            user.setId(0L);
            user.setRole(roleRepository.findByName("ROLE_EMPLOYEE"));
            user = userRepository.save(user);
            employee.setId(0L);
            employee.setUser(user);
            employeeRepository.save(employee);
            return user;
        }
        else {
            throw new UserAlreadyExistsException();
        }
    }

    @RequestMapping(value = "/api/register/employer", method = RequestMethod.POST)
    public User registerEmployer(@RequestBody String body) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode node = mapper.readTree(body);
        User user = mapper.convertValue(node.get("user"), User.class);
        Employer employer = mapper.convertValue(node.get("employer"), Employer.class);
        if(userRepository.findByName(user.getName()) == null) {
            user.setId(0L);
            user.setRole(roleRepository.findByName("ROLE_EMPLOYER"));
            user = userRepository.save(user);
            employer.setId(0L);
            employer.setUser(user);
            employerRepository.save(employer);
            return user;
        }
        else {
            throw new UserAlreadyExistsException();
        }
    }

    @RequestMapping(value = "/api/register", method = RequestMethod.GET)
    public Iterable<Role> register() {
        return roleRepository.findAllByIdGreaterThan(1L);
    }
}
