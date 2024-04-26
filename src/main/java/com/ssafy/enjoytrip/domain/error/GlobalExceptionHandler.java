package com.ssafy.enjoytrip.domain.error;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<?> handleValidationExceptions(MethodArgumentNotValidException ex) {
		BindingResult bindingResult = ex.getBindingResult();

		System.out.println("bindingResult: " + bindingResult);

		List<String> errors = new ArrayList<>();
		for (FieldError error : bindingResult.getFieldErrors()) {
			errors.add(error.getDefaultMessage());
		}
		for (ObjectError error : bindingResult.getGlobalErrors()) {
			errors.add(error.getDefaultMessage());
		}
		return ResponseEntity.badRequest().body(errors);
	}
}
