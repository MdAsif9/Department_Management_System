<%-- 
    Document   : StudentTimeTable
    Created on : 14-Jul-2023, 10:12:41 pm
    Author     : asifk
--%>

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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
        <link rel="shortcut icon" href="./images/manuuLogo1.png">
        <link rel="stylesheet" href="style.css">
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
                <a href="StudentTimeTable.jsp"class="active" onclick="timeTableAll()">
                    <span class="material-icons-sharp">today</span>
                    <h3>Time Table</h3>
                </a> 
                <a href="StudentAssignment.jsp"  >
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
<%String rollno= (String) session.getAttribute("rollno");%>
<%String semesterId = (String) session.getAttribute("semesterId");%>
<%String courseId = (String) session.getAttribute("courseId");%>
       <main style="margin: 0;">
        <div class="timetable active" id="timetable">
            <div>
                <span id="prevDay">&lt;</span>
                <h2>Today's Timetable</h2>
                <span id="nextDay">&gt;</span>
            </div>
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
            <% String url = "jdbc:mysql://localhost:3306/dms";
                String username = "root";
                String password = "Asif@1199";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                ArrayList<ArrayList<String>>mon=new ArrayList<>();
                ArrayList<ArrayList<String>>tue=new ArrayList<>();
                ArrayList<ArrayList<String>>wed=new ArrayList<>();
                ArrayList<ArrayList<String>>thu=new ArrayList<>();
                ArrayList<ArrayList<String>>fri=new ArrayList<>();
                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Establish the connection
                    conn = DriverManager.getConnection(url, username, password);

                    // Create a statement
                    stmt = conn.createStatement();

                    // Execute a query
                    String sql = "SELECT * FROM timetable WHERE semesterId='"+semesterId+"'";
                    rs = stmt.executeQuery(sql);
                    out.println("<h1>HI</h1>");
                    // Process the result set and generate the timetable entries
                    while (rs.next()) {
                        //  out.println("<h1>HI</h1>");
                        ArrayList<String>list=new ArrayList<>();
                        String time = rs.getString("time");
                        String roomNumber = rs.getString("roomno");
                        String subject = rs.getString("subjectId");
                        list.add(time);
                        list.add(roomNumber);
                        list.add(subject);
                        if(rs.getString("day").equals("MONDAY")){
                            mon.add(list);
                        }
                        else if(rs.getString("day").equals("TUESDAY"))tue.add(list);
                        else if(rs.getString("day").equals("WEDNESDAY"))wed.add(list);
                        else if(rs.getString("day").equals("THURSDAY"))thu.add(list);
                        else if(rs.getString("day").equals("FRIDAY"))fri.add(list);
          
           
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

    </body>
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
                        for(ArrayList<String> i:mon){

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
                        for(ArrayList<String> i:tue){ 
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
                        for(ArrayList<String> i:wed){

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
                        for(ArrayList<String> i:thu){

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
                        for(ArrayList<String> i:fri){

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
    <!-- <script src="timeTable.js"></script> -->
    <script src="app.js"></script>
</html>
