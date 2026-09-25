<%@ page import="java.util.List"%>
<%@ page import="model.AttendanceRecord"%>
<%
java.util.List<model.AttendanceRecord> attendanceRecords = (java.util.List<model.AttendanceRecord>) request
		.getAttribute("attendanceRecords");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weekly Time Sheet</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/weeklyTimeSheet.css">
</head>
<body>

	<jsp:include page="/navbar.jsp" />
	<jsp:include page="/sidebar.jsp" />

	<main class="app-main">



		<!-- Week nav & actions -->
		<div
			class="card-surface p-3 mb-3 d-flex flex-column flex-xl-row align-items-stretch align-items-xl-center justify-content-between gap-3">
			<div class="d-flex align-items-center gap-2 flex-wrap">
				<button class="week-nav-btn" aria-label="Previous Week"
					type="button">
					<span class="material-symbols-outlined fs-20">chevron_left</span>
				</button>
				<div class="week-display">
					<span class="material-symbols-outlined fs-20"
						style="color: var(--secondary);">calendar_month</span> <span
						class="fw-bold" style="color: var(--primary);">Week 38:</span> <span
						class="fw-semibold">14 Sep 2026 - 18 Sep 2026</span>
				</div>
				<button class="week-nav-btn" aria-label="Next Week" type="button">
					<span class="material-symbols-outlined fs-20">chevron_right</span>
				</button>
				<button class="btn-current-week" type="button">Current Week</button>
			</div>
			<div class="d-flex align-items-center gap-2 flex-wrap">
				<button id="printExport"
					class="btn btn-soft d-inline-flex align-items-center gap-2"
					onclick="window.print()" type="button">
					<span class="material-symbols-outlined fs-18">print</span><span>Print
						Timesheet</span>
				</button>
				<button class="btn btn-soft d-inline-flex align-items-center gap-2"
					id="exportCsvBtn" type="button">
					<span class="material-symbols-outlined fs-18">file_download</span><span>Export
						CSV</span>
				</button>

			</div>
		</div>

		<!-- KPI row -->
		<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-3 mb-3">
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between mb-2">
						<span class="kpi-label">Logged Hours</span> <span
							class="material-symbols-outlined fs-20"
							style="color: var(--secondary);">timelapse</span>
					</div>
					<div class="d-flex align-items-baseline gap-2">
						<span class="kpi-value">43h 45m</span> <span class="kpi-chip">109%</span>
					</div>
					<span style="color: var(--on-surface-variant); font-size: 12px;">Target
						baseline: 30h 00m / Week</span>
				</div>
			</div>
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between mb-2">
						<span class="kpi-label">Overtime Accrued</span> <span
							class="material-symbols-outlined fs-20"
							style="color: var(--secondary);">more_time</span>
					</div>
					<div class="d-flex align-items-baseline gap-2">
						<span class="kpi-value" style="color: var(--secondary);">+3h
							45m</span> <span class="kpi-chip solid">Billable OT</span>
					</div>
					<span style="color: var(--on-surface-variant); font-size: 12px;">Approved
						cap: +10h / cycle</span>
				</div>
			</div>
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between mb-2">
						<span class="kpi-label">Punctuality Score</span> <span
							class="material-symbols-outlined fs-20"
							style="color: var(--secondary);">verified</span>
					</div>
					<div class="d-flex align-items-baseline gap-2">
						<span class="kpi-value">80%</span> <span class="kpi-chip">4
							on-time / 1 late</span>
					</div>
					<span style="color: var(--on-surface-variant); font-size: 12px;">Avg
						Check-in: 09:18 AM</span>
				</div>
			</div>
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between mb-2">
						<span class="kpi-label">Approval Stage</span> <span
							class="material-symbols-outlined fs-20"
							style="color: var(--on-surface-variant);">pending_actions</span>
					</div>
					<div class="d-flex align-items-center gap-2">
						<span class="legend-dot"
							style="width: 10px; height: 10px; border-radius: 50%; background: var(--secondary-container); display: inline-block;"></span>
						<span class="h6 mb-0">Draft</span>
					</div>
					<span style="color: var(--on-surface-variant); font-size: 12px;">Submission
						window open</span>
				</div>
			</div>
		</div>

		<!-- Timesheet table -->
		<div class="card-surface mb-3 overflow-hidden">
			<div
				class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-2 px-4 py-3"
				style="background: var(--surface-container-low);">
				<div class="d-flex align-items-center gap-2 flex-wrap">
					<span class="material-symbols-outlined fs-20"
						style="color: var(--primary);">table_chart</span> <span
						class="h6 mb-0">Daily Attendance &amp; Activity Record</span>
				</div>
				<div class="timesheet-search d-flex align-items-center gap-2">
					<div class="search-wrapper">
						<span class="material-symbols-outlined search-icon fs-18">search</span>

						<input type="text" id="timesheetSearch"
							class="timesheet-search-input" placeholder="Search records..."
							autocomplete="off">
					</div>

					<button type="button" id="clearTimesheetSearch"
						class="btn btn-soft search-clear-btn">Clear</button>
				</div>
			</div>
			<div class="table-responsive">
				<table class="table timesheet-table mb-0" id="timesheetTable">
					<thead>
						<tr>
							<th>Date</th>
							<th>Day</th>
							<th>Check In</th>
							<th>Check Out</th>
							<th>Duration</th>
							<th class="text-center">Status</th>
							<th style="min-width: 260px;">Work Description</th>
							<th class="text-end">Action</th>
						</tr>
					</thead>
					<tbody>

						<%
						if (attendanceRecords != null && !attendanceRecords.isEmpty()) {

							for (model.AttendanceRecord record : attendanceRecords) {
						%>

						<tr>

							<td><%=record.getFormattedDate()%></td>

							<td><%=record.getDayName()%></td>

							<td><%=record.getFormattedCheckIn()%></td>

							<td><%=record.getFormattedCheckOut()%></td>

							<td><%=record.getFormattedTotalHours()%></td>

							<td class="text-center"><%=record.getStatus()%></td>

							<td><%=record.getWorkDescription() != null ? record.getWorkDescription() : "No description"%></td>

							<td class="text-end">
								<!-- your existing Actions button -->
							</td>

						</tr>

						<%
						}

						} else {
						%>

						<tr>
							<td colspan="8" class="text-center">No attendance records
								found.</td>
						</tr>

						<%
						}
						%>

					</tbody>
				</table>
				<div class="timesheet-pagination">

					<div class="pagination-info" id="paginationInfo">Showing 1–10
						of 10 records</div>

					<div class="pagination-controls">

						<button type="button" class="pagination-btn" id="prevPage">
							<span class="material-symbols-outlined">chevron_left</span>
						</button>

						<div id="paginationNumbers" class="pagination-numbers"></div>

						<button type="button" class="pagination-btn" id="nextPage">
							<span class="material-symbols-outlined">chevron_right</span>
						</button>

					</div>

				</div>
			</div>
		</div>

		<!-- Distribution + Submission -->
		<div class="row g-3">


			<div class="col-12 col-lg">
				<div
					class="card-surface p-3 h-100 d-flex flex-column justify-content-between">
					<div
						class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-2 p-3 rounded-3"
						style="background: var(--surface-container-low);">
						<div class="d-flex align-items-center gap-3">
							<div class="avatar-round">
								<span class="material-symbols-outlined fs-24">assignment</span>
							</div>
							<div>
								<div class="d-flex align-items-center gap-2 flex-wrap">
									<span class="fw-semibold">Timesheet Status:</span> <span
										class="status-draft-badge">Draft - Pending Employee
										Submission</span>
								</div>
								<p class="mb-0"
									style="color: var(--on-surface-variant); font-size: 12px;">
									Supervisor review will be routed to: <strong
										style="color: var(--on-surface);">Marcus Vance
										(Engineering Lead)</strong>
								</p>
							</div>
						</div>
						<div class="text-sm-end">
							<span class="d-block"
								style="color: var(--on-surface-variant); font-size: 11px; text-transform: uppercase;">Submission
								Cutoff</span> <span class="fw-semibold"
								style="color: var(--error); font-size: 14px;">Sunday, 20
								Sep 23:59 PM</span>
						</div>
					</div>

					<div class="my-3">
						<label class="d-flex align-items-start gap-2"
							style="cursor: pointer;"> <input class="ack-checkbox"
							id="employeeAckCheckbox" type="checkbox"> <span
							style="color: var(--on-surface-variant); font-size: 13px;">
								I certify that the recorded check-in, check-out, and duration
								metrics represent an authentic reflection of my work performed
								for <strong>Week 38 (14 Sep – 18 Sep 2026)</strong> in full
								compliance with corporate policy.
						</span>
						</label>
					</div>

					<div
						class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3 pt-2">
						<div class="d-flex align-items-center gap-3 flex-wrap">
							<div>
								<span class="d-block"
									style="color: var(--on-surface-variant); font-size: 11px;">Total
									Weekly</span> <span class="h6 mb-0">43h 45m</span>
							</div>
							<div class="divider-v-sm"></div>
							<div>
								<span class="d-block"
									style="color: var(--on-surface-variant); font-size: 11px;">Expected
									Standard</span> <span class="h6 mb-0">40h 00m</span>
							</div>
							<div class="divider-v-sm"></div>
							<div>
								<span class="d-block"
									style="color: var(--secondary); font-size: 11px;">Variance
									/ Overtime</span> <span class="h6 mb-0 fw-bold"
									style="color: var(--secondary);">+3h 45m</span>
							</div>
						</div>
						<div class="d-flex gap-2">
							<button class="btn btn-soft" type="button">Save as Draft</button>
							<button
								class="btn btn-primary-soft d-inline-flex align-items-center gap-2"
								id="submitToManagerBtn" type="button" disabled>
								<span class="material-symbols-outlined fs-18">verified_user</span><span>Submit
									to Manager</span>
							</button>
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
		src="${pageContext.request.contextPath}/js/weeklyTimeSheet.js">
		
	</script>
	
	<script src="${pageContext.request.contextPath}/js/auth.js"></script>

</body>
</html>