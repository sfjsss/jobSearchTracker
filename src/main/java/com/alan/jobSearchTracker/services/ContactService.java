package com.alan.jobSearchTracker.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.alan.jobSearchTracker.models.Contact;
import com.alan.jobSearchTracker.repositories.ContactRepository;

@Service
public class ContactService {

	private final ContactRepository contactRepo;
	
	public ContactService(ContactRepository contactRepo) {
		this.contactRepo = contactRepo;
	}
	
	public Contact createContact(Contact c) {
		return contactRepo.save(c);
	}
	
	// get all contacts from a user
	
	public List<Contact> findAllContactsForAUser(Long userId) {
		return contactRepo.findAllByUserIdOrderByCreatedAtDesc(userId);
	}
	
	//find a contact by contact id
	
	public Contact findContactById(Long contactId) {
		Optional<Contact> c = contactRepo.findById(contactId);
		
		if (c.isPresent()) {
			return c.get();
		}
		else {
			return null;
		}
	}
	
	//update a contact
	
	public Contact updateContact(Contact c) {
		return contactRepo.save(c);
	}
}
