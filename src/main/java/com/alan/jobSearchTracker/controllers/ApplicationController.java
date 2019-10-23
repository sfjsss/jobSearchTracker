package com.alan.jobSearchTracker.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alan.jobSearchTracker.models.Application;
import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.ApplicationService;
import com.alan.jobSearchTracker.validators.ApplicationValidator;

@Controller
public class ApplicationController {
	
	private final ApplicationService applicationService;
	private final ApplicationValidator appValidator;
	
	public ApplicationController(ApplicationService applicationService, ApplicationValidator appValidator) {
		this.applicationService = applicationService;
		this.appValidator = appValidator;
	}

	@RequestMapping(value = "/applications", method = RequestMethod.POST)
	public String createApplication(@Valid @ModelAttribute("application") Application application, BindingResult result, Model model, HttpSession session) {
		appValidator.validate(application, result);
		if (result.hasErrors()) {
			model.addAttribute("error", true);
			return "dashboard.jsp";
		}
		else {
			application.setUser((User) session.getAttribute("user"));
			Application newApp = applicationService.newApplication(application);
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping(value = "/changeStatus", method = RequestMethod.POST)
	public String changeStatus(@RequestParam("status") String status, @RequestParam("applicationId") Long appId) {
		Application app = applicationService.findApplication(appId);
		app.setStatus(status);
		applicationService.updateApplication(app);
		return "redirect:/dashboard";
	}
	
	
	
	
	
	
	
}
