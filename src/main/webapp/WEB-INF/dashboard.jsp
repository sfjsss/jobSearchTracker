<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Job Search Tracker</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
                <li class="nav-item active">
                    <a class="nav-link" href="/dashboard">Job Applications<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Networking Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contacts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Reminders(<c:if test="${user.reminders.size()>0}"><span class="red"><c:out value="${user.reminders.size()}"/></span></c:if><c:if test="${user.reminders.size()<=0}">0</c:if>)</a>
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
                    <h3>You have submitted <span class="specialBlue"><c:out value="${user.applications.size()}"/> applications</span> in total. Add a new application</h3>
                    <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addApplication">Add Application</button>
                    <h3>or share your progress through a generated link</h3>
                    <a href="#" class="btn btn-primary">Link</a>
                </div>
                <div id="progressBars">
                    <div id="applicationBar">
                        <div id='applicationProgress'>
                            <div class="progress"></div>
                            <div class="content"></div>
                        </div>
                        <h3>Weekly Goal for Application: 10/10</h3>
                        <a href="#" class="btn btn-outline-primary changeBtn">Change</a>
                    </div>

                    <div id="eventBar">
                        <div id='eventProgress'>
                            <div class="progress"></div>
                            <div class="content"></div>
                        </div>
                        <h3>Weekly Goal for Event: 2/2</h3>
                        <a href="#" class="btn btn-outline-primary changeBtn">Change</a>
                    </div>
                </div>
            </div>

            <div id="content">
                <div id="filtersAndSearch">
                    <form action="/filterApplications" method="POST" class="form-inline">
                        <label class="my-1 mr-2" for="status">Application Status</label>
                        <select class="custom-select my-1 mr-sm-2" id="status" name="status">
                            <option selected>Choose...</option>
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
                        <button type="submit" class="btn btn-primary">Apply Filter</button>
                    </form>

                    <form class="form-inline my-2 my-lg-0">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>

                <table class="table table-striped">
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
                        <c:forEach items="${user.applications}" var="application">
                            <tr>
                                <td><c:out value="${application.status}"/></td>
                                <td><c:out value="${application.companyName}"/></td>
                                <td><c:out value="${application.dateOfSubmission}"/></td>
                                <td><c:out value="${application.jobTitle}"/></td>
                                <td><c:out value="${application.city} ${application.state}"/></td>
                                <td>
                                    <c:if test="${application.notes.size() == 0}">
                                        N/A
                                    </c:if>
                                    <c:if test="${application.notes.size() > 0}">
                                        <c:out value="${application.notes.get(application.notes.size())}"/>
                                    </c:if>
                                </td>
                                <td><a href="#">Edit</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        

            <div class="modal fade" id="addApplication" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add new application</h5>
                        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span> -->
                        </button>
                    </div>
                    <div class="modal-body">
                        <form:form method="post" action="/applications" modelAttribute="application">
                            <p id="modalError"><c:out value="${error}"/></p>
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
                                <form:label path="dateOfSubmission" for="dateOfSubmission" class="col-form-label">Date of Submission:</form:label>
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

        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>