package com.alan.jobSearchTracker.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.Event;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.EventService;
import com.alan.jobSearchTracker.services.UserService;
import com.alan.jobSearchTracker.validators.EventValidator;

@Controller
public class EventController {
	
	private final EventValidator eValidator;
	private final EventService eService;
	private final UserService uService;
	
	public EventController(EventValidator eValidator, EventService eService, UserService uService) {
		this.eValidator = eValidator;
		this.eService = eService;
		this.uService = uService;
	}

	@RequestMapping("/events")
	public String events(@ModelAttribute("event") Event event, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
		Long userId = (Long) session.getAttribute("userId");
		List<Event> events = eService.findEventsByUserId(userId);
		session.setAttribute("events", events);
		User updatedUser = uService.findUserById(userId);
		session.setAttribute("user", updatedUser);
		
		//get this week's events
		
		Calendar m = Calendar.getInstance();
		m.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		Calendar s = Calendar.getInstance();
		s.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		
		List<Event> thisWeekEvents = new ArrayList<Event>();
		
		for (Event e : updatedUser.getEvents()) {
			if (e.getEventDate().compareTo(m.getTime()) >= 0 && e.getEventDate().compareTo(s.getTime()) <= 0) {
				thisWeekEvents.add(e);
			}
		}
		
		session.setAttribute("thisWeekEvents", thisWeekEvents);
		
		return "events.jsp";
	}
	
	@RequestMapping(value = "/events", method = RequestMethod.POST)
	public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, Model model, HttpSession session) {
		eValidator.validate(event, result);
		if (result.hasErrors()) {
			model.addAttribute("eventModalError", true);
			System.out.println("there was an error");
			return "events.jsp";
		}
		else {
			User u = (User) session.getAttribute("user");
			event.setUser(u);
			eService.createEvent(event);
			return "redirect:/events";
		}
	}
	
	@RequestMapping(value = "/events/{eventId}", method = RequestMethod.POST)
	public String updateEvent(@PathVariable("eventId") Long eventId, RedirectAttributes ra, @RequestParam("name") String name, @RequestParam("link") String link, @RequestParam("eventDate") String eventDate, @RequestParam("location") String location, @RequestParam("notes") String notes, HttpServletRequest request, HttpSession session) throws Exception {
		
		//validation
		boolean validation = true;
		
		if (name.length() < 1) {
			ra.addFlashAttribute("nameError", "this field cannot be empty");
			validation = false;
		}
		if (eventDate.length() < 1) {
			ra.addFlashAttribute("eventDateError", "this field cannot be empty");
			validation = false;
		}
		
		if (validation) {
			Event e = eService.findEventById(eventId);
			Date doe = new SimpleDateFormat("yyyy-MM-dd").parse(eventDate);
			
			e.setName(name);
			e.setLink(link);
			e.setEventDate(doe);
			e.setLocation(location);
			e.setNotes(notes);
			
			eService.updateEvent(e);	
		}
		else {
			ra.addFlashAttribute("editError", "#editEvent" + eventId);
		}
		
		String referer = request.getHeader("referer");
		return "redirect:" + referer;
	}
	
	
	
	
	
	
	
	
}
