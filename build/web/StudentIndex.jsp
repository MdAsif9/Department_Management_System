<%-- 
    Document   : StudentIndex
    Created on : 12-Jul-2023, 11:50:36 pm
    Author     : asifk
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Dashboard</title>
        <link rel="shortcut icon" href="./images/manuuLogo1.png">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <header>
            <div class="logo">
                <img src="./images/manuuLogo1.png" alt="">
                <h2>D<span class="danger">M</span>S</h2>
            </div>
            <div class="navbar">
                <a href="StudentIndex.jsp" class="active">
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="StudentTimeTable.jsp" onclick="timeTableAll()">
                    <span class="material-icons-sharp">today</span>
                    <h3>Time Table</h3>
                </a> 
                <a href="StudentAssignment.jsp" >
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
                String announce = "";
                        String CS = "";
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
            <main>
                <h1>Attendance</h1>
                <!--                <div class="subjects">
                                    <div class="eg">
                                        <span class="material-icons-sharp">architecture</span>
                                        <h3>Engineering Graphics</h3>
                                        <h2>12/14</h2>
                                        <div class="progress">
                                            <svg><circle cx="38" cy="38" r="36"></circle></svg>
                                            <div class="number"><p>86%</p></div>
                                        </div>
                                        <small class="text-muted">Last 24 Hours</small>
                                    </div>
                                    <div class="mth">
                                        <span class="material-icons-sharp">functions</span>
                                        <h3>Mathematical Engineering</h3>
                                        <h2>27/29</h2>
                                        <div class="progress">
                                            <svg><circle cx="38" cy="38" r="36"></circle></svg>
                                            <div class="number"><p>93%</p></div>
                                        </div>
                                        <small class="text-muted">Last 24 Hours</small>
                                    </div>
                                    <div class="cs">
                                        <span class="material-icons-sharp">computer</span>
                                        <h3>Computer Architecture</h3>
                                        <h2>27/30</h2>
                                        <div class="progress">
                                            <svg><circle cx="38" cy="38" r="36"></circle></svg>
                                            <div class="number"><p>81%</p></div>
                                        </div>
                                        <small class="text-muted">Last 24 Hours</small>
                                    </div>
                                    <div class="cg">
                                        <span class="material-icons-sharp">dns</span>
                                        <h3>Database Management</h3>
                                        <h2>24/25</h2>
                                        <div class="progress">
                                            <svg><circle cx="38" cy="38" r="36"></circle></svg>
                                            <div class="number"><p>96%</p></div>
                                        </div>
                                        <small class="text-muted">Last 24 Hours</small>
                                    </div>
                                    <div class="net">
                                        <span class="material-icons-sharp">router</span>
                                        <h3>Network Security</h3>
                                        <h2>25/27</h2>
                                        <div class="progress">
                                            <svg><circle cx="38" cy="38" r="36"></circle></svg>
                                            <div class="number"><p>92%</p></div>
                                        </div>
                                        <small class="text-muted">Last 24 Hours</small>
                                    </div>
                                    <div class="net">
                                        <span class="material-icons-sharp">router</span>
                                        <h3>Network Security</h3>
                                        <h2>25/27</h2>
                                        <div class="progress">
                                            <svg><circle cx="38" cy="38" r="36"></circle></svg>
                                            <div class="number"><p>92%</p></div>
                                        </div>
                                        <small class="text-muted">Last 24 Hours</small>
                                    </div>-->
                <!--</div>-->
                <div class="subjects">
                    <%    
