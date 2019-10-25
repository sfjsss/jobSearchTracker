package com.alan.jobSearchTracker.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EventController {

	@RequestMapping("/events")
	public String events() {
		return "events.jsp";
	}
}
