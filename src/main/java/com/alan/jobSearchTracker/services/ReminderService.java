package com.alan.jobSearchTracker.services;

import java.util.Date;
import java.util.List;

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
	
	public List<Reminder> findActiveReminders(Long userId) {
		Date today = new Date();
		return reminderRepo.findAllActiveReminders(today, userId);
	}
	
	public void destroyReminder(Long id) {
		reminderRepo.deleteById(id);
	}
	
	public void destroyAllReminders(Long userId) {
		Date today = new Date();
		reminderRepo.clearAllReminders(today, userId);
	}
}
