package com.alan.jobSearchTracker.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Reminder;

public interface ReminderRepository extends CrudRepository<Reminder, Long> {
	
	@Query(value = "SELECT * FROM reminders WHERE reminder_date <= ?1 AND user_id = ?2", nativeQuery = true)
	List<Reminder> findAllActiveReminders(Date today, Long userId);
}
