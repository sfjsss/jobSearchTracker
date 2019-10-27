package com.alan.jobSearchTracker.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.Contact;
import com.alan.jobSearchTracker.models.Event;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.ContactService;
import com.alan.jobSearchTracker.services.EventService;
import com.alan.jobSearchTracker.services.UserService;

@Controller
public class ContactController {
	
	private final EventService eService;
	private final ContactService contactService;
	private final UserService uService;
	
	public ContactController(EventService eService, ContactService contactService, UserService uService) {
		this.eService = eService;
		this.contactService = contactService;
		this.uService = uService;
	}
	
	// render contact page
	
	@RequestMapping(value = "/contacts")
	public String contacts(HttpSession session, @ModelAttribute("contact") Contact contact) {
		// check if user has logged in
		
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
		
		// render the contacts page
		
		// put user in session
		
		Long uId = (Long) session.getAttribute("userId");
		User u = uService.findUserById(uId);
		session.setAttribute("user", u);
		
		// retrieve all contacts from current user, and put in session
		
		List<Contact> contacts = contactService.findAllContactsForAUser(uId);
		session.setAttribute("contacts", contacts);
		
		return "contacts.jsp";
	}
	
	// add contact from contact page
	
	@RequestMapping(value = "/contacts", method = RequestMethod.POST)
	public String createContact(@Valid @ModelAttribute("contact") Contact contact, BindingResult result, Model model, HttpSession session) {
		if (result.hasErrors()) {
			
			// set error to be true so modal would pop
			
			model.addAttribute("error", true);
			return "contacts.jsp";
		}
		else {
			
			// get the user to attach
			
			User u = (User) session.getAttribute("user");
			
			// attach the contact to the user
			
			contact.setUser(u);
			
			// create the contact
			
			contactService.createContact(contact);
			
			return "redirect:/contacts";
		}
	}
	
	// add contact from network event page

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
