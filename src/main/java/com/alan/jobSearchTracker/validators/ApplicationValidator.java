package com.alan.jobSearchTracker.validators;

import java.util.Date;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.alan.jobSearchTracker.models.Application;

@Component
public class ApplicationValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Application.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Application a = (Application) target;
		Date today = new Date();
		
		if (a.getDateOfSubmission() != null) {
			if (a.getDateOfSubmission().compareTo(today) > 0) {
				errors.rejectValue("dateOfSubmission", "Valid");
			}
		}
	}

}
