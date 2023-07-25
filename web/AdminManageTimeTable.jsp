<%-- 
    Document   : AdminManageTimeTable
    Created on : 15-Jul-2023, 3:23:50 am
    Author     : asifk
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Timetable</title>
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
                <a href="AdminManageTimeTable.jsp" class="active">
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
                <h1>Add Timetable</h1>
                <div class="timetable">
                    <h2>Add Timetable</h2>
                    <form method="post">
                        <label for="courseId">Course ID:</label>
                        <input type="text" id="courseId" name="courseId" required><br>
                        <label for="subjectId">Subject ID:</label>
                        <input type="text" id="subjectId" name="subjectId" required><br>
                        <label for="class">Class:</label>
                        <input type="text" id="class" name="class" required><br>
                        <label for="room">Room No:</label>
                        <input type="text" id="room" name="room" required><br>
                        <label for="day">Day:</label>
                        <select id="day" name="day" required>
                            <option value="Monday">Monday</option>
                            <option value="Tuesday">Tuesday</option>
                            <option value="Wednesday">Wednesday</option>
                            <option value="Thursday">Thursday</option>
                            <option value="Friday">Friday</option>
                        </select><br>
                        <label for="time">Time:</label>
                        <select id="time" name="time" required>
                            <option value="09:00 AM">09:00 AM</option>
                            <option value="10:00 AM">10:00 AM</option>
                            <option value="11:00 AM">11:00 AM</option>
                            <option value="12:00 PM">12:00 PM</option>
                            <option value="02:00 PM">02:00 PM</option>
                            <option value="03:00 PM">03:00 PM</option>
                            <option value="04:00 PM">04:00 PM</option>
                        </select><br>

                        <button type="submit">Add Timetable</button>
                    </form>
                </div>


                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        // Retrieve form data
                        String className = request.getParameter("class");
                        String roomNo = request.getParameter("room");
                        String day = request.getParameter("day");
                        String time = request.getParameter("time");
                        String courseId = request.getParameter("courseId");
                        String subjectId = request.getParameter("subjectId");

                        // Database connection settings
                        String url = "jdbc:mysql://localhost:3306/dms";
                        String username = "root";
                        String password = "Asif@1199";

                        Connection conn = null;
                        PreparedStatement pstmt = null;

                        try {
                            // Load the JDBC driver
                            Class.forName("com.mysql.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(url, username, password);

                            // Create a prepared statement
                            String sql = "INSERT INTO TimeTable (semesterId, roomno, day, time, courseId, subjectId) VALUES (?, ?, ?, ?, ?, ?)";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, className);
                            pstmt.setString(2, roomNo);
                            pstmt.setString(3, day);
                            pstmt.setString(4, time);
                            pstmt.setString(5, courseId);
                            pstmt.setString(6, subjectId);

                            // Execute the query
                            pstmt.executeUpdate();

                            // Display success message
                            out.println("<p>Timetable added successfully!</p>");
                        } catch (Exception e) {
                            e.printStackTrace();
                            // Display error message
                            out.println("<p>Error occurred while adding timetable! " + e + " </p>");
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

            </main>
        </div>

        <script src="script.js"></script>
        <script src="app.js"></script>
    </body>
</html>

