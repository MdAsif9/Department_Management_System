<%-- 
    Document   : adminStudent
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
                <a href="AdminIndex.jsp" >
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="adminStudent.jsp" class="active">
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
                <!-- Sidebar content -->


                <div id="add-student-form" style="display: none;">
                    <h1>Add Student</h1>
                    <form  method="post">
                        <label for="rollNo">Roll No:</label>
                        <input type="text" id="rollNo" name="rollNo" required>
                        <label for="enroll">Enroll:</label>
                        <input type="text" id="enroll" name="enroll" required>
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                        <label for="courseId">Course ID:</label>
                        <input type="text" id="courseId" name="courseId" required>
                        <label for="semesterId">Semester ID:</label>
                        <input type="text" id="semesterId" name="semesterId" required>
                        <label for="dob">Birthday:</label>
                        <input type="date" id="dob" name="dob">
                        <label for="address">Address:</label>
                        <textarea id="address" name="address" rows="4" cols="20"></textarea>
                        <button type="submit">Add Student</button>
                    </form>
                </div>

                <button id="toggle-form" onclick="toggleForm()"><h3>Add Student</h3></button>
                <script>
                    function toggleForm() {
                        var form = document.getElementById("add-student-form");
                        var toggleBtn = document.getElementById("toggle-form");
                        if (form.style.display === "none") {
                            form.style.display = "block";
                            toggleBtn.innerText = "Hide Form";
                        } else {
                            form.style.display = "none";
                            toggleBtn.innerText = "Add Student";
                        }
                    }
                </script>
                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        String rollNo = request.getParameter("rollNo");
                        String enroll = request.getParameter("enroll");
                        String password = request.getParameter("password");
                        String name = request.getParameter("name");
                        String email = request.getParameter("email");
                        String courseId = request.getParameter("courseId");
                        String semesterId = request.getParameter("semesterId");
                        String dob = request.getParameter("dob");
                        String address = request.getParameter("address");

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

                            // Create a prepared statement
                            String sql = "INSERT INTO Student (rollno, enroll, password, name, email, courseId, semesterId, dob, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                            LocalDate dob1 = LocalDate.parse(dob, formatter);
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, rollNo);
                            pstmt.setString(2, enroll);
                            pstmt.setString(3, password);
                            pstmt.setString(4, name);
                            pstmt.setString(5, email);
                            pstmt.setString(6, courseId);
                            pstmt.setString(7, semesterId);
                            pstmt.setDate(8, java.sql.Date.valueOf(dob1));
                            pstmt.setString(9, address);

                            // Execute the query
                            pstmt.executeUpdate();

                            // Display success message
                            out.println("<p>Student added successfully!</p>");

                        } catch (Exception e) {
                            e.printStackTrace();
                            // Display error message
                            out.println("<p>Error occurred while adding student! " + e + " </p>");
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
                <div class="timetable" id="student-data">
                    <h2>Manage Students</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Roll No</th>
                                <th>Enroll</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Course ID</th>
                                <th>Semester ID</th>
                                <th>Age</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Establish database connection and retrieve student records --%>
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
                                    String sql = "SELECT * FROM Student";
                                    rs = stmt.executeQuery(sql);

                                    // Process the result set
                                    while (rs.next()) {
                                        String rollNo = rs.getString("rollno");
                                        String enroll = rs.getString("enroll");
                                        String name = rs.getString("name");
                                        String email = rs.getString("email");
                                        String courseId = rs.getString("courseId");
                                        String semesterId = rs.getString("semesterId");
                                        java.sql.Date dob = rs.getDate("dob");
                                        LocalDate dateOfBirth = dob.toLocalDate();
                                        LocalDate currentDate = LocalDate.now();

                                        Period age = Period.between(dateOfBirth, currentDate);

                                        // Display student information
                                        out.println("<tr>");
                                        out.println("<td>" + rollNo + "</td>");
                                        out.println("<td>" + enroll + "</td>");
                                        out.println("<td>" + name + "</td>");
                                        out.println("<td>" + email + "</td>");
                                        out.println("<td>" + courseId + "</td>");
                                        out.println("<td>" + semesterId + "</td>");
                                        out.println("<td>" + age.getYears() + "</td>");
                                        out.println("<td><a href='editStudent?id=" + enroll + "'>Edit</a>   <a href='deleteStudent?id=" + enroll + "'>Delete</a></td>");
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
                <button class="timetable" id="student-form" onclick="studentForm()"><h3>Add Student</h3></button>
                <script>
                    function studentForm() {
                        var form = document.getElementById("student-data");
                        var toggleBtn2 = document.getElementById("student-form");
                        if (form.style.display === "none") {
                            form.style.display = "block";
                            toggleBtn2.innerText = "Hide Form";
                        } else {
                            form.style.display = "none";
                            toggleBtn2.innerText = "Add Student";
                        }
                    }
                </script>
            </main>
            <div class="right">
                <div id="communication" >
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
