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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.User;
import com.alan.jobSearchTracker.services.UserService;
import com.alan.jobSearchTracker.validators.UserValidator;

@Controller
public class UserController {
	
	private final UserValidator userValidator;
	private final UserService userService;
	
	public UserController(UserValidator userValidator, UserService userService) {
		this.userValidator = userValidator;
		this.userService = userService;
	}

	@RequestMapping("/")
	public String index(HttpSession session) {
		if (session.getAttribute("userId") != null) {
			return "redirect:/dashboard";
		}
		else {
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/login")
	public String login() {
		return "login.jsp";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, RedirectAttributes ra) {
		if (userService.authenticateUser(email, password)) {
			User u = userService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/dashboard";
		}
		else {
			ra.addFlashAttribute("loginError", "the email and password do not match");
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/register")
	public String register(@ModelAttribute("user") User user) {
		return "register.jsp";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "register.jsp";
		}
		else {
			User u = userService.registerUser(user);
			session.setAttribute("userId", u.getId());
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.setAttribute("userId", null);
		session.setAttribute("user", null);
		return "redirect:/login";
	}
}
