<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		<!-- Page header -->
		<div
			class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-3">
			<div>
				<nav class="breadcrumb-custom">
					<span>Portal</span> <span class="material-symbols-outlined"
						style="font-size: 14px;">chevron_right</span> <span>Employee</span>
					<span class="material-symbols-outlined" style="font-size: 14px;">chevron_right</span>
					<span class="fw-semibold" style="color: var(--primary);">Weekly
						Timesheet</span>
				</nav>
				<div class="d-flex align-items-center gap-3 flex-wrap">
					<h1 class="fw-semibold mb-0"
						style="font-size: 28px; letter-spacing: -0.02em;">Weekly
						Timesheet</h1>
					<span class="period-pill">Period #38 • Q3</span>
				</div>
			</div>
			<div class="sync-pill">
				<span class="pulse-dot"></span> <span>Sync: <strong
					style="color: var(--on-surface);">Auto-saved (14:32)</strong></span>
			</div>
		</div>

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
						class="fw-semibold">14 Sep 2026 – 18 Sep 2026</span>
				</div>
				<button class="week-nav-btn" aria-label="Next Week" type="button">
					<span class="material-symbols-outlined fs-20">chevron_right</span>
				</button>
				<button class="btn-current-week" type="button">Current Week</button>
			</div>
			<div class="d-flex align-items-center gap-2 flex-wrap">
				<button class="btn btn-soft d-inline-flex align-items-center gap-2"
					onclick="window.print()" type="button">
					<span class="material-symbols-outlined fs-18">print</span><span>Print
						Timesheet</span>
				</button>
				<button class="btn btn-soft d-inline-flex align-items-center gap-2"
					id="exportCsvBtn" type="button">
					<span class="material-symbols-outlined fs-18">file_download</span><span>Export
						CSV</span>
				</button>
				<button
					class="btn btn-primary-soft d-inline-flex align-items-center gap-2"
					id="topSubmitBtn" type="button">
					<span class="material-symbols-outlined fs-18">send</span><span>Submit
						for Approval</span>
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
						baseline: 40h 00m</span>
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
						class="h6 mb-0">Daily Attendance &amp; Activity Log</span> <span
						style="background: var(--surface-container-high); color: var(--on-surface-variant); font-size: 11px; padding: 2px 8px; border-radius: 4px;">5
						Recorded Days</span>
				</div>
				<span style="color: var(--on-surface-variant); font-size: 13px;">Standard
					Workday: <strong>09:00 AM – 06:00 PM</strong> (1h Meal Break)
				</span>
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
							<th class="text-end">Actions</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="fw-medium">14-Sep-2026</td>
							<td class="fw-medium">Monday</td>
							<td>09:15 AM</td>
							<td>06:05 PM</td>
							<td class="fw-semibold" style="color: var(--primary);">8h
								50m</td>
							<td class="text-center"><span class="status-present"><span
									class="dot-secondary2"></span>Present</span></td>
							<td><span class="material-symbols-outlined fs-16"
								style="color: var(--on-surface-variant); font-size: 16px;">terminal</span>
								Setup MySQL local replica, handled user auth bugs</td>
							<td class="text-end">
								<button class="btn-viewdetail view-detail-btn" type="button"
									data-day="Monday, 14 Sep" data-in="09:15 AM"
									data-out="06:05 PM" data-hours="8h 50m"
									data-desc="Setup MySQL local replica, handled user auth bugs. Tested multi-tenant database switchover logic.">View
									Details</button>
							</td>
						</tr>
						<tr>
							<td class="fw-medium">15-Sep-2026</td>
							<td class="fw-medium">Tuesday</td>
							<td>09:20 AM</td>
							<td>06:00 PM</td>
							<td class="fw-semibold" style="color: var(--primary);">8h
								40m</td>
							<td class="text-center"><span class="status-present"><span
									class="dot-secondary2"></span>Present</span></td>
							<td><span class="material-symbols-outlined fs-16"
								style="color: var(--on-surface-variant); font-size: 16px;">api</span>
								Developed REST endpoints for timesheet servlet</td>
							<td class="text-end">
								<button class="btn-viewdetail view-detail-btn" type="button"
									data-day="Tuesday, 15 Sep" data-in="09:20 AM"
									data-out="06:00 PM" data-hours="8h 40m"
									data-desc="Developed REST endpoints for timesheet servlet and hooked JSON serializer to handle approval workflows.">View
									Details</button>
							</td>
						</tr>
						<tr>
							<td class="fw-medium">16-Sep-2026</td>
							<td class="fw-medium">Wednesday</td>
							<td>09:00 AM</td>
							<td>06:00 PM</td>
							<td class="fw-semibold" style="color: var(--primary);">9h
								00m</td>
							<td class="text-center"><span class="status-present"><span
									class="dot-secondary2"></span>Present</span></td>
							<td><span class="material-symbols-outlined fs-16"
								style="color: var(--on-surface-variant); font-size: 16px;">flaky</span>
								Code review, unit testing for JDBC transaction handlers</td>
							<td class="text-end">
								<button class="btn-viewdetail view-detail-btn" type="button"
									data-day="Wednesday, 16 Sep" data-in="09:00 AM"
									data-out="06:00 PM" data-hours="9h 00m"
									data-desc="Code review, unit testing for JDBC transaction handlers. Verified rollback isolation levels.">View
									Details</button>
							</td>
						</tr>
						<tr>
							<td class="fw-medium">17-Sep-2026</td>
							<td class="fw-medium">Thursday</td>
							<td>09:35 AM</td>
							<td>06:07 PM</td>
							<td class="fw-semibold" style="color: var(--primary);">8h
								32m</td>
							<td class="text-center"><span class="status-late"><span
									class="dot-outline"></span>Late (+35m)</span></td>
							<td><span class="material-symbols-outlined fs-16"
								style="color: var(--on-surface-variant); font-size: 16px;">bug_report</span>
								Fixed frontend form validation and session timeout</td>
							<td class="text-end">
								<button class="btn-viewdetail view-detail-btn" type="button"
									data-day="Thursday, 17 Sep" data-in="09:35 AM"
									data-out="06:07 PM" data-hours="8h 32m"
									data-desc="Fixed frontend form validation and session timeout warnings on inactivity.">View
									Details</button>
							</td>
						</tr>
						<tr>
							<td class="fw-medium">18-Sep-2026</td>
							<td class="fw-medium">Friday</td>
							<td>09:32 AM</td>
							<td>06:15 PM</td>
							<td class="fw-semibold" style="color: var(--primary);">8h
								43m</td>
							<td class="text-center"><span class="status-present"><span
									class="dot-secondary2"></span>Present</span></td>
							<td><span class="material-symbols-outlined fs-16"
								style="color: var(--on-surface-variant); font-size: 16px;">assignment_turned_in</span>
								Fixed teacher registration issue, finalized weekly report</td>
							<td class="text-end">
								<button class="btn-viewdetail view-detail-btn" type="button"
									data-day="Friday, 18 Sep" data-in="09:32 AM"
									data-out="06:15 PM" data-hours="8h 43m"
									data-desc="Fixed teacher registration issue, finalized weekly timesheet report and pushed git tags for v2.4.1 release.">View
									Details</button>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" class="text-end"
								style="color: var(--on-surface-variant);">Weekly Cumulative
								Total:</td>
							<td style="color: var(--primary);">43h 45m</td>
							<td colspan="3" class="fw-normal"
								style="color: var(--on-surface-variant); font-size: 13px;">Standard:
								40h 00m • Overtime: +3h 45m (100% Validated)</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>

		<!-- Distribution + Submission -->
		<div class="row g-3">
			<div class="col-12 col-lg-4">
				<div
					class="card-surface p-3 h-100 d-flex flex-column justify-content-between">
					<div class="d-flex align-items-center justify-content-between mb-2">
						<span class="h6 mb-0">Daily Distribution</span> <span
							style="color: var(--on-surface-variant); font-size: 12px;">Daily
							Base: 8.0h</span>
					</div>
					<div class="bar-chart">
						<div class="bar-col">
							<span style="color: var(--on-surface-variant); font-size: 11px;">8.8h</span>
							<div class="bar" style="height: 72px;"></div>
							<span class="fw-semibold" style="font-size: 11px;">Mon</span>
						</div>
						<div class="bar-col">
							<span style="color: var(--on-surface-variant); font-size: 11px;">8.7h</span>
							<div class="bar" style="height: 70px;"></div>
							<span class="fw-semibold" style="font-size: 11px;">Tue</span>
						</div>
						<div class="bar-col">
							<span
								style="color: var(--secondary); font-weight: 700; font-size: 11px;">9.0h</span>
							<div class="bar highlight" style="height: 80px;"></div>
							<span class="fw-semibold" style="font-size: 11px;">Wed</span>
						</div>
						<div class="bar-col">
							<span style="color: var(--on-surface-variant); font-size: 11px;">8.5h</span>
							<div class="bar" style="height: 68px;"></div>
							<span class="fw-semibold" style="font-size: 11px;">Thu</span>
						</div>
						<div class="bar-col">
							<span style="color: var(--on-surface-variant); font-size: 11px;">8.7h</span>
							<div class="bar" style="height: 71px;"></div>
							<span class="fw-semibold" style="font-size: 11px;">Fri</span>
						</div>
					</div>
					<div class="footer-note mt-2">
						<span>Target: 40h standard</span> <span class="fw-semibold"
							style="color: var(--secondary);">+3.75h recorded overtime</span>
					</div>
				</div>
			</div>

			<div class="col-12 col-lg-8">
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

</body>
</html>