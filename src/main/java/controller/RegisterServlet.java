package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.DBConnection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("corporateEmail");
		String designation = request.getParameter("designation");
		String employeeId = request.getParameter("employeeId");
		
		String password = request.getParameter("password");
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
		
		String confirmPassword = request.getParameter("confirmPassword");

		// Check passwords
		if (!password.equals(confirmPassword)) {
			request.setAttribute("error", "Passwords do not match.");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}

		String sql = "INSERT INTO employees " + "(first_name, last_name, email, designation, employee_id, password) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, firstName);
			ps.setString(2, lastName);
			ps.setString(3, email);
			ps.setString(4, designation);
			ps.setString(5, employeeId);
			ps.setString(6, hashedPassword);

			int result = ps.executeUpdate();

			if (result > 0) {
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			}

		} catch (Exception e) {

			e.printStackTrace();

			request.setAttribute("error", "Registration failed.");

			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
	}
}
