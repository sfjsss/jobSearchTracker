package com.alan.jobSearchTracker.services;

import java.util.List;

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
}
