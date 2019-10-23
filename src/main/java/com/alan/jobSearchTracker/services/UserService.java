package com.alan.jobSearchTracker.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.repositories.UserRepository;

@Service
public class UserService {

	private final UserRepository userRepo;
	
	public UserService(UserRepository userRepo) {
		this.userRepo = userRepo;
	}
	
	//register user and hash the password
	
	public User registerUser(User user) {
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashed);
		return userRepo.save(user);
	}
	
	//find user by email
	
	public User findByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
	//find user by id
	
	public User findUserById(Long id) {
		Optional<User> u = userRepo.findById(id);
		
		if (u.isPresent()) {
			return u.get();
		}
		else {
			return null;
		}
	}
	
	//authenticate user
	
	public boolean authenticateUser(String email, String password) {
		User user = userRepo.findByEmail(email);
		
		if (user == null) {
			return false;
		}
		else {
			if (BCrypt.checkpw(password, user.getPassword())) {
				return true;
			}
			else {
				return false;
			}
		}
	}
	
	//update user
	
	public User updateUser(User user) {
		return userRepo.save(user);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
