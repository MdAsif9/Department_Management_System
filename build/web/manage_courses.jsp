<%--
    Document   : adminCourse
    Created on : 13-Jun-2023, 8:19:46 pm
    Author     : asifk
--%>

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link rel="shortcut icon" href="./images/admin_logo.png">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <header>
            <div class="logo" title="University Management System">
                <img src="./images/manuuLogo1.png" alt="">
                <h2>A<span class="danger">D</span>M<span class="danger">I</span>N</h2>
            </div>
            <div class="navbar">
                <a href="AdminIndex.jsp">
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="adminStudent.jsp" >
                    <span class="material-icons-sharp">people</span>
                    <h3>Manage Students</h3>
                </a>
                <a href="manage_teachers.jsp">
                    <span class="material-icons-sharp">person</span>
                    <h3>Manage Teachers</h3>
                </a> 
                <a href="AdminManageTimeTable.jsp">
                    <span class="material-symbols-outlined">today</span>
                    <h3>Manage Time Table</h3>
                </a> 
                <a href="manage_courses.jsp" class="active">
                    <span class="material-icons-sharp">assignment</span>
                    <h3>Manage Courses</h3>
                </a> 
                <a href="index.html">
                    <span class="material-icons-sharp" onclick="">logout</span>
                    <h3>Logout</h3>
                </a>
            </div>
            <div id="profile-btn">
                <span class="material-icons-sharp">person</span>
            </div>
            <div class="theme-toggler">
                <span class="material-icons-sharp active">light_mode</span>
                <span class="material-icons-sharp">dark_mode</span>
            </div>
        </header>
        <div class="container">
            <aside>
                <h1>Add Course</h1>

                <div id="add-course-form" style="display: none;">
                    <form method="post">
                        <input type="hidden" name="formType" value="addCourse">
                        <label for="courseId">Course ID:</label>
                        <input type="text" id="courseId" name="courseId" required>
                        <label for="courseName">Course Name:</label>
                        <input type="text" id="courseName" name="courseName" required>
                        <button type="submit">Add Course</button>
                    </form>
                </div>

                <button id="toggle-form" onclick="toggleForm()">Toggle Form</button>
                <script>
                    function toggleForm() {
                        var form = document.getElementById("add-course-form");
                        var toggleBtn = document.getElementById("toggle-form");
                        if (form.style.display === "none") {
                            form.style.display = "block";
                            toggleBtn.innerText = "Hide Form";
                        } else {
                            form.style.display = "none";
                            toggleBtn.innerText = "Show Form";
                        }
                    }
                </script>

                <h1>Add Subject</h1>
                <div id="add-subject-form" style="display: none;">
                    <form method="post" >
                        <input type="hidden" name="formType" value="addSubject">
                        <label for="subjectId">Subject ID:</label>
                        <input type="text" id="subjectId" name="subjectId" required>
                        <label for="subjectName">Subject Name:</label>
                        <input type="text" id="subjectName" name="subjectName" required>
                        <label for="semesterId">Semester ID:</label>
                        <input type="text" id="semesterId" name="semesterId" required>
                        <button type="submit">Add Subject</button>
                    </form>
                </div>

                <button id="toggle-subject-form" onclick="toggleSubjectForm()">Toggle Form</button>
                <script>
                    function toggleSubjectForm() {
                        var form = document.getElementById("add-subject-form");
                        var toggleBtn = document.getElementById("toggle-subject-form");
                        if (form.style.display === "none") {
                            form.style.display = "block";
                            toggleBtn.innerText = "Hide Form";
                        } else {
                            form.style.display = "none";
                            toggleBtn.innerText = "Show Form";
                        }
                    }
                </script>

                <h1>Add Semester</h1>
                <div id="add-semester-form" style="display: none;">
                    <form method="post">
                        <input type="hidden" name="formType" value="addSemester">
                        <label for="semesterId">Semester ID:</label>
                        <input type="text" id="semesterId" name="semesterId" required>
                        <label for="semesterName">Semester Name:</label>
                        <input type="text" id="semesterName" name="semesterName" required>
                        <label for="courseId">Course ID:</label>
                        <input type="text" id="courseId" name="courseId" required>
                        <button type="submit">Add Semester</button>
                    </form>
                </div>

                <button id="toggle-semester-form" onclick="toggleSemesterForm()">Toggle Form</button>
                <script>
                    function toggleSemesterForm() {
                        var form = document.getElementById("add-semester-form");
                        var toggleBtn = document.getElementById("toggle-semester-form");
                        if (form.style.display === "none") {
                            form.style.display = "block";
                            toggleBtn.innerText = "Hide Form";
                        } else {
                            form.style.display = "none";
                            toggleBtn.innerText = "Show Form";
                        }
                    }
                </script>
                <%@ page import="java.sql.*" %>
                <%

                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        // Check which form is submitted

                        // Database connection settings
                        String url = "jdbc:mysql://localhost:3306/dms";
                        String username = "root";
                        String password = "Asif@1199";

                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        int i = 0;

                        try {
                            // Load the JDBC driver
                            Class.forName("com.mysql.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(url, username, password);
                            if (request.getParameter("formType").equals("addCourse")) {
                                // Retrieve form data
                                i = 1;
                                String courseId = request.getParameter("courseId");
                                String courseName = request.getParameter("courseName");

                                // Create a prepared statement
                                String sql = "INSERT INTO Course (courseId, name) VALUES (?, ?)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, courseId);
                                pstmt.setString(2, courseName);

                                // Execute the query
                                pstmt.executeUpdate();

                                // Display success message
                                out.println("<p>Course added successfully!</p>");
                            } else if (request.getParameter("formType").equals("addSubject")) {
                                i = 2;
                                // Retrieve form data
                                String subjectId = request.getParameter("subjectId");
                                String subjectName = request.getParameter("subjectName");
                                String semesterId = request.getParameter("semesterId");
                                // Create a prepared statement
                                String sql = "INSERT INTO Subject (SubjectId, name, semesterId) VALUES (?, ?, ?)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, subjectId);
                                pstmt.setString(2, subjectName);
                                pstmt.setString(3, semesterId);

                                // Execute the query
                                pstmt.executeUpdate();

                                // Display success message
                                out.println("<p>Subject added successfully!</p>");
                            } else if (request.getParameter("formType").equals("addSemester")) {
                                i = 3;
                                // Retrieve form data
                                String semesterId = request.getParameter("semesterId");
                                String semesterName = request.getParameter("semesterName");
                                String courseId = request.getParameter("courseId");
                                // Create a prepared statement
                                String sql = "INSERT INTO Semester (semesterId, name, courseId) VALUES (?, ?, ?)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, semesterId);
                                pstmt.setString(2, semesterName);
                                pstmt.setString(3, courseId);
                                //pstmt.setInt(3, Integer.parseInt(courseId));

                                // Execute the query
                                pstmt.executeUpdate();

                                // Display success message
                                out.println("<p>Semester added successfully!</p>");
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            // Display error message
                            if (i == 1) {
                                out.println("<p>Error occurred while adding course! " + e + " </p>");
                            } else if (i == 2) {
                                out.println("<p>Error occurred while adding subject! " + e + " </p>");
                            } else if (i == 3) {
                                out.println("<p>Error occurred while adding semester! " + e + " </p>");
                            } else {
                                out.println("<p>Unexpected error! " + e + " </p>");
                            }
                        } finally {
                            // Close the database resources
                            if (pstmt != null) {
                                pstmt.close();
                            }
                            if (conn != null) {
                                conn.close();
                            }
                        }

                    }
                %>
            </aside>
            <main>
                <div class="timetable" id="courses">
                    <h2>Manage Courses</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Course ID</th>
                                <th>Course Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Establish database connection and retrieve course records --%>
                            <%@ page import="java.sql.*" %>
                            <%
                                // Database connection settings
                                String url = "jdbc:mysql://localhost:3306/dms";
                                String username = "root";
                                String password = "Asif@1199";

                                try ( Connection conn = DriverManager.getConnection(url, username, password)) {
                                    // Create a statement
                                    Statement stmt = conn.createStatement();

                                    // Execute a query
                                    String sql = "SELECT * FROM Course";
                                    ResultSet rs = stmt.executeQuery(sql);

                                    // Process the result set
                                    while (rs.next()) {
                                        String courseId = rs.getString("courseId");
                                        String courseName = rs.getString("name");

                                        // Display course information
                                        out.println("<tr>");
                                        out.println("<td>" + courseId + "</td>");
                                        out.println("<td>" + courseName + "</td>");
                                        out.println("<td><a href='editCourse?id=" + courseId + "'>Edit</a>   <a href='deleteCourse?id=" + courseId + "'>Delete</a></td>");
                                        out.println("</tr>");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="timetable" id="semesters">
                    <h2>Manage Semesters</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Semester ID</th>
                                <th>Semester Name</th>
                                <th>Course ID```jsp
                                </th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Establish database connection and retrieve semester records --%>
                            <%@ page import="java.sql.*" %>
                            <%
                                // Database connection settings
                                try ( Connection conn = DriverManager.getConnection(url, username, password)) {
                                    // Create a statement
                                    Statement stmt = conn.createStatement();

                                    // Execute a query
                                    String sql = "SELECT * FROM Semester";
                                    ResultSet rs = stmt.executeQuery(sql);

                                    // Process the result set
                                    while (rs.next()) {
                                        String semesterId = rs.getString("semesterId");
                                        String semesterName = rs.getString("name");
                                        String courseId = rs.getString("courseId");

                                        // Display semester information
                                        out.println("<tr>");
                                        out.println("<td>" + semesterId + "</td>");
                                        out.println("<td>" + semesterName + "</td>");
                                        out.println("<td>" + courseId + "</td>");
                                        out.println("<td><a href='editSemester?id=" + semesterId + "'>Edit</a>   <a href='deleteSemester?id=" + semesterId + "'>Delete</a></td>");
                                        out.println("</tr>");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="timetable" id="subjects">
                    <h2>Manage Subjects</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Subject ID</th>
                                <th>Subject Name</th>
                                <th>Semester ID</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Establish database connection and retrieve subject records --%>
                            <%@ page import="java.sql.*" %>
                            <%
                                // Database connection settings
                                try ( Connection conn = DriverManager.getConnection(url, username, password)) {
                                    // Create a statement
                                    Statement stmt = conn.createStatement();

                                    // Execute a query
                                    String sql = "SELECT * FROM Subject";
                                    ResultSet rs = stmt.executeQuery(sql);

                                    // Process the result set
                                    while (rs.next()) {
                                        String subjectId = rs.getString("subjectId");
                                        String subjectName = rs.getString("name");
                                        String semesterId = rs.getString("semesterId");

                                        // Display subject information
                                        out.println("<tr>");
                                        out.println("<td>" + subjectId + "</td>");
                                        out.println("<td>" + subjectName + "</td>");
                                        out.println("<td>" + semesterId + "</td>");
                                        out.println("<td><a href='editSubject?id=" + subjectId + "'>Edit</a>   <a href='deleteSubject?id=" + subjectId + "'>Delete</a></td>");
                                        out.println("</tr>");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </main>
            <div class="right">
                <div id="communication">
                    <h2>Communication</h2>
                    <form id="email-form" action="sendEmail" method="post">
                        <label for="recipient">Recipient:</label>
                        <input type="text" id="recipient" name="recipient">
                        <br>
                        <label for="subject">Subject:</label>
                        <input type="text" id="subject" name="subject"><br>
                        <label for="message">Message:</label>
                        <textarea type="message" name="Message" rows="4" cols="20"></textarea>
                        <button type="submit">Send Email</button>
                    </form>
                </div>
            </div>
        </div>
        <script src="script.js"></script>
        <script src="app.js"></script>
    </body>
</html>
