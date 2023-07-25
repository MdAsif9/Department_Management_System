/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author asifk
 */
public class SubmitAttendence extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String DB_URL = "jdbc:mysql://localhost:3306/dms";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "Asif@1199";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SubmitAttendence</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubmitAttendence at " + request.getContextPath() + "</h1>");
            String facultyId = "FT1"; // Replace with actual faculty ID
            String semesterId = "BT1"; // Replace with actual semester ID
            String subjectId = request.getParameter("subject");
            String attendanceDate = request.getParameter("attendanceDate");
            String[] presentStudents = request.getParameterValues("attendance[]");
            out.println("<h1>"+subjectId+attendanceDate+"</h1>");

            if (subjectId != null && attendanceDate != null && presentStudents != null) {
                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

                    String insertAttendanceQuery
                            = "INSERT INTO Attendance (facultyId, rollno, semesterId, subjectId, attendanceDate, status) VALUES (?, ?, ?, ?, ?, ?)";

                    stmt = conn.prepareStatement(insertAttendanceQuery);

                    for (String studentId : presentStudents) {
                        stmt.setString(1, facultyId);
                        stmt.setString(2, studentId);
                        stmt.setString(3, semesterId);
                        stmt.setString(4, subjectId);
                        stmt.setString(5, attendanceDate);
                        stmt.setString(6, "Absent"); // Set the status as desired ("Present" or "Absent")

                        stmt.executeUpdate();
                    }
                    request.getSession().setAttribute("r", 1);
                    response.sendRedirect("FacultyAttendence.jsp");
                    response.getWriter().println("<h1>Attendance Successfully Submitted!</h1>");
                } catch (ClassNotFoundException e) {
                    response.getWriter().println("<h1>Error occurred while submitting attendance.</h1>");
                    e.printStackTrace();
                } finally {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
            } else {
                response.getWriter().println("<h1>Invalid attendance data.</h1>");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SubmitAttendence.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SubmitAttendence.class.getName()).log(Level.SEVERE, null, ex);
        }
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
