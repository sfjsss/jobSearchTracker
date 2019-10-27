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
                <li class="nav-item">
                    <a class="nav-link" href="/dashboard">Job Applications<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">Networking Events</a>
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
                <a href="#" class="btn btn-primary my-2 my-sm-0 mr-2">Setting</a>
                <a href="/logout" class="btn btn-outline-danger my-2 my-sm-0">Logout</a>
            </div>
        </nav>
        <!-- nav bar ends -->

        <div id="bodyWrapper">

            <div id="overview">
                <div id="statsAndShare">
                    <h5>You have attended <span class="specialBlue"><c:out value="${user.events.size()}"/> events</span> in total. Add a new event</h5>
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
                    <form action="/filterEvents" method="POST" class="form-inline">

                        <label for="fromDate" class="my-1 mr-2">From Date</label>
                        <input type="date" class="form-control my-1 mr-sm-2" id="fromDate" name="fromDate">

                        <label for="endDate" class="my-1 mr-2">End Date</label>
                        <input type="date" class="form-control my-1 mr-sm-2" id="endDate" name="endDate">
                        <button type="submit" class="btn btn-primary mr-sm-2">Apply Filter</button>
                        <a href="/events" class="btn btn-outline-primary">Reset Filter</a>
                    </form>
                    <!-- filter end -->

                    <form class="form-inline my-2 my-lg-0" method="POST" action="/searchEvents">
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
                                    <a href="" data-toggle="modal" data-target="#addContact${event.id}">Contacts</a> |
                                    <a href="" data-toggle="modal" data-target="#editEvent${event.id}">Edit</a>
                                </td>
                            </tr>

                            <!-- edit application form starts -->
                            <p class="hiddenData" id="editError"><c:out value="${editError}"/></p>
                            <div class="modal fade" id="editEvent${event.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit event</h5>
                                    </div>
                                    <div class="modal-body">
                                        <form method="post" action="/events/${event.id}">
                                            <div class="form-group">
                                                <label for="name" class="col-form-label">Event Name*:</label>
                                                <input name="name" type="text" class="form-control" id="name" value="${event.name}"/>
                                                <p class="red"><c:out value="${nameError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="link" class="col-form-label">Event Post Link:</label>
                                                <input name="link" type="text" class="form-control" id="link" value="${event.link}"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="eventDate" class="col-form-label">Date of Event* (<c:out value="${event.eventDate}"/>):</label>
                                                <input name="eventDate" type="date" class="form-control" id="eventDate"/>
                                                <p class="red"><c:out value="${eventDateError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="location" class="col-form-label">Location:</label>
                                                <input name="location" type="text" class="form-control" id="location" value="${event.location}"/>
                                                <p class="red"><c:out value="${locationError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="notes" class="col-form-label">Notes:</label>
                                                <textarea name="notes" class="form-control" id="notes"><c:out value="${event.notes}"/></textarea>
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

                            <!-- add contact form starts -->
                            <p class="hiddenData" id="contactError"><c:out value="${contactError}"/></p>
                            <div class="modal fade" id="addContact${event.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Add a contact</h5>
                                    </div>
                                    <div class="modal-body">
                                        <c:forEach items="${event.contacts}" var="contact">
                                            <p>Name: <c:out value="${contact.name}"/></p>
                                            <p>Number: <c:out value="${contact.number}"/></p>
                                            <p>Email: <c:out value="${contact.email}"/></p>
                                            <p>LinkedIn: <c:out value="${contact.linkedIn}"/></p>
                                            <p>Description: <c:out value="${contact.description}"/></p>
                                            <hr>
                                        </c:forEach>
                                        <form method="post" action="/addContact">
                                            <input type="hidden" name="eventId" value="${event.id}">
                                            <div class="form-group">
                                                <label name="name" for="name" class="col-form-label">Name*:</label>
                                                <input name="name" type="text" class="form-control" id="name"/>
                                                <p class="red"><c:out value="${contactNameError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label name="number" for="number" class="col-form-label">Number:</label>
                                                <input name="number" type="text" class="form-control" id="number"/>
                                                <p class="red"><c:out value="${numberError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label name="email" for="email" class="col-form-label">Email:</label>
                                                <input name="email" type="email" class="form-control" id="email"/>
                                                <p class="red"><c:out value="${emailError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label name="linkedIn" for="linkedIn" class="col-form-label">LinkedIn:</label>
                                                <input name="linkedIn" type="text" class="form-control" id="linkedIn"/>
                                                <p class="red"><c:out value="${linkedInError}"/></p>
                                            </div>
                                            <div class="form-group">
                                                <label for="description" class="col-form-label">Description:</label>
                                                <textarea name="description" class="form-control" id="description"></textarea>
                                                <p class="red"><c:out value="${descriptionError}"/></p>
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
                            <!-- add contact form ends-->

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