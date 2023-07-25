<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Faculty Dashboard</title>
        <link rel="shortcut icon" href="./images/manuuLogo1.png">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
        <link rel="stylesheet" href="style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            main {
                padding: 20px;
            }

            form label {
                display: block;
                font-weight: bold;
                margin-top: 20px;
            }

            form input,
            form button {
                border: none;
                border-radius: 3px;
                font-size: 16px;
                padding: 10px;
            }

            table {
                border-collapse: collapse;
                margin-top: 20px;
                width: 100%;
            }

            th,
            td {
                border: 1px solid #ccc;
                padding: 10px;
            }

            th {
                background-color: #f2f2f2;
                font-weight: normal;
            }

            button[type="submit"] {
                background-color: #333;
                color: #fff;
                margin-top: 20px;
            }
        </style>
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
                <a href="FacultyAttendence.jsp" class="active">
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
                String facultyId = (String) session.getAttribute("facultyId");
                request.getSession().setAttribute("facultyId", facultyId);

                try {
                    // Load the JDBC driver
                    Class.forName(driver);

                    // Establish a connection to the database
                    conn = DriverManager.getConnection(url, username, password);

                    // Prepare the SQL query to fetch faculty details
                    String query = "SELECT * FROM faculty WHERE facultyId = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, facultyId);

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
                    } else {
                        // Handle the case where the faculty details are not found
                        out.println("Faculty details not found.");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    // Handle the case where an exception occurs during database access
                    out.println("An error occurred while fetching faculty details." + facultyId);
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
                <%@ page import="java.sql.*" %>
                <%@ page import="java.util.*" %>
                <h2>Attendance Page</h2>
                <%
                    // Establish a database connection
                    ArrayList<String> studentId1 = new ArrayList<>();
                    String dbUrl = "jdbc:mysql://localhost:3306/dms";
                    String dbUsername = "root";
                    String dbPassword = "Asif@1199";
                   // Connection conn = null;
                    Statement stmt = null;
                    List<String> subjectIds = new ArrayList<>();
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                        // Fetch faculty's subjects from the database
                      //  String facultyId = "FT1";
                        String q = "SELECT subjectId FROM facultysubject WHERE facultyId='" + facultyId + "'";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(q);

                        out.println("<h1> Hello</h1>");
                        // Create a list to store faculty's subject IDs
                        while (rs.next()) {
                            String subjectId = rs.getString("subjectId");

                            subjectIds.add(subjectId);
                        }

                        // Close the result set and statement
                        rs.close();
                        stmt.close();
                    } catch (ClassNotFoundException e) {
                        out.println("<h1> Hello</h1>");
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        // Close the database connection
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>

                <%
//                    int r = (int) session.getAttribute("r");
//                    if (r == 1) {
//
//                        int k = 1;
                %>
                <h1>Attendance Add successfully</h1>

                <form method="POST">
                    <input type="hidden" name="formType" value="getStudent">
                    <label for="subject-select">Subject:</label>
                    <select id="subject-select" name="subject">
                        <option value="">Select a subject</option>
                        <%
                            for (String subjectId : subjectIds) {%>
                        <option value="<%=subjectId%>"><%=subjectId%></option>

                        <% } %>
                    </select>
                    <button type="submit">Get Students</button>
                </form>
                <form id="attendance-form" method="POST" action="SubmitAttendence">

                    <label for="attendance-date">Attendance Date:</label>
                    <input type="date" id="attendance-date" name="attendanceDate" required>
                    <%String Subject1 = request.getParameter("subject");%>
                    <input type="hidden" name="subject" value="<%=Subject1%>">

                    <label>Present students:</label>
                    <table>
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Attendance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                String selectedSemester = "";
                                if (request.getMethod().equalsIgnoreCase("POST")) {
                                    if (request.getParameter("formType").equals("getStudent")) {

                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                                            request.getSession().setAttribute("selectedSubject", Subject1);
                                            String q = "SELECT * FROM student WHERE semesterId=(SELECT semesterId FROM subject WHERE subjectId='" + Subject1 + "')";
                                            stmt = conn.createStatement();
                                            rs = stmt.executeQuery(q);
                                            int i = 1;
                                            while (rs.next()) {

                                                String studentId = rs.getString("rollno");
                                                String studentName = rs.getString("name");
                                                studentId1.add(studentId);
                            %>
                            <tr>
                                <td><%= studentId%></td>
                                <td><%= studentName%></td>
                                <td>

                                    <input type="checkbox" name="attendance[]" value="<%= studentId%>">
                                </td>
                            </tr>
                            <% }

                                            rs.close();
                                            stmt.close();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                    <button type="submit">Submit Attendance</button>
                </form>
            </main>
            <div class="right">
                <div class="announcements">
                    <h2>Recent Activity</h2>
                    <div class="updates">

                        <div class="message">
                            <p> <b>New Notification</b> have a new notification from the university management. Please check your email for more details.</p>
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

        <script src="app.js"></script>
    </body>
</html>
