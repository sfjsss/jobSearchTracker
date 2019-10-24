package com.alan.jobSearchTracker.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Application;

public interface ApplicationRepository extends CrudRepository<Application, Long> {

	@Query(value = "SELECT * FROM applications WHERE status = ?1 AND user_id = ?2 ORDER BY created_at DESC", nativeQuery = true)
	List<Application> findAppByStatus(String status, Long userId);
	
	@Query(value = "SELECT * FROM applications WHERE date_of_submission >= ?1 AND date_of_submission <= ?2 AND user_id = ?3 ORDER BY created_at DESC", nativeQuery = true)
	List<Application> findAppByTime(Date fromDate, Date endDate, Long userId);
	
	@Query(value = "SELECT * FROM applications WHERE status = ?1 AND date_of_submission >= ?2 AND date_of_submission <=?3 AND user_id = ?4 ORDER BY created_at DESC", nativeQuery = true)
	List<Application> findAppByStatusAndTime(String status, Date fromDate, Date endDate, Long userId);
	
	@Query(value = "SELECT * FROM applications WHERE user_id = ?2 AND company_name = ?1 OR job_title = ?1 OR city = ?1 OR state = ?1 ORDER BY created_at DESC", nativeQuery = true)
	List<Application> findAppByKeyword(String keyword, Long userId);
	
	@Query(value = "SELECT * FROM applications WHERE user_id = ?1 ORDER BY created_at DESC", nativeQuery = true)
	List<Application> findAppsByCreatedAtDesc(Long userId);
}
