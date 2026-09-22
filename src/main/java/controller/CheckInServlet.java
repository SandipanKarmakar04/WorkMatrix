package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalTime;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkin")
public class CheckInServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing login session
        HttpSession session = request.getSession(false);

        // Employee is not logged in
        if (session == null ||
            session.getAttribute("employeeId") == null) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Please login first.");
            return;
        }

        // Get logged-in employee
        String employeeId =
                session.getAttribute("employeeId").toString();

        // Current date and time
        LocalDate today = LocalDate.now();
        LocalTime currentTime = LocalTime.now();

        String checkExistingSql =
                "SELECT id FROM attendance " +
                "WHERE employee_id = ? AND attendance_date = ?";

        String insertSql =
                "INSERT INTO attendance " +
                "(employee_id, attendance_date, check_in, status) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkStmt =
                     con.prepareStatement(checkExistingSql)) {

            // Check whether employee already checked in today
            checkStmt.setString(1, employeeId);
            checkStmt.setDate(
                    2,
                    java.sql.Date.valueOf(today)
            );

            try (ResultSet rs = checkStmt.executeQuery()) {

                if (rs.next()) {

                    response.setStatus(
                            HttpServletResponse.SC_CONFLICT
                    );

                    response.getWriter().write(
                            "You have already checked in today."
                    );

                    return;
                }
            }

            // Insert today's check-in
            try (PreparedStatement insertStmt =
                         con.prepareStatement(insertSql)) {

                insertStmt.setString(1, employeeId);

                insertStmt.setDate(
                        2,
                        java.sql.Date.valueOf(today)
                );

                insertStmt.setTime(
                        3,
                        java.sql.Time.valueOf(currentTime)
                );

                insertStmt.setString(4, "PRESENT");

                insertStmt.executeUpdate();
            }

            // Send check-in time back to JavaScript
            response.setContentType("text/plain");
            response.getWriter().write(
                    currentTime.toString()
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                    "Unable to save check-in."
            );
        }
    }
}
