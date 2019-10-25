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
        <link rel="stylesheet" href="/css/dashboard.css">
    </head>
    <body>
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
                <li class="nav-item active">
                    <a class="nav-link" href="#">Networking Events</a>
                </li>
                <!-- <li class="nav-item">
                    <a class="nav-link" href="#">Contacts</a>
                </li> -->
                <li class="nav-item">
                    <a class="nav-link" href="/reminders">Reminders(<c:if test="${reminders.size()>0}"><span class="red"><c:out value="${reminders.size()}"/></span></c:if><c:if test="${reminders.size()<=0}">0</c:if>)</a>
                </li>
                </ul>
                <ul class="navbar-nav ml-auto mr-5">
                    <li class="nav-item">Welcome, <c:out value="${user.firstName}!"/></li>
                </ul>
                <a href="#" class="btn btn-primary my-2 my-sm-0 mr-2">Setting</a>
                <a href="/logout" class="btn btn-outline-danger my-2 my-sm-0">Logout</a>
            </div>
        </nav>

        <div id="bodyWrapper">

            <div id="overview">
                <div id="statsAndShare">
                    <h5>You have attended <span class="specialBlue"><c:out value="${user.applications.size()}"/> events</span> in total. Add a new event</h5>
                    <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addEvent">Add Event</button>
                    <h5>or share your progress through a generated link</h5>
                    <a href="#" class="btn btn-primary">Link</a>
                </div>
                <div id="progressBars">
                    

                    <div id="eventBar">
                        <div id='eventProgress'>
                            <div class="progress" id="eProgress"></div>
                            <div class="content"></div>
                        </div>
                        <h5>Weekly Goal for Event: <c:out value="${thisWeekEvents.size()}"/>/<c:out value="${user.weeklyNetworkEventGoal}"/></h5>
                        <!-- hidden data for progress bar js starts-->
                        <p id="numOfThisWeekEvents" class="hiddenData"><c:out value="${thisWeekEvents.size()}"/></p>
                        <p id="weeklyGoalForEvents" class="hiddenData"><c:out value="${user.weeklyNetworkEventGoal}"/></p>
                        <!-- hidden data for progress bar js ends -->
                        <button class="btn btn-outline-primary changeBtn" type="button" data-toggle="modal" data-target="#changeWeeklyGoals">Change</button>
                    </div>
                </div>
            </div>

            <div id="content">
                <p class="red"><c:out value="${filterError}"/></p>
                <p class="red" id="searchError"><c:out value="${searchError}"/></p>
                
                <div id="filtersAndSearch">
                    <!-- filter start -->
                    <form action="/filterApplications" method="POST" class="form-inline">

                        <label for="fromDate" class="my-1 mr-2">From Date</label>
                        <input type="date" class="form-control my-1 mr-sm-2" id="fromDate" name="fromDate">

                        <label for="endDate" class="my-1 mr-2">End Date</label>
                        <input type="date" class="form-control my-1 mr-sm-2" id="endDate" name="endDate">
                        <button type="submit" class="btn btn-primary mr-sm-2">Apply Filter</button>
                        <a href="/dashboard" class="btn btn-outline-primary">Reset Filter</a>
                    </form>
                    <!-- filter end -->

                    <form class="form-inline my-2 my-lg-0" method="POST" action="/searchApplications">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="keyword">
                        <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>


                <table class="table table-striped" id="appTable">
                    <thead>
                        <tr>
                            <th scope="col">Event</th>
                            <th scope="col">Event Date</th>
                            <th scope="col">Location</th>
                            <th scope="col">Note</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${events}" var="event">
                            <tr>
                                <td><c:out value="${event.name}"/></td>
                                <td><c:out value="${event.eventDate}"/></td>
                                <td><c:out value="${event.location}"/></td>
                                <td><c:out value="${event.notes}"/></td>
                                <td>
                                    <a href="" data-toggle="modal" data-target="#viewEvent${event.id}">View</a> |
                                    <a href="" data-toggle="modal" data-target="#addReminder${application.id}">Contacts</a> |
                                    <a href="" data-toggle="modal" data-target="#editApplication${application.id}">Edit</a>
                                </td>
                            </tr>

                            <!-- edit application form starts -->
                            <p class="hiddenData" id="editError"><c:out value="${editError}"/></p>
                            <div class="modal fade" id="editApplication${application.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit application</h5>
                                    </div>
                                    <div class="modal-body">
                                        <form method="post" action="/applications/${application.id}">
                                            <div class="form-group">
                                                <label for="companyName" class="col-form-label">Company Name*:</label>
                                                <input name="companyName" type="text" class="form-control" id="companyName" value="${application.companyName}"/>
                                                <p class="red"><c:out value="${companyNameError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="jobPostLink" class="col-form-label">Job Post Link:</label>
                                                <input name="jobPostLink" type="text" class="form-control" id="jobPostLink" value="${application.jobPostLink}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="dateOfSubmission" class="col-form-label">Date of Submission* (<c:out value="${application.dateOfSubmission}"/>):</label>
                                                <input name="dateOfSubmission" type="date" class="form-control" id="dateOfSubmission"/>
                                                <p class="red"><c:out value="${dateOfSubmissionError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="jobTitle" class="col-form-label">Job Title*:</label>
                                                <input name="jobTitle" type="text" class="form-control" id="jobTitle" value="${application.jobTitle}"/>
                                                <p class="red"><c:out value="${jobTitleError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="city" class="col-form-label">City:</label>
                                                <input name="city" type="text" class="form-control" id="city" value="${application.city}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="state" class="col-form-label">State:</label>
                                                <input name="state" type="text" class="form-control" id="state" value="${application.state}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="resumeLink" class="col-form-label">Resume Link:</label>
                                                <input name="resumeLink" type="text" class="form-control" id="resumeLink" value="${application.resumeLink}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="coverLetterLink" class="col-form-label">Cover Letter Link:</label>
                                                <input name="coverLetterLink" type="text" class="form-control" id="coverLetterLink" value="${application.coverLetterLink}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="coverLetter" class="col-form-label">Cover Letter:</label>
                                                <textarea name="coverLetter" class="form-control" id="coverLetter"><c:out value="${application.coverLetter}"/></textarea>
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
                            <!-- <p class="hiddenData" id="noteError"><c:out value="${noteError}"/></p> -->
                            <div class="modal fade" id="viewEvent${event.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Detail of the event</h5>
                                    </div>
                                    <div class="modal-body">
                                        <p>Event Name: <c:out value="${event.name}"/></p>
                                        <p>Event Post Link: <c:out value="${event.link}"/></p>
                                        <p>Event Date: <c:out value="${event.eventDate}"/></p>
                                        <p>Location: <c:out value="${event.location}"/></p>
                                        <p>Notes: <c:out value="${event.notes}"/></p>

                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                    
                                    </div>
                                </div>
                            </div>
                            <!-- view application ends-->

                            <!-- add reminder form starts -->
                            <p class="hiddenData" id="reminderError"><c:out value="${reminderError}"/></p>
                            <div class="modal fade" id="addReminder${application.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Add a reminder</h5>
                                    </div>
                                    <div class="modal-body">
                                        <c:forEach items="${application.reminders}" var="reminder">
                                            <p>Date: <c:out value="${reminder.reminderDate}"/></p>
                                            <p>Message: <c:out value="${reminder.message}"/></p>
                                        </c:forEach>
                                        <form method="post" action="/addReminder">
                                            <input type="hidden" name="appId" value="${application.id}">
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
            </div>
        
            <!-- addEvent start -->
            <div class="modal fade" id="addEvent" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add new Event</h5>
                    </div>
                    <div class="modal-body">
                        <form:form method="post" action="/events" modelAttribute="event">
                            <p id="eventModalError" class="hiddenData"><c:out value="${eventModalError}"/></p>
                            <div class="form-group">
                                <form:label path="name" for="name" class="col-form-label">Event Name*:</form:label>
                                <form:input path="name" type="text" class="form-control" id="name"/>
                                <form:errors path="name" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="link" for="link" class="col-form-label">Event Link:</form:label>
                                <form:input path="link" type="text" class="form-control" id="link"/>
                            </div>
                            <div class="form-group">
                                <form:label path="eventDate" for="eventDate" class="col-form-label">Date of Event*:</form:label>
                                <form:input path="eventDate" type="date" class="form-control" id="eventDate"/>
                                <form:errors path="eventDate" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="location" for="location" class="col-form-label">Location:</form:label>
                                <form:input path="location" type="text" class="form-control" id="location"/>
                                <form:errors path="location" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="notes" for="notes" class="col-form-label">Notes:</form:label>
                                <form:textarea path="notes" class="form-control" id="notes"></form:textarea>
                            </div>
                            <div class="form-group formBtnDiv">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Add</button>
                            </div>
                        </form:form>
                    </div>
                    </div>
                </div>
            </div>
            <!-- addEvent ends -->

            
            <!-- change weekly goal modal form starts -->
            <div class="modal fade" id="changeWeeklyGoals" tabindex="-1">
                <p class="hiddenData" id="flashError"><c:out value="${flashError}"/></p>
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Change the weekly goal</h5>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="/weeklyEventGoals">
                            <div class="form-group">
                                <label name="eventWeeklyGoal" for="eventWeeklyGoal" class="col-form-label">Weekly Goal for Event:</label>
                                <input name="eventWeeklyGoal" type="number" class="form-control" id="eventWeeklyGoal" value="2"/>
                                <p class="red"><c:out value="${eventWeeklyGoalError}"/></p>
                            </div>
                            <div class="form-group formBtnDiv">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Change</button>
                            </div>
                        </form>
                    </div>
                    
                    </div>
                </div>
            </div>
            <!-- change weekly goal modal form ends-->

        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>