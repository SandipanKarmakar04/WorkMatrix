<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.Time"%>
<%@ page import="java.math.BigDecimal"%>

<%
HttpSession currentSession = request.getSession(false);

if (currentSession == null || currentSession.getAttribute("employeeId") == null) {

	response.sendRedirect(request.getContextPath() + "/login");
	return;
}

Time checkIn = (Time) request.getAttribute("checkIn");
Time checkOut = (Time) request.getAttribute("checkOut");
BigDecimal totalHours = (BigDecimal) request.getAttribute("totalHours");
%>

<%
java.sql.Timestamp workUpdatedAt = (java.sql.Timestamp) request.getAttribute("workUpdatedAt");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>

	<jsp:include page="/navbar.jsp" />
	<jsp:include page="/sidebar.jsp" />

	<main class="app-main">

		<!-- Greeting header -->
		<div
			class="card-surface p-4 mb-4 d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
			<div class="d-flex align-items-center gap-3">
				<div class="position-relative">

					<%
					String employeeName = (String) session.getAttribute("employeeName");
					String initials = "";
					String avatarColor = "#5E35B1"; // default color

					if (employeeName != null && !employeeName.trim().isEmpty()) {

						String[] nameParts = employeeName.trim().split("\\s+");

						if (nameParts.length == 1) {
							initials = nameParts[0].substring(0, 1).toUpperCase();
						} else {
							initials = (nameParts[0].substring(0, 1) + nameParts[nameParts.length - 1].substring(0, 1)).toUpperCase();
						}

						// Generate a consistent color based on employee name
						String[] avatarColors = {"#E53935", // Red
						"#D81B60", // Pink
						"#8E24AA", // Purple
						"#5E35B1", // Deep Purple
						"#3949AB", // Indigo
						"#1E88E5", // Blue
						"#039BE5", // Light Blue
						"#00897B", // Teal
						"#43A047", // Green
						"#7CB342", // Light Green
						"#F4511E", // Orange
						"#6D4C41" // Brown
						};

						int colorIndex = Math.abs(employeeName.hashCode()) % avatarColors.length;
						avatarColor = avatarColors[colorIndex];
					}
					%>

					<span class="profile-avatar"
						style="background-color: <%=avatarColor%>;"> <%=initials%>
					</span>
				</div>
				<div>
					<div class="d-flex align-items-center gap-2 flex-wrap">
						<h1 class="h4 fw-semibold mb-0" id="greetName">${sessionScope.employeeName}</h1>
						<span class="badge-emp" id="dashId">EMP-${sessionScope.employeeId}</span>
					</div>
					<div class="d-flex align-items-center gap-2 mt-1 flex-wrap"
						style="color: var(--on-surface-variant);">
						<span class="fw-semibold" style="color: var(--primary);">
							${sessionScope.designation} </span> <span class="fw-bold"
							style="color: var(--outline-variant);">•</span> <span
							class="d-flex align-items-center gap-1" style="font-size: 13px;">
							<span class="material-symbols-outlined"
							style="font-size: 16px; color: var(--outline);">schedule</span>
							Standard Shift (10:00 AM - 06:00 PM)
						</span>
					</div>
				</div>
			</div>

			<div class="d-flex flex-wrap align-items-center gap-2">
				<div class="d-flex align-items-center gap-2 px-3 py-2 rounded-3"
					style="background: var(--surface-container-low);">
					<span class="material-symbols-outlined fs-20"
						style="color: var(--secondary);">calendar_today</span> <span
						class="fw-semibold" id="localDateTime"></span>
				</div>




			</div>
		</div>

		<!-- Main layout grid -->
		<div class="row g-4">

			<!-- Left column -->
			<div class="col-12 col-xl-7 d-flex flex-column gap-4">

				<!-- Today's Attendance -->
				<div class="card-surface p-4">
					<div
						class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3 pb-3 mb-4"
						style="border-bottom: 1px solid var(--surface-container);">
						<div class="d-flex align-items-center gap-3">
							<span class="section-icon-box"><span
								class="material-symbols-outlined fs-22">timer</span></span>
							<div>
								<h2 class="h6 mb-0">Today's Attendance</h2>
								<p class="mb-0"
									style="color: var(--on-surface-variant); font-size: 12px;">Biometric
									punch record &amp; real-time session tracking</p>
							</div>
						</div>
						<div class="d-flex align-items-center gap-2">
							<span class="status-working"><span class="pulse-dot"></span>Currently
								Working</span> <span class="status-present">Present</span>
						</div>
					</div>

					<!-- KPI grid -->
					<div class="row row-cols-2 row-cols-sm-4 g-3 mb-4">
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm">Check In</span>
								<div class="d-flex align-items-center gap-2">
									<span class="material-symbols-outlined fs-18"
										style="color: #059669;">check_circle</span> <span
										class="kpi-big"> <%
 if (checkIn != null) {
 	out.print(new java.text.SimpleDateFormat("hh:mm a").format(checkIn));
 } else {
 	out.print("--");
 }
 %>
									</span>
								</div>
								<span class="d-flex align-items-center gap-1 mt-1"
									style="color: #047857; font-size: 12px;"> <span
									class="material-symbols-outlined" style="font-size: 14px;">done_all</span>
									Verified Biometric
								</span>
							</div>
						</div>
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm">Check Out</span>
								<div class="d-flex align-items-center gap-2">
									<span class="material-symbols-outlined fs-18"
										style="color: var(--outline);">radio_button_unchecked</span> <span
										class="kpi-big" id="checkout-display"> <%
 if (checkOut != null) {
 	out.print(new java.text.SimpleDateFormat("hh:mm a").format(checkOut));
 } else {
 	out.print("--");
 }
 %>
									</span>
								</div>
								<span class="mt-1"
									style="color: var(--on-surface-variant); font-size: 12px;">Expected
									punch</span>
							</div>
						</div>
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm">Total Duration</span>
								<div class="d-flex align-items-center gap-2">
									<span class="material-symbols-outlined fs-18"
										style="color: var(--secondary);">timelapse</span> <span
										class="kpi-big" id="live-timer"> <%
 if (totalHours != null) {

 	double hours = totalHours.doubleValue();

 	int wholeHours = (int) hours;

 	int minutes = (int) Math.round((hours - wholeHours) * 60);

 	if (minutes == 60) {
 		wholeHours++;
 		minutes = 0;
 	}

 	out.print(wholeHours + "h " + minutes + "m");

 } else {
 	out.print("--");
 }
 %>
									</span>
								</div>
								<span class="mt-1 fw-medium"
									style="color: var(--secondary); font-size: 12px;">+43m
									over target</span>
							</div>
						</div>
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm">Daily Target</span>
								<div class="d-flex align-items-center gap-2">
									<span class="material-symbols-outlined fs-18"
										style="color: var(--on-surface-variant);">flag</span> <span
										class="kpi-big">5h 00m</span>
								</div>
								<span class="mt-1"
									style="color: var(--on-surface-variant); font-size: 12px;">Quota
									met (108%)</span>
							</div>
						</div>
					</div>

					<!-- Action panel -->
					<div class="action-panel d-flex flex-column gap-3">
						<div class="d-flex flex-column flex-sm-row gap-3">
							<button
								class="btn btn-checkin flex-grow-1 d-inline-flex align-items-center justify-content-center gap-2"
								id="checkin-btn" type="button" onclick="handleCheckIn()"
								<%=checkIn != null ? "disabled" : ""%>>

								<span class="material-symbols-outlined fs-20">login</span> <span
									id="checkin-text"> <%=checkIn != null ? "Checked In" : "Punch Check In"%>
								</span>
							</button>
							<button
								class="btn btn-checkout flex-grow-1 d-inline-flex align-items-center justify-content-center gap-2"
								id="checkout-btn" type="button" onclick="handleCheckOut()"
								<%=checkOut != null ? "disabled" : ""%>>

								<span class="material-symbols-outlined fs-20">logout</span> <span>
									<%=checkOut != null ? "Checked Out" : "Punch Check Out"%>
								</span>

							</button>
						</div>
						<div
							class="d-flex flex-wrap align-items-center justify-content-between gap-2 pt-2"
							style="border-top: 1px solid rgba(117, 118, 130, .2); color: var(--on-surface-variant);">
							<div class="d-flex align-items-center gap-1"
								style="font-size: 12px;">
								<span class="material-symbols-outlined"
									style="font-size: 16px; color: var(--secondary);">info</span> <span>Operational
									Lifecycle States:</span>
							</div>
							<div class="d-flex align-items-center gap-2"
								style="font-size: 12px;">
								<span class="lifecycle-chip">1. Before Check-In</span> <span
									class="material-symbols-outlined"
									style="font-size: 14px; color: var(--outline);">arrow_forward</span>
								<span class="lifecycle-chip current">2. Checked In
									(Active)</span> <span class="material-symbols-outlined"
									style="font-size: 14px; color: var(--outline);">arrow_forward</span>
								<span class="lifecycle-chip">3. Checked Out</span>
							</div>
						</div>
					</div>

					<!-- Shift timeline -->
					<div class="mt-4 pt-3"
						style="border-top: 1px solid var(--surface-container);">
						<div class="d-flex justify-content-between mb-2"
							style="color: var(--on-surface-variant); font-size: 12px;">
							<span>09:00 AM (Start)</span> <span class="fw-semibold"
								style="color: var(--primary);">1:00 PM - 2:00 PM (1h
								Break Recorded)</span> <span>06:00 PM (End)</span>
						</div>
						<div class="shift-bar">
							<div style="width: 44.4%; background: var(--primary);"
								title="Morning Work Session (3.5h)"></div>
							<div style="width: 11.1%; background: var(--surface-dim);"
								title="Lunch Break (1.0h)"></div>
							<div
								style="width: 44.5%; background: var(--secondary-container);"
								title="Afternoon Work Session (4.2h)"></div>
						</div>
						<div class="d-flex flex-wrap gap-3 mt-2"
							style="color: var(--on-surface-variant); font-size: 13px;">
							<div class="d-flex align-items-center gap-1">
								<span class="legend-dot" style="background: var(--primary);"></span>Core
								Hours
							</div>
							<div class="d-flex align-items-center gap-1">
								<span class="legend-dot" style="background: var(--surface-dim);"></span>Lunch
								Break
							</div>
							<div class="d-flex align-items-center gap-1">
								<span class="legend-dot"
									style="background: var(--secondary-container);"></span>Afternoon
								/ Overtime
							</div>
						</div>
					</div>
				</div>

				<!-- Today's Work Summary -->
				<div class="card-surface p-4"></div>
			</div>

			<!-- Right column -->
			<div class="col-12 col-xl-5 d-flex flex-column gap-4">

				<!-- Weekly Summary -->
				<div class="card-surface p-4">
					<div
						class="d-flex align-items-center justify-content-between pb-3 mb-3"
						style="border-bottom: 1px solid var(--surface-container);">
						<div class="d-flex align-items-center gap-2">
							<span class="material-symbols-outlined fs-22"
								style="color: var(--primary);">bar_chart</span>
							<h2 class="h6 mb-0">Weekly Summary (Week 38)</h2>
						</div>
						<span class="fw-semibold"
							style="background: #d1fae5; color: #047857; font-size: 12px; padding: 2px 10px; border-radius: 999px;">100%
							Adherence</span>
					</div>

					<div class="row row-cols-2 g-3 mb-4">
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm"
									style="text-transform: none; letter-spacing: 0;">Working
									Days</span>
								<div class="d-flex align-items-baseline gap-1">
									<span class="fw-bold" style="font-size: 22px;">5</span> <span
										style="color: var(--on-surface-variant); font-size: 12px;">/
										5 Days</span>
								</div>
								<span class="fw-medium" style="color: #047857; font-size: 11px;">Standard
									Schedule</span>
							</div>
						</div>
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm"
									style="text-transform: none; letter-spacing: 0;">Present
									Days</span>
								<div class="d-flex align-items-baseline gap-1">
									<span class="fw-bold" style="font-size: 22px; color: #047857;">5</span>
									<span style="color: #047857; font-size: 12px;">Days</span>
								</div>
								<span class="fw-medium" style="color: #059669; font-size: 11px;">Zero
									Tardiness</span>
							</div>
						</div>
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm"
									style="text-transform: none; letter-spacing: 0;">Absent
									/ Leave</span>
								<div class="d-flex align-items-baseline gap-1">
									<span class="fw-bold" style="font-size: 22px;">0</span> <span
										style="color: var(--on-surface-variant); font-size: 12px;">Days</span>
								</div>
								<span class="fw-medium"
									style="color: var(--on-surface-variant); font-size: 11px;">0
									PTO used</span>
							</div>
						</div>
						<div class="col">
							<div class="kpi-tile">
								<span class="kpi-label-sm"
									style="text-transform: none; letter-spacing: 0;">Total
									Hours</span>
								<div class="d-flex align-items-baseline gap-1">
									<span class="fw-bold"
										style="font-size: 22px; color: var(--primary);">43h 45m</span>
								</div>
								<span class="fw-medium"
									style="color: var(--secondary); font-size: 11px;">Target:
									40h (+3h 45m OT)</span>
							</div>
						</div>
					</div>

					<!-- Daily breakdown -->
					<div class="d-flex flex-column gap-3">
						<div class="d-flex flex-column gap-1">
							<div class="d-flex justify-content-between"
								style="font-size: 12px;">
								<span class="fw-medium">Monday, Sep 14</span> <span
									class="fw-bold">8h 50m</span>
							</div>
							<div class="weekly-progress-bar">
								<div
									style="width: 88.3%; height: 100%; background: var(--primary); border-radius: 999px;">
								</div>
							</div>
						</div>

						<div class="d-flex flex-column gap-1">
							<div class="d-flex justify-content-between"
								style="font-size: 12px;">
								<span class="fw-medium">Tuesday, Sep 15</span> <span
									class="fw-bold">8h 40m</span>
							</div>
							<div class="weekly-progress-bar">
								<div
									style="width: 86.6%; height: 100%; background: var(--primary); border-radius: 999px;">
								</div>
							</div>
						</div>

						<div class="d-flex flex-column gap-1">
							<div class="d-flex justify-content-between"
								style="font-size: 12px;">
								<span class="fw-medium">Wednesday, Sep 16</span> <span
									class="fw-bold" style="color: var(--secondary);">9h 00m
									<span class="fw-normal" style="font-size: 10px;">(+1h
										OT)</span>
								</span>
							</div>
							<div class="weekly-progress-bar">
								<div
									style="width: 90%; height: 100%; background: var(--secondary); border-radius: 999px;">
								</div>
							</div>
						</div>

						<div class="d-flex flex-column gap-1">
							<div class="d-flex justify-content-between"
								style="font-size: 12px;">
								<span class="fw-medium">Thursday, Sep 17</span> <span
									class="fw-bold">8h 32m</span>
							</div>
							<div class="weekly-progress-bar">
								<div
									style="width: 85.3%; height: 100%; background: var(--primary); border-radius: 999px;">
								</div>
							</div>
						</div>

						<div class="d-flex flex-column gap-1">
							<div class="d-flex justify-content-between"
								style="font-size: 12px;">
								<span class="fw-bold d-flex align-items-center gap-1"
									style="color: var(--primary);"> Friday, Sep 18 (Today) <span
									class="legend-dot"
									style="width: 6px; height: 6px; background: #10b981;"></span>
								</span> <span class="fw-bold" style="color: var(--primary);">8h
									43m</span>
							</div>
							<div class="weekly-progress-bar">
								<div
									style="width: 87.1%; height: 100%; background: var(--primary); border-radius: 999px;">
								</div>
							</div>
						</div>
					</div>


				</div>


			</div>
		</div>
	</main>
	<script>
		window.contextPath = "${pageContext.request.contextPath}";
	</script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/dashboard.js">
		
	</script>
	<script src="${pageContext.request.contextPath}/js/auth.js"></script>
</body>
</html>