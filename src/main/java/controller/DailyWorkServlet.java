package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dailyWork")
public class DailyWorkServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    response.getWriter().println("DailyWorkServlet is working!");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Check whether user is logged in
		if (session == null || session.getAttribute("employeeId") == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			return;
		}

		String employeeId = (String) session.getAttribute("employeeId");
		String workDescription = request.getParameter("workDescription");

		// Validate description
		if (workDescription == null || workDescription.trim().isEmpty()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		String checkSql = """
				SELECT id
				FROM daily_work
				WHERE employee_id = ?
				AND work_date = ?
				""";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement checkStatement = connection.prepareStatement(checkSql)) {

			checkStatement.setString(1, employeeId);
			checkStatement.setDate(2, java.sql.Date.valueOf(LocalDate.now()));

			try (ResultSet resultSet = checkStatement.executeQuery()) {

				if (resultSet.next()) {

					// Record already exists → UPDATE
					String updateSql = """
							UPDATE daily_work
							SET work_description = ?
							WHERE employee_id = ?
							AND work_date = ?
							""";

					try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {

						updateStatement.setString(1, workDescription.trim());
						updateStatement.setString(2, employeeId);
						updateStatement.setDate(3, java.sql.Date.valueOf(LocalDate.now()));

						updateStatement.executeUpdate();
					}

				} else {

					// No record exists → INSERT
					String insertSql = """
							INSERT INTO daily_work
							(employee_id, work_date, work_description)
							VALUES (?, ?, ?)
							""";

					try (PreparedStatement insertStatement = connection.prepareStatement(insertSql)) {

						insertStatement.setString(1, employeeId);
						insertStatement.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
						insertStatement.setString(3, workDescription.trim());

						insertStatement.executeUpdate();
					}
				}
			}

			response.setStatus(HttpServletResponse.SC_OK);

		} catch (SQLException e) {

			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}