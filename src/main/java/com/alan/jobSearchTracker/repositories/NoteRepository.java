package com.alan.jobSearchTracker.repositories;

import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Note;

public interface NoteRepository extends CrudRepository<Note, Long> {

}
