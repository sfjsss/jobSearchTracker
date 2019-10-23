package com.alan.jobSearchTracker.repositories;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Application;

public interface ApplicationRepository extends CrudRepository<Application, Long> {

	
}
