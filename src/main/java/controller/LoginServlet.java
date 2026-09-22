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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String employeeId = request.getParameter("employeeId");
		String password = request.getParameter("password");

		String sql = "SELECT first_name, last_name, designation, employee_id " + "FROM employees "
				+ "WHERE employee_id = ? AND password = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, employeeId);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				// Create session
				HttpSession session = request.getSession();

				// Prevent session fixation
				request.changeSessionId();

				// Store authenticated employee information
				session.setAttribute("employeeId", rs.getString("employee_id"));

				session.setAttribute("firstName", rs.getString("first_name"));

				session.setAttribute("lastName", rs.getString("last_name"));

				session.setAttribute("employeeName", rs.getString("first_name") + " " + rs.getString("last_name"));

				session.setAttribute("designation", rs.getString("designation"));

				// Go through DashboardServlet
				response.sendRedirect(request.getContextPath() + "/dashboard");

			} else {

				request.setAttribute("error", "Invalid Employee ID or Password.");

				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}

		} catch (Exception e) {

			e.printStackTrace();

			request.setAttribute("error", "Unable to process login.");

			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}
}