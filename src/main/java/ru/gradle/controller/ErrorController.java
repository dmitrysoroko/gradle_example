package ru.gradle.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import ru.gradle.model.ErrorInfo;

@ControllerAdvice
public class ErrorController {
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ErrorInfo processException(Exception e) {
        return new ErrorInfo(e.getMessage());
    }
}
