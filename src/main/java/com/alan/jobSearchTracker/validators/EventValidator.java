package com.alan.jobSearchTracker.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.alan.jobSearchTracker.models.Event;



@Component
public class EventValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Event.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Event e = (Event) target;
		
		if (e.getEventDate() == null) {
			errors.rejectValue("eventDate", "Present");
		}
 
	}

}
