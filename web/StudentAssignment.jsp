<%-- 
    Document   : StudentAssignment
    Created on : 17-Jul-2023, 8:48:21 am
    Author     : asifk
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Dashboard</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
        <link rel="shortcut icon" href="./images/manuuLogo1.png">
        <link rel="stylesheet" href="style.css">

        <style>
            h1 {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            .due-date {
                font-weight: bold;
            }
            .completed {
                color: green;
                font-weight: bold;
            }
            .not-completed {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="logo">
                <img src="./images/manuuLogo1.png" alt="">
                <h2>D<span class="danger">M</span>S</h2>
            </div>
            <div class="navbar">
                <a href="StudentIndex.jsp">
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="StudentTimeTable.jsp" onclick="timeTableAll()">
                    <span class="material-icons-sharp">today</span>
                    <h3>Time Table</h3>
                </a> 
                <a href="StudentAssignment.jsp" class="active" >
                    <span class="material-symbols-outlined">assignment</span>
                    <h3>Assignment</h3>
                </a>
                <a href="StudentExam.jsp">
                    <span class="material-icons-sharp">grid_view</span>
                    <h3>Examination</h3>
                </a>
                <a href="index.html" >
                    <span class="material-icons-sharp">password</span>
                    <h3>Change Password</h3>
                </a>
                <a href="index.html">
                    <span class="material-icons-sharp">logout</span>
                    <h3>Logout</h3>
                </a>
            </div>
            <div id="profile-btn" style="display: none;">
                <span class="material-icons-sharp">person</span>
            </div>
            <div class="theme-toggler">
                <span class="material-icons-sharp active">light_mode</span>
                <span class="material-icons-sharp">dark_mode</span>
            </div>
        </header>
        <div class="container">
            <%
                // Retrieve the student username from the session
                String studentUsername = (String) session.getAttribute("rollno");

                // Check if the student username is available
                if (studentUsername == null) {
                    // Handle the case where the student username is not set
                    response.sendRedirect("login.jsp");
                    return;
                }

                // Define your database connection details
                String driver = "com.mysql.jdbc.Driver";
                String url = "jdbc:mysql://localhost:3306/dms";
                String username = "root";
                String password = "Asif@1199";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                PreparedStatement pstmt1 = null;
                ResultSet rs1 = null;
                String name;
                String rollno = "";
                String courseId = "";
                String course;
                // Retrieve more student details as needed
                String enroll;
                //                        String name = rs.getString("name");
                String email;
                String address;
                //                        String courseId = rs.getString("courseId");
                String semesterId = "";
                String semester;
                java.sql.Date dob;
                try {
                    // Load the JDBC driver
                    Class.forName(driver);

                    // Establish a connection to the database
                    conn = DriverManager.getConnection(url, username, password);

                    // Prepare the SQL query to fetch student details
                    String query = "SELECT * FROM student WHERE rollno = ?";
                    String query1 = "SELECT * FROM course WHERE courseId = ?";
                    String query2 = "SELECT * FROM semester WHERE SemesterId = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, studentUsername);

                    // Execute the query
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // Retrieve the student details from the result set
                        name = rs.getString("name");
                        rollno = rs.getString("rollno");
                        courseId = rs.getString("courseId");
                        // Retrieve more student details as needed
                        enroll = rs.getString("enroll");
                        //                        String name = rs.getString("name");
                        email = rs.getString("email");
                        address = rs.getString("address");
                        //                        String courseId = rs.getString("courseId");
                        semesterId = rs.getString("semesterId");
                        dob = rs.getDate("dob");
                        LocalDate dateOfBirth = dob.toLocalDate();
                        LocalDate currentDate = LocalDate.now();
                        pstmt1 = conn.prepareStatement(query1);
                        pstmt1.setString(1, courseId);
                        rs1 = pstmt1.executeQuery();
                        rs1.next();
                        course = rs1.getString("name");
                        // Display the student details in the page
%>
            <aside>
                <div class="profile">
                    <div class="top">
                        <div class="profile-photo">
                            <img src="./images/Asif.jpg" alt="">
                        </div>
                        <div class="info">
                            <p>Hey, <b><%=name%></b> </p>
                            <small class="text-muted"><%=enroll%></small>
                        </div>
                    </div>
                    <div class="about">
                        <h5>Course</h5>
                        <p><%=course%>. Computer Science & Engineering</p>
                        <h5>DOB</h5>
                        <p><%=dob%></p>
                        <h5>Roll No</h5>
                        <p><%=rollno%></p>
                        <h5>Email</h5>
                        <p><%=email%></p>
                        <h5>Address</h5>
                        <p><%=address%></p>
                    </div>
                </div>
            </aside>
            <%
                    } else {
                        // Handle the case where the student details are not found
                        out.println("Student details not found.");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    // Handle the case where an exception occurs during database access
                    out.println("An error occurred while fetching student details.");
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
                request.getSession().setAttribute("rollno", rollno);
                request.getSession().setAttribute("courseId", courseId);
                request.getSession().setAttribute("semesterId", semesterId);

            %>     
            <!--    <div class="change-password-container">
                <h1>My Assignments</h1>
        
                 Create a table to display the assignments 
                <table>
                        <thead>
                                <tr>
                                        <th>Assignment Title</th>
                                        <th>Due Date</th>
                                        <th>Status</th>
                                </tr>
                        </thead>
                        <tbody>
                                <tr>
                                        <td>Assignment 1</td>
                                        <td class="due-date">March 1, 2023</td>
                                        <td class="completed">Completed</td>
                                </tr>
                                <tr>
                                        <td>Assignment 2</td>
                                        <td class="due-date">March 15, 2023</td>
                                        <td class="not-completed">Not completed</td>
                                </tr>
                                <tr>
                                        <td>Assignment 3</td>
                                        <td class="due-date">April 1, 2023</td>
                                        <td class="not-completed">Not completed</td>
                                </tr>
                                 Add more rows for each assignment 
                        </tbody>
                </table>
                
                 Add a button to view completed assignments 
                <button class="btn" onclick="viewCompleted()">View Completed Assignments</button>
        
                <script>
                        function viewCompleted() {
                                // Code to show the completed assignments
                                alert('Displaying completed assignments');
                        }
                </script>
            </div>-->

            <main>
                <%@ page import="java.sql.*" %>
                <h1>My Assignments</h1>

                <table>
                    <thead>
                        <tr>
                            <th>Assignment Title</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Your Answer</th>
                            <th>Mark as Complete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                try {
                                // Establish a connection to your MySQL database
                                
                                conn = DriverManager.getConnection(url, username, password);

                                // Prepare and execute the SQL statement
                                String sql = "SELECT * FROM assignments WHERE rollno = ?";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                stmt.setString(1, rollno);
                                rs = stmt.executeQuery();

                                // Display the assignments
                                while (rs.next()) {
                                    int assignmentId = rs.getInt("id");
                                    String assignmentName = rs.getString("assignment_name");
                                    Date dueDate = rs.getDate("due_date");
                                    String completionStatus = rs.getString("completion_status");
                                    String yourAnswer = rs.getString("Your_ans");

                                    out.println("<tr>");
                                    out.println("<td>" + assignmentName + "</td>");
                                    out.println("<td>" + dueDate + "</td>");
                                    out.println("<td class=\"" + (completionStatus.equals("Complete") ? "completed" : "not-completed") + "\">" + completionStatus + "</td>");
                                    out.println("<td><textarea name=\"answer_" + assignmentId + "\">" + yourAnswer + "</textarea></td>");
                                    out.println("<td>");
                                    out.println("<form method=\"post\" action=\"updateAssignment.jsp\">");
                                    out.println("<input type=\"hidden\" name=\"assignmentId\" value=\"" + assignmentId + "\">");
                                    out.println("<input type=\"checkbox\" name=\"complete\" value=\"complete\"" + (completionStatus.equals("Complete") ? " checked" : "") + ">");
                                    out.println("<input type=\"submit\" value=\"Save\">");
                                    out.println("</form>");
                                    out.println("</td>");
                                    out.println("</tr>");
                                }

                                // Close database connections
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println("An error occurred: " + e.getMessage());
                            }
                        %>
                    </tbody>
                </table>

                <button class="btn" onclick="viewCompleted()">View Completed Assignments</button>

                <script>
                    function viewCompleted() {
                        // Code to show the completed assignments
                        alert('Displaying completed assignments');
                    }
                </script>

            </main>
        </div>
    </body>

    <script src="app.js"></script>

</html>