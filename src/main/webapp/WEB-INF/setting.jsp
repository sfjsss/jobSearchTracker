<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Job Search Tracker</title>

        <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
        <link rel="stylesheet" href="/bootstrap-4.3.1-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/css/setting.css">
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

        <!-- setting form starts -->
        <div id="settingContainer">
            <h2>Update the user information</h2>
            <form:form action="/updateUser" method="post" modelAttribute="user">
                <form:input path="id" type="hidden"/>
                <div class="form-group row">
                    <form:label for="firstName" class="col-sm-4 col-form-label" path="firstName">First Name:</form:label>
                    <div class="col-sm-8">
                        <form:input type="text" class="form-control" id="firstName" path="firstName" value="${user.firstName}"/>
                        <form:errors path="firstName" class="red"/>
                    </div>
                </div>

                <div class="form-group row">
                    <form:label for="lastName" class="col-sm-4 col-form-label" path="lastName">Last Name:</form:label>
                    <div class="col-sm-8">
                        <form:input type="text" class="form-control" id="lastName" path="lastName" value="${user.lastName}"/>
                        <form:errors path="lastName" class="red"/>
                    </div>
                </div>

                <div class="form-group row">
                    <form:label for="email" class="col-sm-4 col-form-label" path="email">Email:</form:label>
                    <div class="col-sm-8">
                        <form:input type="email" class="form-control" id="email" path="email" value="${user.email}"/>
                        <form:errors path="email" class="red"/>
                    </div>
                </div>

                <div class="form-group row">
                    <form:label for="password" class="col-sm-4 col-form-label" path="password">New Password:</form:label>
                    <div class="col-sm-8">
                        <form:input type="password" class="form-control" id="password" path="password" value="testtest"/>
                        <form:errors path="password" class="red"/>
                    </div>
                </div>

                <div class="form-group row">
                    <form:label for="passwordConfirmation" class="col-sm-4 col-form-label" path="passwordConfirmation">PW Confirmation:</form:label>
                    <div class="col-sm-8">
                        <form:input type="password" class="form-control" id="passwordConfirmation" path="passwordConfirmation"/>
                        <form:errors path="passwordConfirmation" class="red"/>
                    </div>
                </div>
                
                <div class="form-group row my-4">
                    <div class="col-sm-12 btnContainer">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </div>
            </form:form>
        </div>
        <!-- setting form ends -->


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="/script/dashboard.js"></script>
    </body>
</html>