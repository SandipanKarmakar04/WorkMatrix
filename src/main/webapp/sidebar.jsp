<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String uri = request.getRequestURI();
String contextPath = request.getContextPath();

String currentPage = uri.substring(contextPath.length());
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

				<a
					class="nav-link <%= currentPage.equals("/dashboard.jsp") ? "active" : "" %>"
					href="${pageContext.request.contextPath}/dashboard.jsp"> <span
					class="material-symbols-outlined fs-20"> dashboard </span> <span>
						Dashboard </span>

				</a>


				<!-- Weekly Timesheet -->

				<a
					class="nav-link <%= currentPage.equals("/weeklyTimeSheet.jsp") ? "active" : "" %>"
					href="${pageContext.request.contextPath}/weeklyTimeSheet.jsp"> <span
					class="material-symbols-outlined fs-20"> calendar_view_week
				</span> <span> Weekly Timesheet </span>

				</a>


				<!-- Activity Record -->

				<a
					class="nav-link <%= currentPage.equals("/activityRecord.jsp") ? "active" : "" %>"
					href="${pageContext.request.contextPath}/activityRecord.jsp"> <span
					class="material-symbols-outlined fs-20"> vital_signs </span> <span>
						Activity Record </span>

				</a>


				<!-- Work History -->

				<a
					class="nav-link <%= currentPage.equals("/workHistory.jsp") ? "active" : "" %>"
					href="${pageContext.request.contextPath}/workHistory.jsp"> <span
					class="material-symbols-outlined fs-20"> history </span> <span>
						Work History </span>

				</a>


			</nav>

		</div>


		<div class="sidebar-footer">

			<span> System v2.4.1 </span> <span class="sync-ok"> <span
				class="dot dot-secondary"></span> Sync OK

			</span>

		</div>

	</aside>

</body>
</html>