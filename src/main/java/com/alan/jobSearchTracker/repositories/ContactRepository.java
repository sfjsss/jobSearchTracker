package com.alan.jobSearchTracker.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Contact;

public interface ContactRepository extends CrudRepository<Contact, Long> {
	
	//get all contacts from a user
	
	List<Contact> findAllByUserIdOrderByCreatedAtDesc(Long userId);
	
	//find contacts by keyword
	
	List<Contact> findByUserIdAndNameContainingOrDescriptionContainingOrderByCreatedAtDesc(Long userId, String name, String description);
}
