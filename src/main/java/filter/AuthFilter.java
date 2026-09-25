package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = "/*")
public class AuthFilter implements Filter {

	public AuthFilter() {
		System.out.println("===== AUTH FILTER CREATED =====");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		String contextPath = req.getContextPath();
		String requestURI = req.getRequestURI();

		String path = requestURI.substring(contextPath.length());

		System.out.println("AUTH FILTER -> " + path);

		// =========================================================
		// PREVENT BROWSER CACHING
		// =========================================================

		resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		resp.setHeader("Pragma", "no-cache");
		resp.setDateHeader("Expires", 0);

		// =========================================================
		// PUBLIC RESOURCES
		// =========================================================

		boolean isPublic =
				// Login
				path.equals("/login") || path.equals("/login.jsp")

				// Registration
						|| path.equals("/register") || path.equals("/register.jsp")

						// Forgot password
						|| path.equals("/forgot-password.jsp")

						// Static resources
						|| path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/")
						|| path.startsWith("/assets/");

		if (isPublic) {

			chain.doFilter(request, response);
			return;
		}

		// =========================================================
		// CHECK LOGIN SESSION
		// =========================================================

		HttpSession session = req.getSession(false);

		boolean loggedIn = session != null && session.getAttribute("employeeId") != null;

		// =========================================================
		// NOT LOGGED IN
		// =========================================================

		if (!loggedIn) {

			System.out.println("AUTH FILTER -> BLOCKED: " + path);

			resp.sendRedirect(contextPath + "/login.jsp");

			return;
		}

		// =========================================================
		// LOGGED IN
		// =========================================================

		System.out.println("AUTH FILTER -> ALLOWED: " + path);

		chain.doFilter(request, response);
	}
}