package com.alan.jobSearchTracker.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	//fields entered during registration
	
	@Size(min = 1, message = "this field is required")
	private String firstName;
	
	@Size(min = 1, message = "this field is required")
	private String lastName;
	
	@Email(message = "please enter a valid email")
	@Size(min = 1, message = "this field is required")
	private String email;
	
	private boolean careerCoach;
	
	@Size(min = 8, message = "password needs to have at least 8 characters")
	private String password;
	
	@Transient
	private String passwordConfirmation;
	
	//fields entered in settings
	
	private String geneder;
	
	private Date birthday;
	
	private String city;
	
	private String state;
	
	private int weeklyJobApplicationGoal = 10;
	
	private int weeklyNetworkEventGoal = 2;
	
	//time stamp
	
	@Column(updatable = false)
	private Date createdAt;
	private Date updatedAt;
	
	//relationships
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Application> applications;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Event> events;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Contact> contacts;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Reminder> reminders;
	
	//constructor
	
	public User() {
		
	}
	
	//getters and setters

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isCareerCoach() {
		return careerCoach;
	}

	public void setCareerCoach(boolean careerCoach) {
		this.careerCoach = careerCoach;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}

	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
	}

	public String getGeneder() {
		return geneder;
	}

	public void setGeneder(String geneder) {
		this.geneder = geneder;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getWeeklyJobApplicationGoal() {
		return weeklyJobApplicationGoal;
	}

	public void setWeeklyJobApplicationGoal(int weeklyJobApplicationGoal) {
		this.weeklyJobApplicationGoal = weeklyJobApplicationGoal;
	}

	public int getWeeklyNetworkEventGoal() {
		return weeklyNetworkEventGoal;
	}

	public void setWeeklyNetworkEventGoal(int weeklyNetworkEventGoal) {
		this.weeklyNetworkEventGoal = weeklyNetworkEventGoal;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<Application> getApplications() {
		return applications;
	}

	public void setApplications(List<Application> applications) {
		this.applications = applications;
	}

	public List<Event> getEvents() {
		return events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}

	public List<Contact> getContacts() {
		return contacts;
	}

	public void setContacts(List<Contact> contacts) {
		this.contacts = contacts;
	}
	
	public List<Reminder> getReminders() {
		return reminders;
	}

	public void setReminders(List<Reminder> reminders) {
		this.reminders = reminders;
	}

	//time stamp generation
	
	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}
	
	
	
	
}
