package com.alan.jobSearchTracker.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.alan.jobSearchTracker.models.Application;

public interface ApplicationRepository extends CrudRepository<Application, Long> {

	@Query(value = "SELECT * FROM applications WHERE status = ?1", nativeQuery = true)
	List<Application> findAppByStatus(String status);
	
	@Query(value = "SELECT * FROM applications WHERE date_of_submission >= ?1 AND date_of_submission <= ?2", nativeQuery = true)
	List<Application> findAppByTime(Date fromDate, Date endDate);
	
	@Query(value = "SELECT * FROM applications WHERE status = ?1 AND date_of_submission >= ?2 AND date_of_submission <=?3", nativeQuery = true)
	List<Application> findAppByStatusAndTime(String status, Date fromDate, Date endDate);
	
	@Query(value = "SELECT * FROM applications WHERE company_name = ?1 OR job_title = ?1 OR city = ?1 OR state = ?1", nativeQuery = true)
	List<Application> findAppByKeyword(String keyword);
}
