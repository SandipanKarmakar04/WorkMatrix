package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AttendanceRecord;

@WebServlet("/weeklyTimeSheet")
public class WeeklyTimeSheet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Check login
		if (session == null || session.getAttribute("employeeId") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String employeeId = session.getAttribute("employeeId").toString();
		System.out.println("Employee ID from session: " + employeeId);

		List<AttendanceRecord> records = new ArrayList<>();

		String sql = "SELECT a.attendance_date, " + "a.check_in, " + "a.check_out, " + "a.total_hours, " + "a.status, "
				+ "d.work_description " + "FROM attendance a " + "LEFT JOIN daily_work d "
				+ "ON a.employee_id = d.employee_id " + "AND a.attendance_date = d.work_date "
				+ "WHERE a.employee_id = ? " + "ORDER BY a.attendance_date DESC";

		BigDecimal weeklyTotal = BigDecimal.ZERO;
		
		try (Connection con = DBConnection.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

			stmt.setString(1, employeeId);

			try (ResultSet rs = stmt.executeQuery()) {

				while (rs.next()) {

				    AttendanceRecord record = new AttendanceRecord();

				    record.setAttendanceDate(rs.getDate("attendance_date"));
				    record.setCheckIn(rs.getTime("check_in"));
				    record.setCheckOut(rs.getTime("check_out"));

				    BigDecimal totalHours = rs.getBigDecimal("total_hours");
				    record.setTotalHours(totalHours);

				    record.setStatus(rs.getString("status"));
				    record.setWorkDescription(rs.getString("work_description"));

				    records.add(record);

				    // Calculate weekly total
				    if (totalHours != null) {
				        weeklyTotal = weeklyTotal.add(totalHours);
				    }
				}
				
			}

			request.setAttribute("attendanceRecords", records);
			request.setAttribute("weeklyTotal", weeklyTotal);
			
			int weeklyHours = weeklyTotal.intValue();

			int weeklyMinutes = weeklyTotal
			        .subtract(BigDecimal.valueOf(weeklyHours))
			        .multiply(BigDecimal.valueOf(60))
			        .intValue();

			String formattedWeeklyTotal =
			        weeklyHours + "h " + weeklyMinutes + "m";

			request.setAttribute("weeklyTotal", formattedWeeklyTotal);
			
			request.getRequestDispatcher("/weeklyTimeSheet.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load timesheet.");
		}
	}
}