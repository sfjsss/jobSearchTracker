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
        <!-- nav bar starts -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="/dashboard">Job Search Tracker</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/dashboard">Job Applications<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/events">Networking Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/contacts">Contacts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/reminders">Reminders(<c:if test="${reminders.size()>0}"><span class="red"><c:out value="${reminders.size()}"/></span></c:if><c:if test="${reminders.size()<=0}">0</c:if>)</a>
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
                    <h5>You have submitted <span class="specialBlue"><c:out value="${user.applications.size()}"/> applications</span> in total. Add a new application</h5>
                    <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addApplication">Add Application</button>
                    <h5>or share your progress through a generated link</h5>
                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#shareLink">Link</a>
                </div>
                <div id="progressBars">
                    <div id="applicationBar">
                        <div id='applicationProgress'>
                            <div class="progress" id="aProgress"></div>
                            <div class="content"></div>
                        </div>
                        <h5>Weekly Goal for Application: <c:out value="${thisWeekApps.size()}"/>/<c:out value="${user.weeklyJobApplicationGoal}"/></h5>
                        <p id="numOfThisWeekApps" class="hiddenData"><c:out value="${thisWeekApps.size()}"/></p>
                        <p id="weeklyGoalForApps" class="hiddenData"><c:out value="${user.weeklyJobApplicationGoal}"/></p>
                        <!-- <a href="#" class="btn btn-outline-primary changeBtn">Change</a> -->
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
                        <label class="my-1 mr-2" for="status">Status</label>
                        <select class="custom-select my-1 mr-sm-2" id="status" name="status">
                            <option selected value="all">Choose..</option>
                            <option value="submitted">Submitted</option>
                            <option value="reachedOut">Reached Out</option>
                            <option value="interview">Interview</option>
                            <option value="accepted">Accepted</option>
                            <option value="rejected">Rejected</option>
                            <option value="withdrawn">Withdrawn</option>
                        </select>

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
                            <th scope="col">Status</th>
                            <th scope="col">Company</th>
                            <th scope="col">Submitted Date</th>
                            <th scope="col">Job Title</th>
                            <th scope="col">Location</th>
                            <th scope="col">Latest Note</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${searchResults}" var="application">
                            <tr>
                                <td>
                                    <form action="/changeStatus" method="POST">
                                        <input type="hidden" name="applicationId" value="${application.id}">
                                        <select name="status" class="form-control" onchange="this.form.submit()">
                                            <option value="none" selected disabled hidden><c:out value="${application.status}"/></option>
                                            
                                            <option value="submitted">Submitted</option>
                                            <option value="reachedOut">Reached Out</option>
                                            <option value="interview">Interview</option>
                                            <option value="accepted">Accepted</option>
                                            <option value="rejected">Rejected</option>
                                            <option value="withdrawn">Withdrawn</option>
                                        </select>
                                    </form>
                                </td>
                                <td><c:out value="${application.companyName}"/></td>
                                <td><c:out value="${application.dateOfSubmission}"/></td>
                                <td><c:out value="${application.jobTitle}"/></td>
                                <td><c:out value="${application.city} ${application.state}"/></td>
                                <td>
                                    <c:if test="${application.notes.size() == 0}">
                                        N/A
                                    </c:if>
                                    <c:if test="${application.notes.size() > 0}">
                                        <c:out value="${application.notes.get(application.notes.size()-1).content}"/>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="" data-toggle="modal" data-target="#viewApplication${application.id}">View</a> |
                                    <a href="" data-toggle="modal" data-target="#addReminder${application.id}">Reminder</a> |
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
                            <p class="hiddenData" id="noteError"><c:out value="${noteError}"/></p>
                            <div class="modal fade" id="viewApplication${application.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Detail of the application</h5>
                                    </div>
                                    <div class="modal-body">
                                        <p>Company Name: <c:out value="${application.companyName}"/></p>
                                        <p>Job Post Link: <c:out value="${application.jobPostLink}"/></p>
                                        <p>Date of Submission: <c:out value="${application.dateOfSubmission}"/></p>
                                        <p>Job Title: <c:out value="${application.jobTitle}"/></p>
                                        <p>Location: <c:out value="${application.city} ${application.state}"/></p>
                                        <p>Resume Link: <c:out value="${application.resumeLink}"/></p>
                                        <p>Cover Letter Link: <c:out value="${application.coverLetterLink}"/></p>
                                        <p>Cover Letter: <c:out value="${application.coverLetter}"/></p>

                                        <c:forEach items="${application.notes}" var="note">
                                            <p>Note on <c:out value="${note.createdAt}"/>: <c:out value="${note.content}"/></p>
                                        </c:forEach>

                                        <form method="post" action="/addNote">
                                            <input type="hidden" name="appId" value="${application.id}">
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
        

            <div class="modal fade" id="addApplication" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add new application</h5>
                    </div>
                    <div class="modal-body">
                        <form:form method="post" action="/applications" modelAttribute="application">
                            <p id="modalError" class="hiddenData"><c:out value="${error}"/></p>
                            <form:input path="status" type="hidden" value="submitted"/>
                            <div class="form-group">
                                <form:label path="companyName" for="companyName" class="col-form-label">Company Name*:</form:label>
                                <form:input path="companyName" type="text" class="form-control" id="companyName"/>
                                <form:errors path="companyName" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="jobPostLink" for="jobPostLink" class="col-form-label">Job Post Link:</form:label>
                                <form:input path="jobPostLink" type="text" class="form-control" id="jobPostLink"/>
                            </div>
                            <div class="form-group">
                                <form:label path="dateOfSubmission" for="dateOfSubmission" class="col-form-label">Date of Submission*:</form:label>
                                <form:input path="dateOfSubmission" type="date" class="form-control" id="dateOfSubmission"/>
                                <form:errors path="dateOfSubmission" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="jobTitle" for="jobTitle" class="col-form-label">Job Title*:</form:label>
                                <form:input path="jobTitle" type="text" class="form-control" id="jobTitle"/>
                                <form:errors path="jobTitle" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="city" for="city" class="col-form-label">City:</form:label>
                                <form:input path="city" type="text" class="form-control" id="city"/>
                            </div>
                            <div class="form-group">
                                <form:label path="state" for="state" class="col-form-label">State:</form:label>
                                <form:input path="state" type="text" class="form-control" id="state"/>
                            </div>
                            <div class="form-group">
                                <form:label path="resumeLink" for="resumeLink" class="col-form-label">Resume Link:</form:label>
                                <form:input path="resumeLink" type="text" class="form-control" id="resumeLink"/>
                            </div>
                            <div class="form-group">
                                <form:label path="coverLetterLink" for="coverLetterLink" class="col-form-label">Cover Letter Link:</form:label>
                                <form:input path="coverLetterLink" type="text" class="form-control" id="coverLetterLink"/>
                            </div>
                            <div class="form-group">
                                <form:label path="coverLetter" for="coverLetter" class="col-form-label">Cover Letter:</form:label>
                                <form:textarea path="coverLetter" class="form-control" id="coverLetter"></form:textarea>
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

            <!-- change weekly goal modal form starts-->
            <div class="modal fade" id="changeWeeklyGoals" tabindex="-1">
                <p class="hiddenData" id="flashError"><c:out value="${flashError}"/></p>
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Change the weekly goal</h5>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="/weeklyAppGoals">
                            <div class="form-group">
                                <label name="appWeeklyGoal" for="appWeeklyGoal" class="col-form-label">Weekly Goal for Application:</label>
                                <input name="appWeeklyGoal" type="number" class="form-control" id="appWeeklyGoal" value="${user.weeklyJobApplicationGoal}"/>
                                <p class="red"><c:out value="${appWeeklyGoalError}"/></p>
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

            <!-- share link starts -->
            <div class="modal fade" id="shareLink" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Share your progress with this link</h5>
                    </div>
                    <div class="modal-body">
                        <input type="text" value="http://54.186.205.190/shareLink?userId=${user.id}&email=${user.email}" class="form-control">
                    </div>
                    
                    </div>
                </div>
            </div>
            <!-- share link ends-->

        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>