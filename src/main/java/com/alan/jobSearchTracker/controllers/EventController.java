package com.alan.jobSearchTracker.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alan.jobSearchTracker.models.Event;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.EventService;
import com.alan.jobSearchTracker.validators.EventValidator;

@Controller
public class EventController {
	
	private final EventValidator eValidator;
	private final EventService eService;
	
	public EventController(EventValidator eValidator, EventService eService) {
		this.eValidator = eValidator;
		this.eService = eService;
	}

	@RequestMapping("/events")
	public String events(@ModelAttribute("event") Event event, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
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
}
