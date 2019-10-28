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
        <link rel="stylesheet" href="/css/contacts.css">
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
                <li class="nav-item active">
                    <a class="nav-link" href="/contacts">Contacts</a>
                </li>
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
        <!-- nav bar ends -->

        <div id="bodyWrapper">
            <!-- overview starts -->
            <div id="overview">
                <div id="statsAndShare">
                    <h5>You have added <span class="specialBlue"><c:out value="${user.contacts.size()}"/> contacts</span> in total. Add a new contact</h5>
                    <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addContact">Add Contact</button>
                </div>
            </div>
            <!-- overview ends -->

            <div id="content">
                <p class="red" id="searchError"><c:out value="${searchError}"/></p>
                <div id="filtersAndSearch">
                    <form class="form-inline my-2 my-lg-0" method="POST" action="/searchContacts">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="keyword">
                        <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>

                <!-- table starts -->
                <table class="table table-striped" id="appTable">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Number</th>
                            <th scope="col">Email</th>
                            <th scope="col">LinkedIn</th>
                            <th scope="col">Description</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${contacts}" var="contact">
                            <tr>
                                <td><c:out value="${contact.name}"/></td>
                                <td><c:out value="${contact.number}"/></td>
                                <td><c:out value="${contact.email}"/></td>
                                <td><c:out value="${contact.linkedIn}"/></td>
                                <td><c:out value="${contact.description}"/></td>
                                <td>
                                    <a href="" data-toggle="modal" data-target="#editContact${contact.id}">Edit</a>
                                </td>
                            </tr>

                            <!-- edit contact form starts -->
                            <p class="hiddenData" id="editContactError"><c:out value="${editError}"/></p>
                            <div class="modal fade" id="editContact${contact.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit contact</h5>
                                    </div>
                                    <div class="modal-body">
                                        <form method="post" action="/contacts/${contact.id}">
                                            <div class="form-group">
                                                <label for="name" class="col-form-label">Name*:</label>
                                                <input name="name" type="text" class="form-control" id="name" value="${contact.name}"/>
                                                <p class="red"><c:out value="${nameError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="number" class="col-form-label">Number:</label>
                                                <input name="number" type="text" class="form-control" id="number" value="${contact.number}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="email" class="col-form-label">Email:</label>
                                                <input name="email" type="email" class="form-control" id="email" value="${contact.email}"/>
                                                <p class="red"><c:out value="${emailError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="linkedIn" class="col-form-label">LinkedIn:</label>
                                                <input name="linkedIn" type="text" class="form-control" id="linkedIn" value="${contact.linkedIn}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="description" class="col-form-label">Description:</label>
                                                <textarea name="description" class="form-control" id="description"><c:out value="${contact.description}"/></textarea>
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
                            <!-- edit contact form ends -->

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
                <!-- table ends -->
            </div>
        
            <!-- add contact start -->
            <div class="modal fade" id="addContact" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add new contact</h5>
                    </div>
                    <div class="modal-body">
                        <form:form method="post" action="/contacts" modelAttribute="contact">
                            <p id="addContactError" class="hiddenData"><c:out value="${error}"/></p>
                            <div class="form-group">
                                <form:label path="name" for="name" class="col-form-label">Name*:</form:label>
                                <form:input path="name" type="text" class="form-control" id="name"/>
                                <form:errors path="name" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="number" for="number" class="col-form-label">Number:</form:label>
                                <form:input path="number" type="text" class="form-control" id="number"/>
                            </div>
                            <div class="form-group">
                                <form:label path="email" for="email" class="col-form-label">Email:</form:label>
                                <form:input path="email" type="email" class="form-control" id="email"/>
                                <form:errors path="email" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="linkedIn" for="linkedIn" class="col-form-label">LinkedIn:</form:label>
                                <form:input path="linkedIn" type="text" class="form-control" id="linkedIn"/>
                                <form:errors path="linkedIn" class="red"/>
                            </div>
                            <div class="form-group">
                                <form:label path="description" for="description" class="col-form-label">Description:</form:label>
                                <form:textarea path="description" class="form-control" id="description"></form:textarea>
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
            <!-- add contact ends -->

            
            <!-- change weekly goal modal form starts -->
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

        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>