package com.alan.jobSearchTracker.services;

import org.springframework.stereotype.Service;

import com.alan.jobSearchTracker.models.Reminder;
import com.alan.jobSearchTracker.repositories.ReminderRepository;

@Service
public class ReminderService {

	private final ReminderRepository reminderRepo;
	
	public ReminderService(ReminderRepository reminderRepo) {
		this.reminderRepo = reminderRepo;
	}
	
	public Reminder create(Reminder r) {
		return reminderRepo.save(r);
	}
}
