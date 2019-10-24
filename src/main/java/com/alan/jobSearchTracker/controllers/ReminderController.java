package com.alan.jobSearchTracker.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
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

	@RequestMapping(value = "/addReminder", method = RequestMethod.POST)
	public String newReminder(@RequestParam("appId") Long appId, @RequestParam("remindDate") String remindDate, RedirectAttributes ra, HttpSession session) throws Exception {
		if (remindDate.length() < 1) {
			ra.addFlashAttribute("reminderError", "#addReminder" + appId);
			ra.addFlashAttribute("remindDateError", "this field cannot be empty");
		}
		else {
			Date today = new Date();
			Date rd = new SimpleDateFormat("yyyy-MM-dd").parse(remindDate);
			if (rd.compareTo(today) <= 0) {
				ra.addFlashAttribute("reminderError", "#addReminder" + appId);
				ra.addFlashAttribute("remindDateError", "please enter a valid date");
			}
			else {
				User u = userService.findUserById((Long) session.getAttribute("userId"));
				Application a = appService.findApplication(appId);
				Reminder r = new Reminder();
				r.setReminderDate(rd);
				r.setApplication(a);
				r.setUser(u);
				reminderService.create(r);
			}
		}
		return "redirect:/dashboard";
	}
}
