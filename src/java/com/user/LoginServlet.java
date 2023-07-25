/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.user;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author asifk
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private boolean validateLoginAdmin(String username, String password) {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection to the database
            try ( Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dms", "root", "Asif@1199")) {
                // Prepare the SQL statement
                String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
                try ( PreparedStatement statement = con.prepareStatement(sql)) {
                    statement.setString(1, username);
                    statement.setString(2, password);

                    // Execute the query
                    try ( ResultSet resultSet = statement.executeQuery()) {
                        // Check if the query returned any rows
                        return resultSet.next();
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private boolean validateLoginStudent(String username, String password) {
        // Implement student login validation similar to the admin method
        // using the "student" table in the database
        // Return true if the login is valid; otherwise, return false
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection to the database
            try ( Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dms", "root", "Asif@1199")) {
                // Prepare the SQL statement
                String sql = "SELECT * FROM student WHERE rollno = ? AND password = ?";
                try ( PreparedStatement statement = con.prepareStatement(sql)) {
                    statement.setString(1, username);
                    statement.setString(2, password);

                    // Execute the query
                    try ( ResultSet resultSet = statement.executeQuery()) {
                        // Check if the query returned any rows
                        return resultSet.next();
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean validateLoginFaculty(String username, String password) {
        // Implement faculty login validation similar to the admin method
        // using the "faculty" table in the database
        // Return true if the login is valid; otherwise, return false
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection to the database
            try ( Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dms", "root", "Asif@1199")) {
                // Prepare the SQL statement
                String sql = "SELECT * FROM faculty WHERE facultyId = ? AND password = ?";
                try ( PreparedStatement statement = con.prepareStatement(sql)) {
                    statement.setString(1, username);
                    statement.setString(2, password);

                    // Execute the query
                    try ( ResultSet resultSet = statement.executeQuery()) {
                        // Check if the query returned any rows
                        return resultSet.next();
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String userType = request.getParameter("usertype");

            // Validate the login credentials based on the user type
            boolean isValidLogin = false;
            if ("admin".equals(userType)) {
                isValidLogin = validateLoginAdmin(username, password);
            } else if ("student".equals(userType)) {
                isValidLogin = validateLoginStudent(username, password);
            } else if ("faculty".equals(userType)) {
                isValidLogin = validateLoginFaculty(username, password);
            }

            if (isValidLogin) {
                // Redirect to the appropriate page based on user type
                // response.sendRedirect("AdminIndex.jsp");
                if ("admin".equals(userType)) {
                    response.sendRedirect("AdminIndex.jsp");
                } else if ("student".equals(userType)) {
                    request.getSession().setAttribute("rollno", username);
                    response.sendRedirect("StudentIndex.jsp");
                } else if ("faculty".equals(userType)) {
                    request.getSession().setAttribute("facultyId", username);
                    response.sendRedirect("FacultyIndex.jsp");
                }
            } else {
                // Set an error message and redirect back to the login page
                request.setAttribute("errorMessage", "Invalid username, password, or user type.");
                response.sendRedirect("AdminIndex.jsp");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