// Define your database connection details
                        try {
                            // Load the JDBC driver
                            Class.forName(driver);

                            // Establish a connection to the database
                            conn = DriverManager.getConnection(url, username, password);
                            Connection conn1 = DriverManager.getConnection(url, username, password);
                            // Prepare the SQL query to fetch subjects
                            String query1 = "select * from Announcement";
                            Statement s5 = conn.createStatement();
                            String query = "SELECT * FROM subject WHERE semesterId = ?";
                            pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, semesterId);
                            ResultSet rs32 = s5.executeQuery(query1);
                            while (rs32.next()) {
                                announce=rs32.getString("announ");
                                CS=rs32.getString("courseId");
                            }
                            // Execute the query
                            ResultSet rs11 = null;
                            ResultSet rs12 = null;
                            rs = pstmt.executeQuery();

                            // Iterate through the result set and display subjects
                            while (rs.next()) {
                                String subjectName = rs.getString("name");
                                String subjectId = rs.getString("subjectId");
                                String q1 = "SELECT COUNT(DISTINCT attendanceDate) AS total FROM attendance WHERE subjectId='" + subjectId + "'";
                                String q2 = "SELECT COUNT(STATUS) AS obtain FROM attendance WHERE subjectId='" + subjectId + "' AND rollno='" + rollno + "'";
                                Statement s1 = conn.createStatement();
                                Statement s2 = conn.createStatement();
                                rs11 = s1.executeQuery(q1);
                                rs12 = s2.executeQuery(q2);
                                int totalMarks = 0;
                                int obtainedMarks = 0;
                                if (rs11.next()) {
                                    totalMarks = rs11.getInt("total");
                                }
                                if (rs12.next()) {
                                    obtainedMarks = totalMarks - rs12.getInt("obtain");
                                }

                                // Calculate the percentage
                                double percentage = 0;
                                if (totalMarks != 0) {
                                    percentage = (obtainedMarks * 100.0) / totalMarks;
                                }

                    %>

                    <div class="cs">
                        <span class="material-icons-sharp">architecture</span>
                        <h3><%= subjectName%></h3>
                        <h2><%= obtainedMarks%>/<%= totalMarks%></h2>
                        <div class="progress">
                            <!--<svg><circle cx="38" cy="38" r="38"></circle></svg>-->
                            <div class="number"><p><%= String.format("%.2f", percentage)%>%</p></div>
                        </div>
                        <small class="text-muted">Last 24 Hours</small>
                    </div>

                    <%
                                rs11.close();
                                rs12.close();
                                s2.close();
                                s1.close();
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            // Handle the case where an exception occurs during database access
                            out.println("An error occurred while fetching subjects." + semesterId + e);
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
                </div>
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
            </main>
            <%

            %>
            <div class="right">
                <div class="announcements">
                    <h2>Announcements</h2>
                    <div class="updates">
                        <div class="message">
                            <p> <b>Academic</b> <%=announce%>.</p>
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
                <%!
                    // Java method to get the present day name
                    public String getCurrentDay() {
                        String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
                        return days[dayOfWeek - 1];
                    }
                %>
                <div class="leaves">
                    <h2>Teachers for today's classes</h2>
                    <%                        Statement stmt = null;
                        String pday = getCurrentDay().toUpperCase();
//                        pday="MONDAY";
                        // Define your database connection details
                        try {
                            // Load the JDBC driver
                            Class.forName("com.mysql.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(url, username, password);

                            // Create a statement
                            stmt = conn.createStatement();

                            // Prepare the SQL query to fetch subjects
                            String query = "SELECT NAME FROM faculty WHERE facultyId IN(SELECT facultyId FROM facultysubject WHERE subjectId IN (SELECT subjectId FROM timetable WHERE DAY='" + pday + "' AND semesterId='" + semesterId + "'));";
                            rs = stmt.executeQuery(query);
                            // Execute the query
                            while (rs.next()) {
                                String name1 = rs.getString("name");


                    %>

                    <div class="teacher">
                        <!--<div class="profile-photo"><img src="./images/KhalidaAfroaz.jpg" alt="Faculty"></div>-->
                        <div class="info">
                            <h3><%=name1%></h3>
                            <small class="text-muted">Full Day</small>
                        </div>
                    </div>

                    <%
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
                    <!--                    <div class="teacher">
                                            <div class="profile-photo"><img src="./images/Afrah.jpg" alt=""></div>
                                            <div class="info">
                                                <h3>Afra Fathima</h3>
                                                <small class="text-muted">Half Day</small>
                                            </div>
                                        </div>
                                        <div class="teacher">
                                            <div class="profile-photo"><img src="./images/Geeta.jpg" alt=""></div>
                                            <div class="info">
                                                <h3>Geeta Pattun</h3>
                                                <small class="text-muted">Full Day</small>
                                            </div>
                                        </div>-->
                </div>

            </div>
        </div>
        <%            ArrayList<ArrayList<String>> mon = new ArrayList<>();
            ArrayList<ArrayList<String>> tue = new ArrayList<>();
            ArrayList<ArrayList<String>> wed = new ArrayList<>();
            ArrayList<ArrayList<String>> thu = new ArrayList<>();
            ArrayList<ArrayList<String>> fri = new ArrayList<>();
            try {
                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish the connection
                conn = DriverManager.getConnection(url, username, password);

                // Create a statement
                stmt = conn.createStatement();

                // Execute a query
                String sql = "SELECT * FROM timetable WHERE semesterId='" + semesterId + "'";
                rs = stmt.executeQuery(sql);
                out.println("<h1>HI</h1>");
                // Process the result set and generate the timetable entries
                while (rs.next()) {
                    //  out.println("<h1>HI</h1>");
                    ArrayList<String> list = new ArrayList<>();
                    String time = rs.getString("time");
                    String roomNumber = rs.getString("roomno");
                    String subject = rs.getString("subjectId");
                    list.add(time);
                    list.add(roomNumber);
                    list.add(subject);
                    if (rs.getString("day").equals("MONDAY")) {
                        mon.add(list);
                    } else if (rs.getString("day").equals("TUESDAY")) {
                        tue.add(list);
                    } else if (rs.getString("day").equals("WEDNESDAY")) {
                        wed.add(list);
                    } else if (rs.getString("day").equals("THURSDAY")) {
                        thu.add(list);
                    } else if (rs.getString("day").equals("FRIDAY")) {
                        fri.add(list);
                    }

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
        <script>
            const Sunday = [
            {
            time: 'Sunday',
                    roomNumber: 'Holiday',
                    subject: 'No class Available',
                    type: ''
            }
            ];
            const Monday = [
            <%
                for (ArrayList<String> i : mon) {

            %>
            {
            time: '<%=i.get(0)%>',
                    roomNumber: '<%=i.get(1)%>',
                    subject: '<%=i.get(2)%>',
                    type: 'Lecture'
            },
            <%}%>
            ];
            const Tuesday = [
            <%
                for (ArrayList<String> i : tue) {
            %>
            {
            time: '<%=i.get(0)%>',
                    roomNumber: '<%=i.get(1)%>',
                    subject: '<%=i.get(2)%>',
                    type: 'Lecture'
            },
            <%}%>
            ];
            const Wednesday = [
            <%
                for (ArrayList<String> i : wed) {

            %>
            {
            time: '<%=i.get(0)%>',
                    roomNumber: '<%=i.get(1)%>',
                    subject: '<%=i.get(2)%>',
                    type: 'Lecture'
            },
            <%}%>
            ];
            const Thursday = [
            <%
                for (ArrayList<String> i : thu) {

            %>
            {
            time: '<%=i.get(0)%>',
                    roomNumber: '<%=i.get(1)%>',
                    subject: '<%=i.get(2)%>',
                    type: 'Lecture'
            },
            <%}%>
            ];
            const Friday = [
            <%
                for (ArrayList<String> i : fri) {

            %>
            {
            time: '<%=i.get(0)%>',
                    roomNumber: '<%=i.get(1)%>',
                    subject: '<%=i.get(2)%>',
                    type: 'Lecture'
            },
            <%}%>

            ];
            const Saturday = [
            {
            time: 'Sunday',
                    roomNumber: 'Holiday',
                    subject: 'No class Available',
                    type: ''
            }
            ];
        </script>

        <script src="app.js"></script>
    </body>
</html>