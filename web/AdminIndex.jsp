<%-- 
    Document   : AdminIndex
    Created on : 13-Jun-2023, 6:58:28 pm
    Author     : asifk
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <a href="AdminIndex.jsp" class="active">
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
        <div class="profile">
            <div class="top">
                <div class="profile-photo">
                    <img src="./images/profile-2.jpeg" alt="">
                </div>
                <div class="info">
                    <p>Hey, <b>Admin</b> </p>
                    <small class="text-muted">Admin</small>
                </div>
            </div>
        </div>
    </aside>

    <main>
        <h1>Overview</h1>
        <div class="overview-cards">
            <div class="students-card">
                <div class="card-icon">
                    <span class="material-icons-sharp">people</span>
                </div>
                <div class="card-info">
                    <h2>500</h2>
                    <h3>Total Students</h3>
                </div>
            </div>
            <div class="teachers-card">
                <div class="card-icon">
                    <span class="material-icons-sharp">person</span>
                </div>
                <div class="card-info">
                    <h2>50</h2>
                    <h3>Total Teachers</h3>
                </div>
            </div>
            <div class="courses-card">
                <div class="card-icon">
                    <span class="material-icons-sharp">assignment</span>
                </div>
                <div class="card-info">
                    <h2>20</h2>
                    <h3>Total Courses</h3>
                </div>
            </div>
            <div class="enrollments-card">
                <div class="card-icon">
                    <span class="material-symbols-outlined">FILL</span>
                </div>
                <div class="card-info">
                    <h2>2000</h2>
                    <h3>Total Enrollments</h3>
                </div>
            </div>
        </div>
    </main>
    <div class="right">
        <div class="announcements">
            <h1>Announcements</h1>
            <div class="updates">
                
                <form id="upload-notice-form">
                    <label for="notice-title">Announcements Title:</label>
                    <input type="text" id="notice-title" name="notice-title" required>
                    <label for="notice-date">Date:</label>
                    <input type="date" id="notice-date" name="notice-date" required>
                    <label for="notice-file">File:</label>
                    <input type="file" id="notice-file" name="notice-file" accept=".pdf" required>
                    <button type="submit" id="submit-notice-btn">Upload</button>
                </form>
            </div>
        </div>
        <div class="announcements">
            <h1>Upload Notice</h1>
            <div class="updates">
                
            <form id="upload-notice-form" method="POST">
                <input type="hidden" name="formType" value="Announce">
                <label for="notice-title">Announcement For Student:</label>
                <input type="text" id="notice-title" name="notice_title" required>
<!--                <label for="notice-date">Notice Date:</label>
                <input type="date" id="notice-date" name="notice-date" required>-->
                <label for="notice-file">Notice File:</label>
                <input type="text" id="notice-file" name="notice_file"  required>
                <button type="submit" id="submit-notice-btn">Upload Notice</button>
            </form>
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
                            if (request.getParameter("formType").equals("Announce")) {
                                // Retrieve form data
                                
                                String Announce= request.getParameter("notice_file");
                                String courseName = request.getParameter("notice_file");

                                // Create a prepared statement
                                String sql = "INSERT INTO Announcement (announ, courseId) VALUES (?, ?)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, Announce);
                                pstmt.setString(2, courseName);

                                // Execute the query
                                pstmt.executeUpdate();

                                // Display success message
                                out.println("<p>Announcement Done!</p>");
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

                
            </div>
        </div>
       
    </div>
</div>

<script src="script.js"></script>
<script src="app.js"></script>
</body>
</html>

