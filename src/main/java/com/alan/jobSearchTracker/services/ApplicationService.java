package com.alan.jobSearchTracker.services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.alan.jobSearchTracker.models.Application;
import com.alan.jobSearchTracker.repositories.ApplicationRepository;

@Service
public class ApplicationService {

	private final ApplicationRepository applicationRepo;
	
	public ApplicationService(ApplicationRepository applicationRepo) {
		this.applicationRepo = applicationRepo;
	}
	
	public Application newApplication(Application app) {
		return applicationRepo.save(app);
	}
	
	public Application findApplication(Long id) {
		Optional<Application> app = applicationRepo.findById(id);
		
		if (app.isPresent()) {
			return app.get();
		}
		else {
			return null;
		}
	}
	
	public Application updateApplication(Application app) {
		return applicationRepo.save(app);
	}
	
	
	
	
	
}
