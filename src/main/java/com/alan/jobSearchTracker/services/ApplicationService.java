package com.alan.jobSearchTracker.services;

import java.util.Date;
import java.util.List;
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
	
	public List<Application> findAppByStatus(String status) {
		return applicationRepo.findAppByStatus(status);
	}
	
	public List<Application> findAppByTime(Date fromDate, Date endDate) {
		return applicationRepo.findAppByTime(fromDate, endDate);
	}
	
	public List<Application> findAppByStatusAndTime(String status, Date fromDate, Date endDate) {
		return applicationRepo.findAppByStatusAndTime(status, fromDate, endDate);
	}
	
	
	
	
}
