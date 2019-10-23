package com.alan.jobSearchTracker.controllers;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.Application;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.UserService;

@Controller
public class DashboardController {
	
	private final UserService userService;
	
	public DashboardController(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping("/dashboard")
	public String dashbaord(HttpSession session, Model model, @ModelAttribute("application") Application application) {
		Long userId = (Long) session.getAttribute("userId");
		User u;
		
		if (userId == null) {
			return "redirect:/login";
		}
		else {
			u = userService.findUserById(userId);
			session.setAttribute("user", u);
			
			Calendar m = Calendar.getInstance();
			m.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
			
			List<Application> thisWeekApps = new ArrayList<Application>();
			
			for (Application a : u.getApplications()) {
				if (a.getDateOfSubmission().compareTo(m.getTime()) >= 0) {
					thisWeekApps.add(a);
				}
			}
			
			session.setAttribute("thisWeekApps", thisWeekApps);
			
			return "dashboard.jsp";
		}
		
	}
	
	@RequestMapping(value = "/weeklyGoals", method = RequestMethod.POST)
	public String changeWeeklyGoals(HttpSession session, @RequestParam("appWeeklyGoal") int appWeeklyGoal, @RequestParam("eventWeeklyGoal") int eventWeeklyGoal, RedirectAttributes ra) {
		Long userId = (Long) session.getAttribute("userId");
		User u = userService.findUserById(userId);
		boolean validation = true;
		
		if (appWeeklyGoal <= 0) {
			ra.addFlashAttribute("appWeeklyGoalError", "this number needs to be greater or equal to 1");
			validation = false;
		}
		if (eventWeeklyGoal <= 0) {
			ra.addFlashAttribute("eventWeeklyGoalError", "this number needs to be greater or equal to 1");
			validation = false;
		}
		
		if (validation) {
			u.setWeeklyJobApplicationGoal(appWeeklyGoal);
			u.setWeeklyNetworkEventGoal(eventWeeklyGoal);
			userService.updateUser(u);
		}
		else {
			ra.addFlashAttribute("flashError", true);
		}
		
		return "redirect:/dashboard";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
