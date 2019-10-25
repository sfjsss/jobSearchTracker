package com.alan.jobSearchTracker.repositories;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Contact;

public interface ContactRepository extends CrudRepository<Contact, Long> {

}
