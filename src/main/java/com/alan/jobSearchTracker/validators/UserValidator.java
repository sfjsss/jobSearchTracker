package com.alan.jobSearchTracker.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.repositories.UserRepository;

@Component
public class UserValidator implements Validator {
	
	private final UserRepository userRepo;
	
	public UserValidator(UserRepository userRepo) {
		this.userRepo = userRepo;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		User user = (User) target;
		
		if (!user.getPasswordConfirmation().equals(user.getPassword())) {
			errors.rejectValue("passwordConfirmation", "Match");
		}
		
		if (userRepo.findByEmail(user.getEmail()) != null) {
			errors.rejectValue("email", "Unique");
		}
	}

}
