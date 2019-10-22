package com.alan.jobSearchTracker.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alan.jobSearchTracker.models.Reminder;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.UserService;

@Controller
public class DashboardController {
	
	private final UserService userService;
	
	public DashboardController(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping("/dashboard")
	public String dashbaord(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User u;
		
		if (userId == null) {
			return "redirect:/login";
		}
		else {
			u = userService.findUserById(userId);
			model.addAttribute("user", u);
		}
		return "dashboard.jsp";
	}
}
