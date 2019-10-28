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
        <link rel="stylesheet" href="/css/style.css">
    </head>
    <body>
        <div id="container">
            <h1>Welcome to Job Search Tracker</h1>
            <div id="signInRegisterWindow" class="card">
                <h2>Register</h2>
                <form:form method="post" action="/register" modelAttribute="user">
                    <div class="form-group row">
                        <form:label for="firstName" class="col-sm-4 col-form-label" path="firstName">First Name:</form:label>
                        <div class="col-sm-8">
                            <form:input type="text" class="form-control" id="firstName" path="firstName"/>
                            <form:errors path="firstName" class="red"/>
                        </div>
                    </div>

                    <div class="form-group row">
                        <form:label for="lastName" class="col-sm-4 col-form-label" path="lastName">Last Name:</form:label>
                        <div class="col-sm-8">
                            <form:input type="text" class="form-control" id="lastName" path="lastName"/>
                            <form:errors path="lastName" class="red"/>
                        </div>
                    </div>

                    <div class="form-group row">
                        <form:label for="email" class="col-sm-4 col-form-label" path="email">Email:</form:label>
                        <div class="col-sm-8">
                            <form:input type="email" class="form-control" id="email" path="email"/>
                            <form:errors path="email" class="red"/>
                        </div>
                    </div>

                    <div class="form-group row">
                        <form:label for="password" class="col-sm-4 col-form-label" path="password">Password:</form:label>
                        <div class="col-sm-8">
                            <form:input type="password" class="form-control" id="password" path="password"/>
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

                    <div class="form-group row">
                        <form:label class="col-sm-4 col-form-label" path="careerCoach">Account Type:</form:label>
                        <div class="col-sm-8 radioBtnContainer">
                            <form:radiobutton path="careerCoach" value="${true}"/>Career Coach
                            <form:radiobutton path="careerCoach" value="${false}"/>Job Seeker
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <div class="col-sm-12 btnContainer">
                            <button type="submit" class="btn btn-primary">Register</button>
                        </div>
                    </div>
                </form:form>
                <p>OR</p>
                <div class="anchorContainer">
                    <a href="/login" class="btn btn-outline-primary">Login</a>
                </div>
            </div>
            <p id="contact">
                Please report bug to alandron06281990@gmail.com
            </p>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>