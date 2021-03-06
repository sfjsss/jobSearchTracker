package com.alan.jobSearchTracker.controllers;

import java.util.ArrayList;
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
	
	// update contact
	
	@RequestMapping(value = "/contacts/{contactId}", method = RequestMethod.POST)
	public String updateContact(@PathVariable("contactId") Long contactId, @RequestParam("name") String name, @RequestParam("number") String number, @RequestParam("email") String email, @RequestParam("linkedIn") String linkedIn, @RequestParam("description") String description, RedirectAttributes ra, HttpServletRequest request, HttpSession session) {
		
		//validation
		
		if (name.length() < 1) {
			
			//set error message and inform modal to pop
			
			ra.addFlashAttribute("nameError", "this field cannot be empty");
			ra.addFlashAttribute("editError", "#editContact" + contactId);
			
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
		}
		else {
			
			//find the target contact
			
			Contact c = contactService.findContactById(contactId);
			
			//retrieve the user to attach and attach it
			
			User u = (User) session.getAttribute("user");
			c.setUser(u);
			
			//update the contact
			
			c.setName(name);
			c.setNumber(number);
			c.setEmail(email);
			c.setLinkedIn(linkedIn);
			c.setDescription(description);
			
			contactService.updateContact(c);
			
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
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
	
	//generate the search link
	
	@RequestMapping(value = "/searchContacts", method = RequestMethod.POST)
	public String searchContacts(@RequestParam("keyword") String keyword, RedirectAttributes ra, HttpServletRequest request) {
		
		if (keyword.equals("")) {
			ra.addFlashAttribute("searchError", "this field cannot be empty");
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
		}
		else {
			return "redirect:/filterContactResults?keyword=" + keyword;
		}
	}
	
	//render search results
	
	@RequestMapping("/filterContactResults")
	public String filterContactResults(@RequestParam(value = "keyword", required = true) String keyword, HttpSession session, @ModelAttribute("contact") Contact contact) {
		
		//validation on user's login status
		
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
		
		//retrieve the user's id
		
		Long userId = (Long) session.getAttribute("userId");
		
		//retrieve the search results
		
		List<Contact> searchResults = new ArrayList<Contact>();
		searchResults = contactService.findContactsByKeyword(userId, keyword);
		
		//render the search results
		
		session.setAttribute("contacts", searchResults);
		
		return "contacts.jsp";
	}
	 
	
	
	
	
	
}
