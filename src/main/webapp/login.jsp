<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>WorkMatrix | Employee Timesheet Login</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/login.css">

<!-- Google Fonts + Material Symbols -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&display=swap"
	rel="stylesheet">

</head>

<body>

	<div class="d-flex flex-column align-items-center w-100">

		<!-- Top System Context / Audit Badge -->
		<div class="audit-badge mb-4">
			<span class="audit-dot"></span> <span>PCS GLOBAL PVT. LTD.</span> <span
				class="audit-sep">&bull;</span> <span class="audit-muted">TIMESHEET
				PORTAL</span>
		</div>

		<!-- Login Authentication Card -->
		<div class="login-card">

			<!-- Brand & Header -->
			<div class="d-flex flex-column align-items-center text-center">
				<div class="mb-3">
					<h1 class="headline" style="color: rgb(0, 0, 65);">
						W<span style="color: rgb(0, 201, 154);">o</span>rk<span
							style="color: rgb(0, 201, 154);">Matrix</span>
					</h1>
				</div>
				<p class="subtext">Sign in to record your daily attendance and
					weekly timesheet</p>
			</div>

			<%
			// ================================================================
			// Server-side error handling: the login servlet redirects back
			// here with ?error=1 (and optionally &msg=...) on a failed
			// attempt. Swap the parameter name/value to match your servlet.
			// ================================================================
			String loginError = request.getParameter("error");
			String errorMessage = request.getParameter("msg");
			boolean hasError = "1".equals(loginError) || "true".equalsIgnoreCase(loginError);
			String displayMessage = (errorMessage != null && !errorMessage.trim().isEmpty()) ? errorMessage
					: "Invalid Employee ID or password. Please try again.";
			%>

			<!-- Error message (rendered when the servlet reports a failed login) -->
			<div class="alert-custom mt-4 <%=hasError ? "show" : ""%>"
				id="errorAlert" role="alert">
				<span class="material-symbols-outlined">error</span> <span
					id="errorText"><%=displayMessage%></span>
			</div>

			<!-- Authentication Form -->
			<form class="mt-4" id="loginForm" method="post"
				action="${pageContext.request.contextPath}/login" autocomplete="off">

				<!-- Field: Employee ID -->
				<div class="mb-3">
					<label class="form-label-custom d-block" for="employeeId">Employee ID</label>
					<div class="input-group-custom">
						<span class="material-symbols-outlined input-icon">badge</span> <input
							type="text" id="employeeId" name="employeeId" required
							class="form-control-custom" placeholder=" Employee ID">
					</div>
				</div>

				<!-- Field: Password -->
				<div class="mb-2">
					<div class="d-flex align-items-center justify-content-between mb-1">
						<label class="form-label-custom mb-0" for="password">Password</label>
						<a class="forgot-link"
							href="${pageContext.request.contextPath}/forgot-password.jsp">Forgot
							password?</a>
					</div>
					<div class="input-group-custom">
						<span class="material-symbols-outlined input-icon">lock</span> <input
							type="password" id="password" name="password" required
							class="form-control-custom pwd"
							placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
						<button type="button" class="pwd-toggle-btn"
							id="passwordToggleBtn" aria-label="Toggle password visibility">
							<span class="material-symbols-outlined" id="pwdToggleIcon">visibility</span>
						</button>
					</div>
				</div>

				<!-- Remember Me Checkbox -->
				<div class="d-flex align-items-center pt-1 pb-1">
					<label class="remember-label"> <input type="checkbox"
						id="remember" name="remember"> <span>Remember me on
							this workstation</span>
					</label>
				</div>

				<!-- Primary Submit Button -->
				<div class="pt-2">
					<button type="submit" class="btn-signin">
						<span>Sign In to Portal</span> <span
							class="material-symbols-outlined">arrow_forward</span>
					</button>
				</div>
			</form>

			<!-- Sign Up link for new employees -->
			<div class="signup-row mt-3"
				style="font-size: small; text-decoration: none;">
				<span>New candidate?</span> <a style="text-decoration: none;"
					href="${pageContext.request.contextPath}/register.jsp">Create
					an account</a>
			</div>

		</div>

		<!-- Security & Environment Footer -->
		<div class="footer-block">
			<div class="footer-line">
				<span class="material-symbols-outlined">verified_user</span> <span>Protected
					by PCS Global Enterprise Security v2.4</span>
			</div>
			<p class="footer-sub">JSP-Servlet-MySQL Architecture Compatible
				&bull; TLS 1.3 Encrypted</p>
		</div>

	</div>

</body>

</html>