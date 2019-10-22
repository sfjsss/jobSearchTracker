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
                    <a href="#" class="btn btn-success">Add Application</a>
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
                        <a href="#" class="btn btn-outline-primary">Change</a>
                    </div>

                    <div id="eventBar">
                        <div id='eventProgress'>
                            <div class="progress"></div>
                            <div class="content"></div>
                        </div>
                        <h3>Weekly Goal for Event: 2/2</h3>
                        <a href="#" class="btn btn-outline-primary">Change</a>
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
                            <th scope="col">Date</th>
                            <th scope="col">Position</th>
                            <th scope="col">Location</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Mark</td>
                            <td>Otto</td>
                            <td>@mdo</td>
                            <td>Mark</td>
                            <td>Mark</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        
        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>