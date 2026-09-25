package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/submitActivity")
public class SubmitActivityServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get existing session
		HttpSession session = request.getSession(false);

		// Employee must be logged in
		if (session == null || session.getAttribute("employeeId") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		// Get employee ID from session
		String employeeId = (String) session.getAttribute("employeeId");

		// Get form values
		String slotNumber = request.getParameter("slotNumber");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String workDescription = request.getParameter("workDescription");
		String category = request.getParameter("category");

		String sql = "INSERT INTO activity_log " + "(employee_id, activity_date, slot_number, start_time, "
				+ "end_time, work_description, category, submitted_at) "
				+ "VALUES (?, CURDATE(), ?, ?, ?, ?, ?, NOW())";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, employeeId);
			ps.setInt(2, Integer.parseInt(slotNumber));
			ps.setString(3, startTime);
			ps.setString(4, endTime);
			ps.setString(5, workDescription);
			ps.setString(6, category);

			ps.executeUpdate();

			// After saving, reload Activity Record page
			response.sendRedirect(request.getContextPath() + "/activityRecord");

		} catch (Exception e) {

			e.printStackTrace();

			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to save activity record.");
		}
	}
}