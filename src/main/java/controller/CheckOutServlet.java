package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.DBConnection;

@WebServlet("/checkout")
public class CheckOutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check whether employee is logged in
        if (session == null ||
            session.getAttribute("employeeId") == null) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Please login first.");
            return;
        }

        // Get employee ID from session
        String employeeId =
                session.getAttribute("employeeId").toString();

        // Generate date and time on the server
        LocalDate today = LocalDate.now();
        LocalTime checkOutTime = LocalTime.now();

        String selectSql =
                "SELECT id, check_in " +
                "FROM attendance " +
                "WHERE employee_id = ? " +
                "AND attendance_date = ?";

        String updateSql =
                "UPDATE attendance " +
                "SET check_out = ?, total_hours = ? " +
                "WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement selectStmt =
                     con.prepareStatement(selectSql)) {

            selectStmt.setString(1, employeeId);
            selectStmt.setDate(
                    2,
                    java.sql.Date.valueOf(today)
            );

            try (ResultSet rs = selectStmt.executeQuery()) {

                // No attendance record
                if (!rs.next()) {

                    response.setStatus(
                            HttpServletResponse.SC_BAD_REQUEST
                    );

                    response.getWriter().write(
                            "Please check in first."
                    );

                    return;
                }

                int attendanceId = rs.getInt("id");

                java.sql.Time checkInSql =
                        rs.getTime("check_in");

                // Check-in value is missing
                if (checkInSql == null) {

                    response.setStatus(
                            HttpServletResponse.SC_BAD_REQUEST
                    );

                    response.getWriter().write(
                            "Check-in time not found."
                    );

                    return;
                }

                // Already checked out
                // We can check this separately later if needed.

                LocalTime checkInTime =
                        checkInSql.toLocalTime();

                // Calculate duration
                Duration duration =
                        Duration.between(
                                checkInTime,
                                checkOutTime
                        );

                double totalHours =
                        duration.toMinutes() / 60.0;

                try (PreparedStatement updateStmt =
                             con.prepareStatement(updateSql)) {

                    updateStmt.setTime(
                            1,
                            java.sql.Time.valueOf(checkOutTime)
                    );

                    updateStmt.setDouble(
                            2,
                            totalHours
                    );

                    updateStmt.setInt(
                            3,
                            attendanceId
                    );

                    updateStmt.executeUpdate();
                }

                response.setContentType("text/plain");
                response.getWriter().write(
                        checkOutTime.toString()
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                    "Unable to save check-out."
            );
        }
    }
}