<%--
    Document   : adminFaculty
    Created on : 13-Jun-2023, 8:19:46 pm
    Author     : asifk
--%>

<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
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
                <a href="manage_teachers.jsp" class="active">
                    <span class="material-icons-sharp">person</span>
                    <h3>Manage Teachers</h3>
                </a> 
                <a href="AdminManageTimeTable.jsp">
                    <span class="material-symbols-outlined">today</span>
                    <h3>Manage Time Table</h3>
                </a> 
                <a href="manage_courses.jsp">
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
                <h1>Add Faculty</h1>

                <div id="add-faculty-form" style="display: none;">
                    <form method="post">
                        <input type="hidden" name="formType" value="addFaculty">
                        <label for="facultyId">Faculty ID:</label>
                        <input type="text" id="facultyId" name="facultyId" required>
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                        <label for="qualification">Qualification:</label>
                        <input type="text" id="qualification" name="qualification" required>
                        <label for="address">Address:</label>
                        <textarea type="text" id="address" name="address" rows="4" cols="20" required></textarea>
                        <label for="researchInterest">Research Interest:</label>
                        <textarea type="text" id="researchInterest" name="researchInterest" rows="4" cols="20" required></textarea>
                        <button type="submit">Add Faculty</button>
                    </form>
                </div>

                <button id="toggle-form" onclick="toggleForm()">Toggle Form</button>
                <script>
                    function toggleForm() {
                        var form = document.getElementById("add-faculty-form");
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
                <%@ page import="java.sql.*" %>
                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        // Check which form is submitted

                        // Database connection settings
                        String url = "jdbc:mysql://localhost:3306/dms";
                        String username = "root";
                        String password1 = "Asif@1199";

                        Connection conn = null;
                        PreparedStatement pstmt = null;

                        try {
                            // Load the JDBC driver
                            Class.forName("com.mysql.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(url, username, password1);
                            if (request.getParameter("formType").equals("addFaculty")) {
                                // Retrieve form data
                                String facultyId = request.getParameter("facultyId");
                                String password = request.getParameter("password");
                                String name = request.getParameter("name");
                                String email = request.getParameter("email");
                                String qualification = request.getParameter("qualification");
                                String address = request.getParameter("address");
                                String researchInterest = request.getParameter("researchInterest");

                                // Create a prepared statement
                                String sql = "INSERT INTO Faculty (facultyId, password, name, email, qualification, address, research_interest) VALUES (?, ?, ?, ?, ?, ?, ?)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, facultyId);
                                pstmt.setString(2, password);
                                pstmt.setString(3, name);
                                pstmt.setString(4, email);
                                pstmt.setString(5, qualification);
                                pstmt.setString(6, address);
                                pstmt.setString(7, researchInterest);

                                // Execute the query
                                pstmt.executeUpdate();

                                // Display success message
                                out.println("<p>Faculty added successfully!</p>");
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            // Display error message
                            out.println("<p>Error occurred while adding faculty! " + e + " </p>");
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
                <h1>Allot Subject to Faculty</h1>

                <div id="allot-subject-form" style="display: none;">
                    <form method="post">
                        <input type="hidden" name="formType" value="allotSubject">
                        <label for="facultyId">Faculty ID:</label>
                        <input type="text" id="facultyId" name="facultyId" required>
                        <!-- Add Course Dropdown -->
                        <label for="course">Course:</label>
                        <select id="course" name="course" onchange="loadSemesters()">
                            <option value="">Select Course</option>
                            <%-- Establish database connection and retrieve course records --%>
                            <%@ page import="java.sql.*" %>
                            <%
                                String url1 = "jdbc:mysql://localhost:3306/dms";
                                String username1 = "root";
                                String password1 = "Asif@1199";

                                Connection conn1 = null;
                                Statement stmt1 = null;
                                ResultSet rs1 = null;
                                try {
                                    // Establish the connection

                                    conn1 = DriverManager.getConnection(url1, username1, password1);

                                    // Create a statement
                                    Statement stmt = conn1.createStatement();

                                    // Execute a query
                                    String sql = "SELECT * FROM Course";
                                    rs1 = stmt.executeQuery(sql);

                                    // Process the result set
                                    while (rs1.next()) {
                                        String courseId = rs1.getString("courseId");
                                        String courseName = rs1.getString("name");

                                        // Display course options
                                        out.println("<option name='courseId' value=\"" + courseId + "\">" + courseName + "</option>");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    // Close the database resources
                                    if (rs1 != null) {
                                        rs1.close();
                                    }
                                    if (stmt1 != null) {
                                        stmt1.close();
                                    }
                                    if (conn1 != null) {
                                        conn1.close();
                                    }
                                }
                            %>
                        </select>

                        <label for="semesterId">Semester ID:</label>
                        <input type="text" id="semesterId" name="semesterId" required>
                        <label for="subjectId">Subject ID:</label>
                        <input type="text" id="subjectId" name="subjectId" required>
                        <button type="submit">Allot Subject</button>
                    </form>
                </div>

                <button id="toggle-subject-form" onclick="toggleSubjectForm()">Toggle Form</button>
                <script>
                    function toggleSubjectForm() {
                        var form = document.getElementById("allot-subject-form");
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
                <%@ page import="java.sql.*" %>
                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        // Check which form is submitted

                        // Database connection settings
                        String url = "jdbc:mysql://localhost:3306/dms";
                        String username = "root";
                        //   String password1 = "Asif@1199";

                        Connection conn = null;
                        PreparedStatement pstmt = null;

                        try {
                            // Load the JDBC driver
                            Class.forName("com.mysql.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(url, username, password1);
                            if (request.getParameter("formType").equals("allotSubject")) {
                                // Retrieve form data
                                String facultyId = request.getParameter("facultyId");
                                String subjectId = request.getParameter("subjectId");
                                String semesterId = request.getParameter("semesterId");
                                String courseId = request.getParameter("course");

                                // Create a prepared statement
                                String sql = "INSERT INTO facultySubject (facultyId, subjectId, semesterId, courseId) VALUES (?, ?, ?, ?)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, facultyId);
                                pstmt.setString(2, subjectId);
                                pstmt.setString(3, semesterId);
                                pstmt.setString(4, courseId);

                                // Execute the query
                                pstmt.executeUpdate();

                                // Display success message
                                out.println("<p>Subject allotted successfully to faculty!</p>");
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            // Display error message
                            out.println("<p>Error occurred while allotting subject to faculty! " + e + " </p>");
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
                <div class="timetable" id="faculty">
                    <h2>Manage Faculty</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Faculty ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Qualification</th>
                                <th>Address</th>
                                <th>Research Interest</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Establish database connection and retrieve faculty records --%>
                            <%@ page import="java.sql.*" %>
                            <%
                                // Database connection settings
                                String url = "jdbc:mysql://localhost:3306/dms";
                                String username = "root";
                                String password = "Asif@1199";

                                Connection conn = null;
                                Statement stmt = null;
                                ResultSet rs = null;

                                try {
                                    // Load the JDBC driver
                                    Class.forName("com.mysql.jdbc.Driver");

                                    // Establish the connection
                                    conn = DriverManager.getConnection(url, username, password);

                                    // Create a statement
                                    stmt = conn.createStatement();

                                    // Execute a query
                                    String sql = "SELECT * FROM Faculty";
                                    rs = stmt.executeQuery(sql);

                                    // Process the result set
                                    while (rs.next()) {
                                        String facultyId = rs.getString("facultyId");
                                        String name = rs.getString("name");
                                        String email = rs.getString("email");
                                        String qualification = rs.getString("qualification");
                                        String address = rs.getString("address");
                                        String researchInterest = rs.getString("research_interest");

                                        // Display faculty information
                                        out.println("<tr>");
                                        out.println("<td>" + facultyId + "</td>");
                                        out.println("<td>" + name + "</td>");
                                        out.println("<td>" + email + "</td>");
                                        out.println("<td>" + qualification + "</td>");
                                        out.println("<td>" + address + "</td>");
                                        out.println("<td>" + researchInterest + "</td>");
                                        out.println("<td><a href='editFaculty?id=" + facultyId + "'>Edit</a>   <a href='deleteFaculty?id=" + facultyId + "'>Delete</a></td>");
                                        out.println("</tr>");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    // Close the database resources
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
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
