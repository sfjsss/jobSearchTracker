package com.alan.jobSearchTracker.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.Contact;
import com.alan.jobSearchTracker.models.Event;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.ContactService;
import com.alan.jobSearchTracker.services.EventService;

@Controller
public class ContactController {
	
	private final EventService eService;
	private final ContactService contactService;
	
	public ContactController(EventService eService, ContactService contactService) {
		this.eService = eService;
		this.contactService = contactService;
	}

	@RequestMapping(value = "/addContact", method = RequestMethod.POST)
	public String addContact(@RequestParam("eventId") Long eventId, @RequestParam("name") String name, @RequestParam("number") String number, @RequestParam("email") String email, @RequestParam("linkedIn") String linkedIn, @RequestParam("description") String description, HttpSession session, RedirectAttributes ra, HttpServletRequest request) {
		
		if (name.length() < 1) {
			ra.addFlashAttribute("contactNameError", "this field cannot be empty");
			ra.addFlashAttribute("contactError", "#addContact" + eventId);
		}
		else {
			User u = (User) session.getAttribute("user");
			Event e = eService.findEventById(eventId);
			Contact newContact = new Contact();
			
			newContact.setName(name);
			newContact.setNumber(number);
			newContact.setEmail(email);
			newContact.setLinkedIn(linkedIn);
			newContact.setDescription(description);
			newContact.setUser(u);
			newContact.setEvent(e);
			
			contactService.createContact(newContact);
		}
		
		String referer = request.getHeader("referer");
		return "redirect:" + referer;
		
		
		
		
	}
}
