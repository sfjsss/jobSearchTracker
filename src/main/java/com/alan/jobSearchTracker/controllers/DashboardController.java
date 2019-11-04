package com.alan.jobSearchTracker.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
public class DashboardController {
	
	private final UserService userService;
	private final ApplicationService appService;
	private final ReminderService reminderService;
	
	public DashboardController(UserService userService, ApplicationService appService, ReminderService reminderService) {
		this.userService = userService;
		this.appService = appService;
		this.reminderService = reminderService;
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
			List<Application> apps = appService.findAppsByCreatedDesc(userId);
			session.setAttribute("apps", apps);
			List<Reminder> reminders = reminderService.findActiveReminders(userId);
			session.setAttribute("reminders", reminders);
			
			Calendar m = Calendar.getInstance();
			m.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
			m.set(Calendar.HOUR_OF_DAY, 0);
			m.set(Calendar.MINUTE, 0);
			m.set(Calendar.SECOND, 0);
			m.set(Calendar.MILLISECOND, 0);
			
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
	
	@RequestMapping(value = "/weeklyAppGoals", method = RequestMethod.POST)
	public String changeWeeklyAppGoals(HttpSession session, @RequestParam("appWeeklyGoal") int appWeeklyGoal, RedirectAttributes ra, HttpServletRequest request) {
		Long userId = (Long) session.getAttribute("userId");
		User u = userService.findUserById(userId);
		boolean validation = true;
		
		if (appWeeklyGoal <= 0) {
			ra.addFlashAttribute("appWeeklyGoalError", "this number needs to be greater or equal to 1");
			validation = false;
		}
		
		if (validation) {
			u.setWeeklyJobApplicationGoal(appWeeklyGoal);
			userService.updateUser(u);
		}
		else {
			ra.addFlashAttribute("flashError", true);
		}
		
		String referer = request.getHeader("referer");
		return "redirect:" + referer;
	}
	
	@RequestMapping(value = "/weeklyEventGoals", method = RequestMethod.POST)
	public String changeWeeklyEventGoals(HttpSession session, @RequestParam("eventWeeklyGoal") int eventWeeklyGoal, RedirectAttributes ra, HttpServletRequest request) {
		Long userId = (Long) session.getAttribute("userId");
		User u = userService.findUserById(userId);
		boolean validation = true;
		
		if (eventWeeklyGoal <= 0) {
			ra.addFlashAttribute("eventWeeklyGoalError", "this number needs to be greater or equal to 1");
			validation = false;
		}
		
		if (validation) {
			u.setWeeklyNetworkEventGoal(eventWeeklyGoal);
			userService.updateUser(u);
		}
		else {
			ra.addFlashAttribute("flashError", true);
		}
		
		String referer = request.getHeader("referer");
		return "redirect:" + referer;
	}
	
	
	
	@RequestMapping(value = "/filterApplications", method = RequestMethod.POST)
	public String filterApplications(@RequestParam("status") String status, @RequestParam("fromDate") String fromDate, @RequestParam("endDate") String endDate, RedirectAttributes ra) {
		
		if (!status.equals("all") && fromDate.equals("") && endDate.equals("")) {
			return "redirect:/filterAppResults?status=" + status;
		}
		else if (status.equals("all") && !fromDate.equals("") && !endDate.equals("")) {
			return "redirect:/filterAppResults?fromDate=" + fromDate + "&endDate=" + endDate;
		}
		else if (!status.equals("all") && !fromDate.equals("") && !endDate.equals("")) {
			return "redirect:/filterAppResults?status=" + status + "&fromDate=" + fromDate + "&endDate=" +endDate;
		}
		else {
			ra.addFlashAttribute("filterError", "please enter a valid condition");
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping(value = "/searchApplications", method = RequestMethod.POST)
	public String searchApplications(@RequestParam("keyword") String keyword, RedirectAttributes ra, HttpServletRequest request) {
		if (keyword.equals("")) {
			ra.addFlashAttribute("searchError", "this field cannot be empty");
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
		}
		else {
			return "redirect:/filterAppResults?keyword=" + keyword;
		}
	}
	
	@RequestMapping("/filterAppResults")
	public String filterAppResults(@RequestParam(value = "status", required = false) String status, @RequestParam(value = "fromDate", required = false) String fromDate, @RequestParam(value = "endDate", required = false) String endDate, @RequestParam(value = "keyword", required = false) String keyword, HttpSession session, Model model, @ModelAttribute("application") Application application) throws Exception{
		
		if (session.getAttribute("userId") == null) {
			return "redirect:/login";
		}
		
		Long userId = (Long) session.getAttribute("userId");
		User updatedUser = userService.findUserById(userId);
		session.setAttribute("user", updatedUser);
		User u = (User) session.getAttribute("user");
		List<Application> searchResults = new ArrayList<Application>();
		
		if (status != null && fromDate == null && endDate == null) {
			searchResults = appService.findAppByStatus(status, userId);
		}
		else if (status == null && fromDate != null && endDate != null) {
			Date fd = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
			Date ed = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
			searchResults = appService.findAppByTime(fd, ed, userId);
		}
		else if (status != null && fromDate != null && endDate != null) {
			Date fd = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
			Date ed = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
			searchResults = appService.findAppByStatusAndTime(status, fd, ed, userId);
		}
		else {
			List<Application> results = appService.findAppByKeyword(keyword, userId);
			searchResults.addAll(results);
		}
		model.addAttribute("searchResults", searchResults);
		return "filterAppResults.jsp";
	}
	
	//render shareLink
	
	@RequestMapping("/shareLink")
	public String shareLinkPage(@RequestParam(value = "userId", required = true) Long userId, @RequestParam(value = "email", required = true) String email, HttpSession session) {
		
		//validation
		
		User u = userService.findUserById(userId);
		String userEmail = u.getEmail();
		
		if (!userEmail.equals(email)) {
			return "redirect:/login";
		}
		
		//render page
		
		session.setAttribute("user", u);
		List<Application> apps = appService.findAppsByCreatedDesc(userId);
		session.setAttribute("apps", apps);
		
		return "guestDashboard.jsp";
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
