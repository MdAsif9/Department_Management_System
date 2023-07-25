<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Update Assignment</title>
</head>
<body>
    <% 
    try {
        // Establish a connection to your MySQL database
        String url = "jdbc:mysql://localhost:3306/dms";
        String username = "root";
        String password = "Asif@1199";
        Connection conn = DriverManager.getConnection(url, username, password);
        
        // Retrieve the form parameters
        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        String completionStatus = request.getParameter("complete") != null ? "Complete" : "Incomplete";
        
        // Prepare and execute the SQL statement to update the assignment data
        String sql = "UPDATE assignments SET completion_status = ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, completionStatus);
        stmt.setInt(2, assignmentId);
        stmt.executeUpdate();
        
        // Close database connections
        stmt.close();
        conn.close();
        
        out.println("Assignment updated successfully.");
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
    %>
</body>
</html>
