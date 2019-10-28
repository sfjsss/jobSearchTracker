<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Job Search Tracker</title>

        <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
        <link rel="stylesheet" href="/bootstrap-4.3.1-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/css/reminders.css">
    </head>
    <body>
        <!-- nav bar starts -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="/dashboard">Job Search Tracker</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/dashboard">Job Applications<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/events">Networking Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/contacts">Contacts</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">Reminders(<c:if test="${reminders.size()>0}"><span class="red"><c:out value="${reminders.size()}"/></span></c:if><c:if test="${reminders.size()<=0}">0</c:if>)</a>
                </li>
                </ul>
                <ul class="navbar-nav ml-auto mr-5">
                    <li class="nav-item">Welcome, <c:out value="${user.firstName}!"/></li>
                </ul>
                <a href="/setting" class="btn btn-primary my-2 my-sm-0 mr-2">Setting</a>
                <a href="/logout" class="btn btn-outline-danger my-2 my-sm-0">Logout</a>
            </div>
        </nav>
        <!-- nav bar ends -->

        <div id="bodyWrapper">

            <div id="overview">
                <div id="statsAndShare">
                    <h5>You have <span class="specialBlue"><c:out value="${reminders.size()}"/> active reminder(s)</span>. Below applications need your attention.</h5>
                </div>
                
            </div>

            <div id="content">
                <div id="filtersAndSearch">
                    <a href="/clearAllReminders" class="btn btn-outline-danger">Clear All</a>
                </div>
                
                <!-- table starts -->
                <table class="table table-striped" id="appTable">
                    <thead>
                        <tr>
                            <th scope="col">Status</th>
                            <th scope="col">Company</th>
                            <th scope="col">Submitted Date</th>
                            <th scope="col">Job Title</th>
                            <th scope="col">Location</th>
                            <th scope="col">Reminder</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${reminders}" var="reminder">
                            <tr>
                                <td>
                                    <form action="/changeStatus" method="POST">
                                        <input type="hidden" name="applicationId" value="${reminder.application.id}">
                                        <select name="status" class="form-control" onchange="this.form.submit()">
                                            <option value="none" selected disabled hidden><c:out value="${reminder.application.status}"/></option>
                                            
                                            <option value="submitted">Submitted</option>
                                            <option value="reachedOut">Reached Out</option>
                                            <option value="interview">Interview</option>
                                            <option value="accepted">Accepted</option>
                                            <option value="rejected">Rejected</option>
                                            <option value="withdrawn">Withdrawn</option>
                                        </select>
                                    </form>
                                </td>
                                <td><c:out value="${reminder.application.companyName}"/></td>
                                <td><c:out value="${reminder.application.dateOfSubmission}"/></td>
                                <td><c:out value="${reminder.application.jobTitle}"/></td>
                                <td><c:out value="${reminder.application.city} ${reminder.application.state}"/></td>
                                <td>
                                    <c:out value="${reminder.message}"/>
                                </td>
                                <td>
                                    <a href="" data-toggle="modal" data-target="#viewApplication${reminder.application.id}">View</a> |
                                    <a href="" data-toggle="modal" data-target="#addReminder${reminder.application.id}">Reminder</a> |
                                    <a href="" data-toggle="modal" data-target="#editApplication${reminder.application.id}">Edit</a> |
                                    <a href="/clearReminder/${reminder.id}" class="red">Clear</a>
                                </td>
                            </tr>

                            <!-- edit application form starts -->
                            <p class="hiddenData" id="editError"><c:out value="${editError}"/></p>
                            <div class="modal fade" id="editApplication${reminder.application.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit application</h5>
                                    </div>
                                    <div class="modal-body">
                                        <form method="post" action="/applications/${reminder.application.id}">
                                            <div class="form-group">
                                                <label for="companyName" class="col-form-label">Company Name*:</label>
                                                <input name="companyName" type="text" class="form-control" id="companyName" value="${reminder.application.companyName}"/>
                                                <p class="red"><c:out value="${companyNameError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="jobPostLink" class="col-form-label">Job Post Link:</label>
                                                <input name="jobPostLink" type="text" class="form-control" id="jobPostLink" value="${reminder.application.jobPostLink}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="dateOfSubmission" class="col-form-label">Date of Submission* (<c:out value="${reminder.application.dateOfSubmission}"/>):</label>
                                                <input name="dateOfSubmission" type="date" class="form-control" id="dateOfSubmission"/>
                                                <p class="red"><c:out value="${dateOfSubmissionError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="jobTitle" class="col-form-label">Job Title*:</label>
                                                <input name="jobTitle" type="text" class="form-control" id="jobTitle" value="${reminder.application.jobTitle}"/>
                                                <p class="red"><c:out value="${jobTitleError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="city" class="col-form-label">City:</label>
                                                <input name="city" type="text" class="form-control" id="city" value="${reminder.application.city}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="state" class="col-form-label">State:</label>
                                                <input name="state" type="text" class="form-control" id="state" value="${reminder.application.state}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="resumeLink" class="col-form-label">Resume Link:</label>
                                                <input name="resumeLink" type="text" class="form-control" id="resumeLink" value="${reminder.application.resumeLink}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="coverLetterLink" class="col-form-label">Cover Letter Link:</label>
                                                <input name="coverLetterLink" type="text" class="form-control" id="coverLetterLink" value="${reminder.application.coverLetterLink}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="coverLetter" class="col-form-label">Cover Letter:</label>
                                                <textarea name="coverLetter" class="form-control" id="coverLetter"><c:out value="${reminder.application.coverLetter}"/></textarea>
                                            </div>
                                            <div class="form-group formBtnDiv">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Update</button>
                                            </div>
                                        </form>
                                    </div>
                                    </div>
                                </div>
                            </div>
                            <!-- edit application form ends -->

                            <!-- view application starts -->
                            <p class="hiddenData" id="noteError"><c:out value="${noteError}"/></p>
                            <div class="modal fade" id="viewApplication${reminder.application.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Detail of the application</h5>
                                    </div>
                                    <div class="modal-body">
                                        <p>Company Name: <c:out value="${reminder.application.companyName}"/></p>
                                        <p>Job Post Link: <c:out value="${reminder.application.jobPostLink}"/></p>
                                        <p>Date of Submission: <c:out value="${reminder.application.dateOfSubmission}"/></p>
                                        <p>Job Title: <c:out value="${reminder.application.jobTitle}"/></p>
                                        <p>Location: <c:out value="${reminder.application.city} ${reminder.application.state}"/></p>
                                        <p>Resume Link: <c:out value="${reminder.application.resumeLink}"/></p>
                                        <p>Cover Letter Link: <c:out value="${reminder.application.coverLetterLink}"/></p>
                                        <p>Cover Letter: <c:out value="${reminder.application.coverLetter}"/></p>

                                        <c:forEach items="${reminder.application.notes}" var="note">
                                            <p>Note on <c:out value="${note.createdAt}"/>: <c:out value="${note.content}"/></p>
                                        </c:forEach>

                                        <form method="post" action="/addNote">
                                            <input type="hidden" name="appId" value="${reminder.application.id}">
                                            <div class="form-group">
                                                <label for="note" class="col-form-label">Add a note</label>
                                                <textarea name="note" class="form-control" id="note"></textarea>
                                                <p class="red"><c:out value="${contentError}"/></p>
                                            </div>
                                            <div class="form-group formBtnDiv">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Add</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    </div>
                                </div>
                            </div>
                            <!-- view application ends-->

                            <!-- add reminder form starts -->
                            <p class="hiddenData" id="reminderError"><c:out value="${reminderError}"/></p>
                            <div class="modal fade" id="addReminder${reminder.application.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Add a reminder</h5>
                                    </div>
                                    <div class="modal-body">
                                        <c:forEach items="${reminder.application.reminders}" var="reminderDetail">
                                            <p>Date: <c:out value="${reminderDetail.reminderDate}"/></p>
                                            <p>Message: <c:out value="${reminderDetail.message}"/></p>
                                        </c:forEach>
                                        <form method="post" action="/addReminder">
                                            <input type="hidden" name="appId" value="${reminder.application.id}">
                                            <div class="form-group">
                                                <label name="remindDate" for="remindDate" class="col-form-label">Choose a date to remind:</label>
                                                <input name="remindDate" type="date" class="form-control" id="remindDate"/>
                                                <p class="red"><c:out value="${remindDateError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="message" class="col-form-label">Reminder message:</label>
                                                <textarea name="message" class="form-control" id="message"></textarea>
                                                <p class="red"><c:out value="${messageError}"/></p>
                                            </div>
                                            <div class="form-group formBtnDiv">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Set</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    </div>
                                </div>
                            </div>
                            <!-- add reminder form ends-->

                        </c:forEach>
                    </tbody>
                </table>

                <!-- table ends -->

            </div>
        
            

            
            

        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>