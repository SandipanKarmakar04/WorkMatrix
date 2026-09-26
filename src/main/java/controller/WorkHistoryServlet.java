package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ActivityRecord;

@WebServlet("/workHistory")
public class WorkHistoryServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// Fixed number of work days per page
	private static final int PAGE_SIZE = 2;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/*
		 * ============================ CHECK LOGIN ============================
		 */

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("employeeId") == null) {

			response.sendRedirect(request.getContextPath() + "/login");

			return;
		}

		String employeeId = session.getAttribute("employeeId").toString();

		/*
		 * ============================ GET CURRENT PAGE ============================
		 */

		int currentPage = 1;

		String pageParam = request.getParameter("page");

		if (pageParam != null) {

			try {

				currentPage = Integer.parseInt(pageParam);

			} catch (NumberFormatException e) {

				currentPage = 1;
			}
		}

		// Never allow page 0 or negative page
		if (currentPage < 1) {
			currentPage = 1;
		}

		/*
		 * ============================ FETCH ALL ACTIVITY RECORDS
		 * ============================
		 */

		List<ActivityRecord> records = new ArrayList<>();

		String sql = "SELECT id, activity_date, slot_number, " + "start_time, end_time, work_description, "
				+ "category, submitted_at " + "FROM activity_log " + "WHERE employee_id = ? "
				+ "ORDER BY activity_date DESC, slot_number ASC";

		try (Connection con = DBConnection.getConnection();

				PreparedStatement ps = con.prepareStatement(sql)) {

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

			/*
			 * ============================ GROUP RECORDS BY DATE
			 * ============================
			 */

			Map<java.sql.Date, List<ActivityRecord>> allGroupedRecords = new LinkedHashMap<>();

			for (ActivityRecord record : records) {

				allGroupedRecords.computeIfAbsent(record.getActivityDate(), k -> new ArrayList<>()).add(record);
			}

			/*
			 * ============================ TOTAL WORK DAYS ============================
			 */

			int totalRecords = allGroupedRecords.size();

			/*
			 * ============================ TOTAL NUMBER OF PAGES
			 * ============================
			 */

			int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

			/*
			 * If there are no records, keep page as 1.
			 */

			if (totalPages == 0) {
				totalPages = 1;
			}

			/*
			 * If user enters a page number greater than available pages, move them to the
			 * last page.
			 */

			if (currentPage > totalPages) {

				currentPage = totalPages;
			}

			/*
			 * ============================ FIND DATE RANGE FOR PAGE
			 * ============================
			 */

			int startIndex = (currentPage - 1) * PAGE_SIZE;

			int endIndex = Math.min(startIndex + PAGE_SIZE, totalRecords);

			/*
			 * ============================ CREATE PAGINATED GROUP
			 * ============================
			 */

			Map<java.sql.Date, List<ActivityRecord>> groupedRecords = new LinkedHashMap<>();

			int index = 0;

			for (Map.Entry<java.sql.Date, List<ActivityRecord>> entry : allGroupedRecords.entrySet()) {

				if (index >= startIndex && index < endIndex) {

					groupedRecords.put(entry.getKey(), entry.getValue());
				}

				index++;

				if (index >= endIndex) {
					break;
				}
			}

			/*
			 * ============================ SUMMARY INFORMATION ============================
			 */

			long totalWorkDays = allGroupedRecords.size();

			int totalSlots = records.size();

			int completedSlots = records.size();

			/*
			 * ============================ SEND DATA TO JSP ============================
			 */

			request.setAttribute("workHistoryRecords", records);

			request.setAttribute("groupedRecords", groupedRecords);

			request.setAttribute("totalWorkDays", totalWorkDays);

			request.setAttribute("totalSlots", totalSlots);

			request.setAttribute("completedSlots", completedSlots);

			/*
			 * Pagination attributes
			 */

			request.setAttribute("currentPage", currentPage);

			request.setAttribute("pageSize", PAGE_SIZE);

			request.setAttribute("totalPages", totalPages);

			request.setAttribute("totalRecords", totalRecords);

			/*
			 * ============================ FORWARD TO JSP ============================
			 */

			request.getRequestDispatcher("/workHistory.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			request.setAttribute("error", "Unable to load work history.");

			request.setAttribute("workHistoryRecords", records);

			/*
			 * Give JSP safe pagination values even when database loading fails.
			 */

			request.setAttribute("groupedRecords", new LinkedHashMap<java.sql.Date, List<ActivityRecord>>());

			request.setAttribute("totalWorkDays", 0L);

			request.setAttribute("totalSlots", 0);

			request.setAttribute("completedSlots", 0);

			request.setAttribute("currentPage", 1);

			request.setAttribute("pageSize", PAGE_SIZE);

			request.setAttribute("totalPages", 1);

			request.setAttribute("totalRecords", 0);

			request.getRequestDispatcher("/workHistory.jsp").forward(request, response);
		}
	}
}