package com.alan.jobSearchTracker.repositories;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Event;

public interface EventRepository extends CrudRepository<Event, Long> {

}
