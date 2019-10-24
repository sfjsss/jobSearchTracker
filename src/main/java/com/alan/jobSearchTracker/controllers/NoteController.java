package com.alan.jobSearchTracker.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alan.jobSearchTracker.models.Application;
import com.alan.jobSearchTracker.models.Note;
import com.alan.jobSearchTracker.services.ApplicationService;
import com.alan.jobSearchTracker.services.NoteService;

@Controller
public class NoteController {
	
	private final ApplicationService appService;
	private final NoteService noteService;
	
	public NoteController(ApplicationService appService, NoteService noteService) {
		this.appService = appService;
		this.noteService = noteService;
	}

	@RequestMapping(value = "/addNote", method = RequestMethod.POST)
	public String addNote(@RequestParam("note") String note, RedirectAttributes ra, @RequestParam("appId") Long appId, HttpServletRequest request) {
		if (note.length() < 1) {
			ra.addFlashAttribute("contentError", "this field cannot be empty");
			ra.addFlashAttribute("noteError", "#viewApplication" + appId);
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
		}
		else {
			Application a = appService.findApplication(appId);
			Note newNote = new Note();
			newNote.setApplication(a);
			newNote.setContent(note);
			noteService.createNote(newNote);
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
		}
	}
}
