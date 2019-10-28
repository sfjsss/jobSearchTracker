package com.alan.jobSearchTracker.services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.alan.jobSearchTracker.models.Event;
import com.alan.jobSearchTracker.repositories.EventRepository;

@Service
public class EventService {

	private final EventRepository eRepo;
	
	public EventService(EventRepository eRepo) {
		this.eRepo = eRepo;
	}
	
	public Event createEvent(Event e) {
		return eRepo.save(e);
	}
	
	public List<Event> findEventsByUserId(Long userId) {
		return eRepo.findEventsByUserId(userId);
	}
	
	public Event findEventById(Long eventId) {
		Optional<Event> e = eRepo.findById(eventId);
		if (e.isPresent()) {
			return e.get();
		}
		else {
			return null;
		}
	}
	
	public Event updateEvent(Event e) {
		return eRepo.save(e);
	}
	
	public List<Event> findEventsByTime(Long userId, Date fromDate, Date endDate) {
		return eRepo.findEventsByTime(userId, fromDate, endDate);
	}
	
	public List<Event> findEventsByKeyword(Long userId, String keyword) {
		return eRepo.findByUserIdAndNameOrLocationContainingOrderByCreatedAtDesc(userId, keyword, keyword);
	}
}
