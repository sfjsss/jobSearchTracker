package com.alan.jobSearchTracker.repositories;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.User;

public interface UserRepository extends CrudRepository<User, Long> {

	User findByEmail(String email);
}
