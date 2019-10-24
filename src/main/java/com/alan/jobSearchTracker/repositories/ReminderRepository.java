package com.alan.jobSearchTracker.repositories;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Reminder;

public interface ReminderRepository extends CrudRepository<Reminder, Long> {
	
}
