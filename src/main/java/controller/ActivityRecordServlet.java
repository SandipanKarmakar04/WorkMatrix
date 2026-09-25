package controller;

import java.io.IOException;
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
import model.ActivityRecord;

@WebServlet("/activityRecord")
public class ActivityRecordServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get existing session
		HttpSession session = request.getSession(false);

		// Employee must be logged in
		if (session == null || session.getAttribute("employeeId") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		// Get logged-in employee ID
		String employeeId = (String) session.getAttribute("employeeId");

		List<ActivityRecord> records = new ArrayList<>();

		String sql = "SELECT id, activity_date, slot_number, start_time, "
				+ "end_time, work_description, category, submitted_at " + "FROM activity_log "
				+ "WHERE employee_id = ? " + "AND activity_date = CURDATE() " + "ORDER BY slot_number";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, employeeId);

			try (ResultSet rs = ps.executeQuery()) {

				while (rs.next()) {

					ActivityRecord record = new ActivityRecord();

					record.setId(rs.getInt("id"));
					record.setActivityDate(rs.getDate("activity_date"));
					record.setSlotNumber(rs.getInt("slot_number"));
					record.setStartTime(rs.getTime("start_time"));
					record.setEndTime(rs.getTime("end_time"));
					record.setWorkDescription(rs.getString("work_description"));
					record.setCategory(rs.getString("category"));
					record.setSubmittedAt(rs.getTimestamp("submitted_at"));

					records.add(record);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();

			request.setAttribute("error", "Unable to load activity records.");
		}

		// Send records to JSP
		request.setAttribute("activityRecords", records);

		// Load Activity Record page
		request.getRequestDispatcher("/activityRecord.jsp").forward(request, response);
	}
}