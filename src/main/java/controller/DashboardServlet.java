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

//    @Override
//    protected void doGet(HttpServletRequest request,
//                          HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//
//        if (session == null ||
//            session.getAttribute("employeeId") == null) {
//
//            response.sendRedirect(
//                request.getContextPath() + "/login.jsp"
//            );
//            return;
//        }
//
//        request.getRequestDispatcher("/dashboard.jsp")
//               .forward(request, response);
//    }

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

		String sql = "SELECT check_in, check_out, total_hours, status " + "FROM attendance " + "WHERE employee_id = ? "
				+ "AND attendance_date = CURDATE()";

		try (Connection con = DBConnection.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

			stmt.setString(1, employeeId);

			try (ResultSet rs = stmt.executeQuery()) {

				if (rs.next()) {

					System.out.println("Employee ID: " + employeeId);
					System.out.println("Check In: " + rs.getTime("check_in"));
					System.out.println("Check Out: " + rs.getTime("check_out"));
					System.out.println("Total Hours: " + rs.getBigDecimal("total_hours"));

					// Put today's attendance in request
					request.setAttribute("checkIn", rs.getTime("check_in"));

					request.setAttribute("checkOut", rs.getTime("check_out"));

					request.setAttribute("totalHours", rs.getBigDecimal("total_hours"));

					request.setAttribute("attendanceStatus", rs.getString("status"));

				} else {

					// No attendance record today
					request.setAttribute("checkIn", null);
					request.setAttribute("checkOut", null);
					request.setAttribute("totalHours", null);
					request.setAttribute("attendanceStatus", null);
				}
			}

			request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load dashboard.");
		}
	}

}
