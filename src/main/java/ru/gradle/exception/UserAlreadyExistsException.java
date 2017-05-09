package ru.gradle.exception;

public class UserAlreadyExistsException extends RuntimeException {

    @Override
    public String getMessage() {
        return "User with this name already exists";
    }
}
