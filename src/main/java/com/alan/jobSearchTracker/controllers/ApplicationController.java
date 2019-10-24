package com.alan.jobSearchTracker.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			
			List<Application> apps = applicationService.findAppsByCreatedDesc((Long) session.getAttribute("userId"));
			model.addAttribute("apps", apps);
			return "dashboard.jsp";
		}
		else {
			application.setUser((User) session.getAttribute("user"));
			Application newApp = applicationService.newApplication(application);
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping(value = "/applications/{id}", method = RequestMethod.POST)
	public String updateApplication(@PathVariable("id") Long appId, RedirectAttributes ra, @RequestParam("companyName") String companyName, @RequestParam("dateOfSubmission") String dateOfSubmission, @RequestParam("jobTitle") String jobTitle, @RequestParam("jobPostLink") String jobPostLink, @RequestParam("city") String city, @RequestParam("state") String state, @RequestParam("resumeLink") String resumeLink, @RequestParam("coverLetterLink") String coverLetterLink, @RequestParam("coverLetter") String coverLetter) throws Exception {
		
		//validation
		boolean validation = true;
		
		if (companyName.length() < 1) {
			ra.addFlashAttribute("companyNameError", "this field cannot be empty");
			validation = false;
		}
		
		if (dateOfSubmission.length() < 1) {
			ra.addFlashAttribute("dateOfSubmissionError", "this field cannot be empty");
			validation = false;
		}
		else {
			Date today = new Date();
			Date dos = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfSubmission);
			if (dos.compareTo(today) > 0) {
				ra.addFlashAttribute("dateOfSubmissionError", "please enter a valid field");
				validation = false;
			}
		}
		
		if (jobTitle.length() < 1) {
			ra.addFlashAttribute("jobTitleError", "this field cannot be empty");
			validation = false;
		}
		
		if (validation) {
			Application a = applicationService.findApplication(appId);
			
			a.setCompanyName(companyName);
			a.setJobPostLink(jobPostLink);
			
			Date dos = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfSubmission);
			
			a.setDateOfSubmission(dos);
			a.setJobTitle(jobTitle);
			a.setCity(city);
			a.setState(state);
			a.setResumeLink(resumeLink);
			a.setCoverLetterLink(coverLetterLink);
			a.setCoverLetter(coverLetter);
			
			applicationService.updateApplication(a);
			return "redirect:/dashboard";
		}
		else {
			ra.addFlashAttribute("editError", "#editApplication" + appId);
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
