<%-- 
    Document   : FacultyIndex
    Created on : 13-Jul-2023, 5:45:38 pm
    Author     : asifk
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Faculty Dashboard</title>
        <link rel="shortcut icon" href="./images/manuuLogo1.png">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
        <link rel="stylesheet" href="style.css">
    </head>

    <body>
        <header>
            <div class="logo" title="University Management System">
                <img src="./images/manuuLogo1.png" alt="">
                <h2>D<span class="danger">M</span>S</h2>
            </div>
            <div class="navbar">
                <a href="FacultyIndex.html" class="active">
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="FacultyAttendence.jsp">
                    <span class="material-icons-sharp">calendar_today</span>
                    <h3>Attendance</h3>
                </a>
                <a href="FacultyAssignment.jsp">
                    <span class="material-symbols-outlined">assessment</span>
                    <h3>Assignment & Notes</h3>
                </a>
                <a href="FacultyTimeTable.jsp">
                    <span class="material-icons-sharp">today</span>
                    <h3>Time Table</h3>
                </a>
                <a href="index.html">
                    <span class="material-icons-sharp">password</span>
                    <h3>Change Password</h3>
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

            <%
                // Define your database connection details
                
                String driver = "com.mysql.jdbc.Driver";
                String url = "jdbc:mysql://localhost:3306/dms";
                String username = "root";
                String password = "Asif@1199";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                String facultyId=(String)session.getAttribute("facultyId");
                request.getSession().setAttribute("facultyId", facultyId);

                try {
                    // Load the JDBC driver
                    Class.forName(driver);

                    // Establish a connection to the database
                    conn = DriverManager.getConnection(url, username, password);

                    // Prepare the SQL query to fetch faculty details
                    String query = "SELECT * FROM faculty WHERE facultyId = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1,facultyId);

                    // Execute the query
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // Retrieve the faculty details from the result set
                        String name = rs.getString("name");
                     //   String department = rs.getString("department");
                        String qualification = rs.getString("qualification");
                        String researchInterests = rs.getString("research_interest");
//                        String contact = rs.getString("contact");
                        String email = rs.getString("email");
                        String address = rs.getString("address");

            %>
            <aside>
                <div class="profile">
                    <div class="top">
                        <div class="profile-photo">
                            <img src="./images/KhalidaAfroaz.jpg" alt="">
                        </div>
                        <div class="info">
                            <p>Hey, <b><%= name%></b></p>
                            <small class="text-muted">CS&IT</small>
                        </div>
                    </div>
                    <div class="about">
                        <h5>Qualification</h5>
                        <p><%= qualification%></p>
                        <h5>Research Interests</h5>
                        <p><%= researchInterests%></p>
                        <h5>Faculty ID</h5>
                        <p><%= facultyId%></p>
                        <h5>Email</h5>
                        <p><%= email%></p>
                        <h5>Address</h5>
                        <p><%= address%></p>
                    </div>
                </div>
            </aside>
            <%
                    } else {
                        // Handle the case where the faculty details are not found
                        out.println("Faculty details not found.");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    // Handle the case where an exception occurs during database access
                    out.println("An error occurred while fetching faculty details."+facultyId);
                } finally {
                    // Close the database connections and resources
                    if (rs != null) {
                        rs.close();
                    }
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
            %>
            <main>
                <div class="timetable" id="timetable">
                    <div>
                        <span id="prevDay">&lt;</span>
                        <h2>Today's Timetable</h2>
                        <span id="nextDay">&gt;</span>
                    </div>
                    <span class="closeBtn" onclick="timeTableAll()">X</span>
                    <table>
                        <thead>
                            <tr>
                                <th>Time</th>
                                <th>Room No.</th>
                                <th>Subject</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <div class="timetable" id="timetable">
                    <h1>Submitted Assignments - Faculty</h1>
                    <p>Here are the submitted assignments for the selected classroom:</p>

                    <form method="post" action="">
                        <label for="classroom">Select Classroom:</label>
                        <select name="classroom" id="classroom">
                            <option value="101">101</option>
                            <option value="102">102</option>
                            <option value="103">103</option>
                            <!-- Add more options for additional classrooms -->
                        </select>
                        <input type="submit" value="Submit">
                    </form>

                    <table>
                        <thead>
                            <tr>
                                <th>Assignment Title</th>
                                <th>Student Name</th>
                                <th>Submission Date</th>
                                <th>File</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                </div>
            </main>
            <div class="right">
                <div class="announcements">
                    <h2>Recent Activity</h2>
                    <div class="updates">

                        <div class="message">
                            <p> <b>New Notification</b> have a new notification from the university management. Please check
                                your email for more details.</p>
                            <small class="text-muted">5 minutes ago</small>
                        </div>
                        <div class="message">
                            <p> <b>New Assignment submissions</b> Md Asif submited his assignment.</p>
                            <small class="text-muted">10 minutes ago</small>
                        </div>
                    </div>
                </div>
                <div class="announcements">
                    <h2>Announcements</h2>
                    <div class="updates">
                        <div class="message">
                            <p> <b>Academic</b> Summer training internship with Live Projects.</p>
                            <small class="text-muted">2 Minutes Ago</small>
                        </div>
                        <div class="message">
                            <p> <b>Co-curricular</b> Global internship oportunity by Student organization.</p>
                            <small class="text-muted">10 Minutes Ago</small>
                        </div>
                        <div class="message">
                            <p> <b>Examination</b> Instructions for Mid Term Examination.</p>
                            <small class="text-muted">Yesterday</small>
                        </div>

                    </div>
                </div>

            </div>
        </div>
        <script src="facultytimetable.js"></script>
        <script src="script.js"></script>
        <script src="app.js"></script>
    </body>

</html>
