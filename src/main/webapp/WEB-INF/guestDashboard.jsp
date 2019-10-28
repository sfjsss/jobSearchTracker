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
        <link rel="stylesheet" href="/css/guestDashboard.css">
    </head>
    <body>
        <!-- nav bar starts -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="/dashboard">Job Search Tracker</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
        </nav>
        <!-- nav bar ends -->

        <div id="bodyWrapper">

            <div id="overview">
                <div id="statsAndShare">
                    <h5><c:out value="${user.firstName} ${user.lastName}"/> has submitted <span class="specialBlue"><c:out value="${user.applications.size()}"/> applications</span> in total.</h5>
                </div>
                
            </div>

            <div id="content">


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
                        <c:forEach items="${apps}" var="application">
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
                                        <c:out value="${application.notes.get(application.notes.size()-1).content}"/>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="" data-toggle="modal" data-target="#viewApplication${application.id}">View</a>
                                </td>
                            </tr>

                            

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

                                        
                                    </div>
                                    
                                    </div>
                                </div>
                            </div>
                            <!-- view application ends-->

                            

                        </c:forEach>
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