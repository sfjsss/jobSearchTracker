package com.alan.jobSearchTracker.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Event;

public interface EventRepository extends CrudRepository<Event, Long> {
	
	@Query(value = "SELECT * FROM events WHERE user_id = ?1 ORDER BY created_at DESC", nativeQuery = true)
	List<Event> findEventsByUserId(Long userId);
	
	@Query(value = "SELECT * FROM events WHERE user_id = ?1 AND event_date >= ?2 AND event_date <=?3 ORDER BY created_at DESC", nativeQuery = true)
	List<Event> findEventsByTime(Long userId, Date fromDate, Date endDate);
	
	List<Event> findByUserIdAndNameOrLocationContaining(Long userId, String name, String location);
}
