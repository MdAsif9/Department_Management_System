<%-- 
    Document   : FacultyIndex
    Created on : 13-Jul-2023, 5:45:38 pm
    Author     : asifk
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
                <a href="FacultyIndex.jsp">
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="FacultyAttendence.jsp">
                    <span class="material-icons-sharp">calendar_today</span>
                    <h3>Attendance</h3>
                </a>
                <a href="FacultyAssignment.jsp" class="active">
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
                ArrayList<String> subject = new ArrayList<>();
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                Connection conn1 = null;
                PreparedStatement pstmt1 = null;
                ResultSet rs1 = null;
                String facultyId = (String) session.getAttribute("facultyId");
                request.getSession().setAttribute("facultyId", facultyId);

                try {
                    // Load the JDBC driver
                    Class.forName(driver);

                    // Establish a connection to the database
                    conn = DriverManager.getConnection(url, username, password);
                    conn1 = DriverManager.getConnection(url, username, password);

                    // Prepare the SQL query to fetch faculty details
                    String query = "SELECT * FROM faculty WHERE facultyId = ?";
                    String query1 = "SELECT * FROM facultysubject WHERE facultyId = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt1 = conn1.prepareStatement(query1);
                    pstmt.setString(1, facultyId);
                    pstmt1.setString(1, facultyId);

                    // Execute the query
                    rs = pstmt.executeQuery();
                    rs1 = pstmt1.executeQuery();
                    while (rs1.next()) {
                        subject.add(rs1.getString("subjectId"));
                    }
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
                            <!--<img src="./images/KhalidaAfroaz.jpg" alt="">-->
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
                        rs1.close();
                        pstmt1.close();
                        conn1.close();
                    } else {
                        // Handle the case where the faculty details are not found
                        out.println("Faculty details not found.");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    // Handle the case where an exception occurs during database access
                    out.println("An error occurred while fetching faculty details." + facultyId + e);
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
                <div class="main-top">
                    <p>Welcome to the Assignments page for faculty members.</p>
                    <h2>Create a New Assignment</h2>
                    <form  method="post" >
                        <input type="hidden" name="formType" value="create">
                        <label for="title">Assignment Title:</label>
                        <input type="text" name="title" id="title" required><br><br>
                        <label for="description">Assignment Description:</label>
                        <textarea name="description" id="description" rows="5" required></textarea><br><br>
                        <label for="due_date">Due Date:</label>
                        <input type="date" name="due_date" id="due_date" required><br><br>
                        <label for="classroom">subject:</label>
                        <select name="subjectId" id="subject" required>
                            <option value="">-- Select Subject --</option>
                            <%for (String subjectId : subject) {%>
                            <option value="<%=subjectId%>"><%=subjectId%></option>
                            <%}%>
                            <!-- Add more options for additional classrooms -->
                        </select><br><br>
                        <button type="submit">Create Assignment</button>
                    </form>
                    <%
                        String due_date = "";
                        String assignment_name = "";
                        String description = "";
                        String semesterId = "";
                        String subjectId = "";
                        int k = 0;

                        if (request.getMethod().equalsIgnoreCase("POST")) {
                            try {
                                // Load the JDBC driver
                                Class.forName("com.mysql.jdbc.Driver");

                                // Establish the connection
                                conn = DriverManager.getConnection(url, username, password);
                                conn1 = DriverManager.getConnection(url, username, password);
                                subjectId = request.getParameter("subjectId");
                                String sql1 = "SELECT semesterId FROM subject WHERE subjectId=?";
                                pstmt1 = conn1.prepareStatement(sql1);
                                pstmt1.setString(1, subjectId);
                                rs = pstmt1.executeQuery();

                                if (rs.next()) {
                                    semesterId = rs.getString("semesterId");
                                }

                                if (request.getParameter("formType").equals("create")) {
                                    // Retrieve form data
                                    assignment_name = request.getParameter("title");
                                    description = request.getParameter("description");
                                    due_date = request.getParameter("due_date");

                                    // Create a prepared statement
                                    String sql = "INSERT INTO facultyassignment (semesterId, subjectId, assignment_name, description, due_date) VALUES (?, ?, ?, ?, ?)";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, semesterId);
                                    pstmt.setString(2, subjectId);
                                    pstmt.setString(3, assignment_name);
                                    pstmt.setString(4, description);
                                    pstmt.setString(5, due_date);

                                    k = 1;
                                    // Execute the query
                                    pstmt.executeUpdate();
                                }

                                Connection conn3 = DriverManager.getConnection(url, username, password);
                                Connection conn4 = DriverManager.getConnection(url, username, password);
                                String sql3 = "INSERT INTO assignments (semesterId, rollno, subjectId, assignment_name, description, due_date, Your_ans, completion_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                                String sql = "SELECT rollno FROM student WHERE semesterId='" + semesterId + "'";
                                Statement stmt = conn3.createStatement();
                                PreparedStatement pstmt4 = conn4.prepareStatement(sql3);
                                ResultSet rs3 = stmt.executeQuery(sql);
                                while (rs3.next()) {
                                    pstmt4.setString(1, semesterId);
                                    pstmt4.setString(2, rs3.getString("rollno"));
                                    pstmt4.setString(3, subjectId);
                                    pstmt4.setString(4, assignment_name);
                                    pstmt4.setString(5, description);
                                    pstmt4.setString(6, due_date);
                                    pstmt4.setString(7, "Hello");
                                    pstmt4.setString(8, "Incomplete");

                                    pstmt4.executeUpdate();
                                }

                                stmt.close();
                                pstmt4.close();
                                conn3.close();
                                conn4.close();

                                out.println("Created successfully");
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("Error Occurred: " + e.getMessage());
                            } finally {
                                // Close the resources in the reverse order of their creation
                                if (rs != null) {
                                    try {
                                        rs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (pstmt != null) {
                                    try {
                                        pstmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (pstmt1 != null) {
                                    try {
                                        pstmt1.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (conn != null) {
                                    try {
                                        conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (conn1 != null) {
                                    try {
                                        conn1.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        }
                    %>

                </div>
                <div class="timetable" id="timetable">
                    <h2>Previous Assignments</h2>

                    <form name="filterAssignmentsForm">
                        <label for="classroomFilter">Filter by Classroom:</label>
                        <select name="classroomFilter" id="classroomFilter" onchange="filterAssignments()">
                            <option value="">All Classrooms</option>
                            <option value="101">101</option>
                            <option value="102">102</option>
                            <option value="103">103</option>
                            <!-- Add more options for additional classrooms -->
                        </select>
                    </form>

                    <table id="assignmentsTable">
                        <thead>
                            <tr>
                                <th>Assignment Title</th>
                                <th>Description</th>
                                <th>Due Date</th>
                                <th>Classroom</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Assignment 1</td>
                                <td>This is the first assignment.</td>
                                <td>2023-02-24</td>
                                <td>101</td>
                            </tr>
                            <tr>
                                <td>Assignment 2</td>
                                <td>This is the second assignment.</td>
                                <td>2023-03-03</td>
                                <td>102</td>
                            </tr>
                            <!-- Add more rows for additional assignments -->
                        </tbody>
                    </table>
                </div>
            </main>
            <div class="right">
                <div class="announcements">
                    <h2>Recent Activity</h2>
                    <div class="updates">

                        <div class="message">
                            <p><b>New Notification</b> have a new notification from the university management. Please check your email for more details.</p>
                            <small class="text-muted">5 minutes ago</small>
                        </div>
                        <div class="message">
                            <p><b>New Assignment submissions</b> Md Asif submitted his assignment.</p>
                            <small class="text-muted">10 minutes ago</small>
                        </div>
                    </div>
                </div>
                <div class="announcements">
                    <h2>Announcements</h2>
                    <div class="updates">
                        <div class="message">
                            <p><b>Academic</b> Summer training internship with Live Projects.</p>
                            <small class="text-muted">2 Minutes Ago</small>
                        </div>
                        <div class="message">
                            <p><b>Co-curricular</b> Global internship opportunity by Student organization.</p>
                            <small class="text-muted">10 Minutes Ago</small>
                        </div>
                        <div class="message">
                            <p><b>Examination</b> Instructions for Mid Term Examination.</p>
                            <small class="text-muted">Yesterday</small>
                        </div>
                    </div>
                </div>
            </div>
            <script src="script.js"></script>
        </div>
    </body>
    <script src="app.js"></script>
    <script>
                            function validateForm() {
                                var title = document.forms["createAssignmentForm"]["title"].value;
                                var description = document.forms["createAssignmentForm"]["description"].value;
                                var due_date = document.forms["createAssignmentForm"]["due_date"].value;
                                var classroom = document.forms["createAssignmentForm"]["classroom"].value;
                                if (title == "" || description == "" || due_date == "" || classroom == "") {
                                    alert("All fields are required");
                                    return false;
                                }
                            }
    </script>
</html>
