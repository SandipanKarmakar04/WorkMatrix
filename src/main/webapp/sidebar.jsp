<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String uri = request.getRequestURI();
String contextPath = request.getContextPath();

String currentPage = uri.substring(contextPath.length());

// Remove .jsp if the request reaches the JSP directly
if (currentPage.endsWith(".jsp")) {
	currentPage = currentPage.substring(0, currentPage.length() - 4);
}

// Make sure it starts with /
if (!currentPage.startsWith("/")) {
	currentPage = "/" + currentPage;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sidebar</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/sidebar.css">
</head>

<body>

	<aside class="app-sidebar">

		<div class="py-3">

			<div class="sidebar-section-title">Employee Portal</div>

			<nav class="sidebar-nav d-flex flex-column gap-1">

				<!-- Dashboard -->
				<a href="${pageContext.request.contextPath}/dashboard"
					class="nav-link <%= currentPage.equals("/dashboard") ? "active" : "" %>">

					<span class="material-symbols-outlined fs-20"> dashboard </span> <span>Dashboard</span>
				</a>


				<!-- Weekly Timesheet -->
				<a href="${pageContext.request.contextPath}/weeklyTimeSheet"
					class="nav-link <%= currentPage.equals("/weeklyTimeSheet") ? "active" : "" %>">

					<span class="material-symbols-outlined fs-20">
						calendar_view_week </span> <span>Weekly Timesheet</span>
				</a>


				<!-- Activity Record -->
				<a href="${pageContext.request.contextPath}/activityRecord"
					class="nav-link <%= currentPage.equals("/activityRecord") ? "active" : "" %>">

					<span class="material-symbols-outlined fs-20"> vital_signs </span>

					<span>Activity Record</span>
				</a>


				<!-- Work History -->
				<a href="${pageContext.request.contextPath}/workHistory"
					class="nav-link <%= currentPage.equals("/workHistory") ? "active" : "" %>">

					<span class="material-symbols-outlined fs-20"> history </span> <span>Work
						History</span>
				</a>

			</nav>

		</div>


		<!-- Sidebar Footer -->
		<div class="sidebar-footer">

			<span> System v2.4.1 </span> <span class="sync-ok"> <span
				class="dot dot-secondary"></span> Sync OK

			</span>

		</div>

	</aside>

</body>
</html>