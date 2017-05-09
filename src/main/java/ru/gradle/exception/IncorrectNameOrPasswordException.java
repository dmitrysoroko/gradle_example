package ru.gradle.exception;

public class IncorrectNameOrPasswordException extends RuntimeException {

    @Override
    public String getMessage() {
        return "Incorrect name or password";
    }
}