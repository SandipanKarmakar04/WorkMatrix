package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Employee must be logged in
		if (session == null || session.getAttribute("employeeId") == null) {

			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String employeeId = session.getAttribute("employeeId").toString();

		try (Connection con = DBConnection.getConnection()) {

			// ==========================================
			// 1. LOAD TODAY'S ATTENDANCE
			// ==========================================

			String attendanceSql = "SELECT check_in, check_out, total_hours, status " + "FROM attendance "
					+ "WHERE employee_id = ? " + "AND attendance_date = CURDATE()";

			try (PreparedStatement stmt = con.prepareStatement(attendanceSql)) {

				stmt.setString(1, employeeId);

				try (ResultSet rs = stmt.executeQuery()) {

					if (rs.next()) {

						request.setAttribute("checkIn", rs.getTime("check_in"));

						request.setAttribute("checkOut", rs.getTime("check_out"));

						request.setAttribute("totalHours", rs.getBigDecimal("total_hours"));

						request.setAttribute("attendanceStatus", rs.getString("status"));

					} else {

						request.setAttribute("checkIn", null);
						request.setAttribute("checkOut", null);
						request.setAttribute("totalHours", null);
						request.setAttribute("attendanceStatus", null);
					}
				}
			}

			// ==========================================
			// 2. LOAD TODAY'S WORK DESCRIPTION
			// ==========================================

			String workSql = "SELECT work_description, updated_at " + "FROM daily_work " + "WHERE employee_id = ? "
					+ "AND work_date = CURDATE()";

			try (PreparedStatement workStmt = con.prepareStatement(workSql)) {

				workStmt.setString(1, employeeId);

				try (ResultSet workRs = workStmt.executeQuery()) {

					if (workRs.next()) {

					    request.setAttribute(
					            "workDescription",
					            workRs.getString("work_description"));

					    request.setAttribute(
					            "workUpdatedAt",
					            workRs.getTimestamp("updated_at"));

					} else {

					    request.setAttribute("workDescription", null);
					    request.setAttribute("workUpdatedAt", null);
					}
				}
			}

			// ==========================================
			// 3. OPEN DASHBOARD
			// ==========================================

			request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load dashboard.");
		}
	}
}