package com.alan.jobSearchTracker.services;

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
}
