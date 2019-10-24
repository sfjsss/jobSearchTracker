package com.alan.jobSearchTracker.services;

import org.springframework.stereotype.Service;

import com.alan.jobSearchTracker.models.Note;
import com.alan.jobSearchTracker.repositories.NoteRepository;

@Service
public class NoteService {

	private final NoteRepository noteRepo;
	
	public NoteService(NoteRepository noteRepo) {
		this.noteRepo = noteRepo;
	}
	
	public Note createNote(Note n) {
		return noteRepo.save(n);
	}
}
