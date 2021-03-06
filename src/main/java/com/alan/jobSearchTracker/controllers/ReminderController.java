package com.alan.jobSearchTracker.controllers;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.Application;
import com.alan.jobSearchTracker.models.Reminder;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.ApplicationService;
import com.alan.jobSearchTracker.services.ReminderService;
import com.alan.jobSearchTracker.services.UserService;

@Controller
public class ReminderController {
	
	private final ApplicationService appService;
	private final ReminderService reminderService;
	private final UserService userService;
	
	public ReminderController(ApplicationService appService, ReminderService reminderService, UserService userService) {
		this.appService = appService;
		this.reminderService = reminderService;
		this.userService = userService;
	}
	
	@RequestMapping("/reminders")
	public String reminders(HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
		
		
		List<Reminder> reminders = reminderService.findActiveReminders((Long) session.getAttribute("userId"));
		session.setAttribute("reminders", reminders);
		return "reminders.jsp";
	}

	@RequestMapping(value = "/addReminder", method = RequestMethod.POST)
	public String newReminder(@RequestParam("appId") Long appId, @RequestParam("remindDate") String remindDate, RedirectAttributes ra, HttpSession session, @RequestParam("message") String message, HttpServletRequest request) throws Exception {
		
		//validation
		
		boolean validation = true;
		Date rdid = new Date();
		Calendar rd = Calendar.getInstance();
		Calendar today = Calendar.getInstance();
		today.set(Calendar.HOUR_OF_DAY, 0);
		today.set(Calendar.MINUTE, 0);
		today.set(Calendar.SECOND, 0);
		today.set(Calendar.MILLISECOND, 0);
		
		if (message.length() < 1) {
			ra.addFlashAttribute("messageError", "this field cannot be empty");
			validation = false;
		}
		
		if (remindDate.length() < 1) {
			ra.addFlashAttribute("remindDateError", "this field cannot be empty");
			validation = false;
		}
		else {
			rdid = new SimpleDateFormat("yyyy-MM-dd").parse(remindDate);
			rd.setTime(rdid);
			if (rd.compareTo(today) < 0) {
				ra.addFlashAttribute("remindDateError", "please enter a valid date");
				validation = false;
			}
		}
		
		if (validation) {
			User u = userService.findUserById((Long) session.getAttribute("userId"));
			Application a = appService.findApplication(appId);
			Reminder r = new Reminder();
			r.setReminderDate(rdid);
			r.setMessage(message);
			r.setApplication(a);
			r.setUser(u);
			reminderService.create(r);
		}
		else {
			ra.addFlashAttribute("reminderError", "#addReminder" + appId);
		}
		
		String referer = request.getHeader("referer");
		return "redirect:" + referer;
	}
	
	@RequestMapping("/clearReminder/{reminderId}")
	public String clearReminder(@PathVariable("reminderId") Long id, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
		
		
		if (session.getAttribute("userId") != null) {
			reminderService.destroyReminder(id);
		}
		return "redirect:/reminders";
	}
	
	@RequestMapping("/clearAllReminders")
	public String clearAllReminders(HttpSession session) {
		if (session.getAttribute("userId") != null) {
			reminderService.destroyAllReminders((Long) session.getAttribute("userId"));
		}
		return "redirect:/reminders";
	}
	
	
	
	
	
	
	
	
	
}
