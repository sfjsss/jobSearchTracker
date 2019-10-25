package com.alan.jobSearchTracker.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.alan.jobSearchTracker.models.Reminder;

public interface ReminderRepository extends CrudRepository<Reminder, Long> {
	
	@Query(value = "SELECT * FROM reminders WHERE reminder_date <= ?1 AND user_id = ?2 ORDER BY reminder_date DESC", nativeQuery = true)
	List<Reminder> findAllActiveReminders(Date today, Long userId);
	
	@Modifying
	@Transactional
	@Query("delete Reminder r WHERE r.reminderDate <= ?1 and r.user.id = ?2")
	void clearAllReminders(Date today, Long userId);
}
