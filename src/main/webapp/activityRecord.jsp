<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Activity Record</title>
<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/weeklyTimeSheet.css">

<!-- Fonts + Material Symbols -->
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
	<jsp:include page="/navbar.jsp" />
	<jsp:include page="/sidebar.jsp" />

	<main class="app-main">

		<!-- Header & date navigation -->
		<div
			class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 py-3">
			<div>
				<div class="breadcrumb-custom">
					<span>WorkMatrix</span> <span class="material-symbols-outlined"
						style="font-size: 12px;">chevron_right</span> <span>Daily
						Logging</span>
				</div>
				<h1 class="fw-semibold mt-1 mb-1"
					style="font-size: 24px; letter-spacing: -0.015em;">Activity</h1>
				<p class="mb-0"
					style="color: var(--on-surface-variant); font-size: 13px;">Track,
					verify, and record operational deliverables across standard 2-hour
					shift windows.</p>
			</div>

			<div class="d-flex flex-wrap align-items-center gap-2">
				<div class="date-toolbar">
					<button type="button" title="Previous working day">
						<span class="material-symbols-outlined" style="font-size: 16px;">arrow_back</span>
						<span class="d-none d-sm-inline">20 Sep</span>
					</button>
					<div class="date-today">
						<span class="material-symbols-outlined"
							style="font-size: 16px; color: var(--secondary);">calendar_today</span>
						<span>Today: Mon, 21 Sep 2026</span> <span
							class="material-symbols-outlined"
							style="font-size: 16px; color: var(--on-surface-variant);">unfold_more</span>
					</div>
					<button type="button" disabled title="Future date inaccessible">
						<span class="d-none d-sm-inline">22 Sep</span> <span
							class="material-symbols-outlined" style="font-size: 16px;">arrow_forward</span>
					</button>
				</div>
				<div class="d-flex align-items-center gap-2">
					<button
						class="btn btn-toolbar-soft d-inline-flex align-items-center gap-2"
						type="button">
						<span class="material-symbols-outlined fs-16">download</span> <span
							class="d-none d-xl-inline">Export Summary (CSV)</span>
					</button>
					<button class="btn-icon-square" title="Print Log" type="button">
						<span class="material-symbols-outlined fs-16">print</span>
					</button>
				</div>
			</div>
		</div>

		<!-- KPI cards -->
		<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-3 my-1">
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between">
						<span
							style="font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .04em; color: var(--on-surface-variant);">Shift
							Allocation</span> <span class="kpi-icon-box"
							style="background: var(--surface-container-low); color: var(--primary);"><span
							class="material-symbols-outlined fs-20">view_agenda</span></span>
					</div>
					<div class="mt-3">
						<div class="d-flex align-items-baseline gap-1">
							<span class="kpi-value">4</span> <span
								style="color: var(--on-surface-variant); font-size: 13px;">Slots</span>
						</div>
						<p class="mb-0 mt-1"
							style="color: var(--on-surface-variant); font-size: 11px;">8h
							Standard Shift Window</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between">
						<span
							style="font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .04em; color: var(--on-surface-variant);">Completed</span>
						<span class="kpi-icon-box"
							style="background: var(--secondary-fixed); color: var(--secondary);"><span
							class="material-symbols-outlined fs-20">task_alt</span></span>
					</div>
					<div class="mt-3">
						<div class="d-flex align-items-baseline gap-2">
							<span class="kpi-value">2</span> <span class="kpi-chip"
								style="background: var(--secondary-fixed); color: var(--on-secondary-fixed);">50%
								Logged</span>
						</div>
						<p class="mb-0 mt-1"
							style="color: var(--on-surface-variant); font-size: 11px;">4h
							00m Verified &amp; Audit Ready</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="kpi-card kpi-active-card">
					<div class="d-flex align-items-center justify-content-between">
						<span
							style="font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .04em; color: var(--primary);">Active
							Interval</span> <span
							class="position-relative d-inline-flex align-items-center justify-content-center"
							style="width: 12px; height: 12px;"> <span
							class="position-absolute rounded-circle"
							style="width: 12px; height: 12px; background: var(--secondary-container); opacity: .75; animation: ping 1.5s cubic-bezier(0, 0, 0.2, 1) infinite;"></span>
							<span class="position-relative rounded-circle"
							style="width: 9px; height: 9px; background: var(--secondary);"></span>
						</span>
					</div>
					<div class="mt-3">
						<span class="fw-semibold" style="font-size: 20px;">13:00 –
							15:00</span>
						<p class="mb-0 mt-1 fw-semibold d-flex align-items-center gap-1"
							style="color: var(--secondary); font-size: 11px;">
							<span class="material-symbols-outlined" style="font-size: 12px;">timer</span>
							Window closes in 45m
						</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="kpi-card">
					<div class="d-flex align-items-center justify-content-between">
						<span
							style="font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .04em; color: var(--on-surface-variant);">Pending
							Window</span> <span class="kpi-icon-box"
							style="background: var(--surface-container-high); color: var(--on-surface-variant);"><span
							class="material-symbols-outlined fs-20">lock_clock</span></span>
					</div>
					<div class="mt-3">
						<div class="d-flex align-items-baseline gap-1">
							<span class="kpi-value">1</span> <span
								style="color: var(--on-surface-variant); font-size: 13px;">Slot
								remaining</span>
						</div>
						<p class="mb-0 mt-1"
							style="color: var(--on-surface-variant); font-size: 11px;">Unlocks
							at 03:00 PM</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Main 2-column layout -->
		<div class="row g-4 mt-1">

			<!-- Left/center: timeline slots -->
			<div class="col-12 col-lg-8 d-flex flex-column gap-3">

				<div class="d-flex align-items-center justify-content-between px-1">
					<div class="d-flex align-items-center gap-2">
						<span class="h6 mb-0">Daily Slot Schedule</span> <span
							style="background: var(--surface-container-high); color: var(--on-surface-variant); font-size: 11px; padding: 2px 10px; border-radius: 999px;">2-Hour
							Policy Interval</span>
					</div>
					<div class="d-flex align-items-center gap-1"
						style="color: var(--on-surface-variant); font-size: 11px;">
						<span
							style="width: 8px; height: 8px; border-radius: 50%; background: var(--secondary); display: inline-block;"></span>
						Live Sync Enabled
					</div>
				</div>

				<!-- SLOT 1: Completed -->
				<div class="slot-card">
					<div class="slot-header">
						<div class="d-flex align-items-center gap-2">
							<span class="slot-num">01</span>
							<div class="d-flex flex-column">
								<span class="h6 mb-0">09:00 AM – 11:00 AM</span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">Duration:
									2h 00m • Morning Onset</span>
							</div>
						</div>
						<span class="status-pill status-completed"><span
							class="material-symbols-outlined" style="font-size: 12px;">check_circle</span>Completed</span>
					</div>
					<p class="mb-2" style="line-height: 1.6;">Worked on employee
						dashboard and fixed attendance API integration. Refactored
						password encryption hashing logic and handled database connection
						pooling exceptions for MySQL connector.</p>
					<div class="d-flex flex-wrap gap-2 mb-2">
						<span class="tag-pill">#Dashboard</span> <span class="tag-pill">#API-Integration</span>
						<span class="tag-pill">#BugFix</span>
					</div>
					<div
						class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-2 pt-2"
						style="border-top: 1px solid var(--surface-container);">
						<div class="slot-footer-note">
							<span class="material-symbols-outlined" style="font-size: 14px;">schedule_send</span>
							<span>Submitted at 11:05 AM via Web Portal</span>
						</div>
						<button class="btn-linklike" type="button">
							<span class="material-symbols-outlined fs-16">edit_note</span>View
							/ Edit Entry
						</button>
					</div>
				</div>

				<!-- SLOT 2: Completed -->
				<div class="slot-card">
					<div class="slot-header">
						<div class="d-flex align-items-center gap-2">
							<span class="slot-num">02</span>
							<div class="d-flex flex-column">
								<span class="h6 mb-0">11:00 AM – 01:00 PM</span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">Duration:
									2h 00m • Midday Sprint</span>
							</div>
						</div>
						<span class="status-pill status-completed"><span
							class="material-symbols-outlined" style="font-size: 12px;">check_circle</span>Completed</span>
					</div>
					<p class="mb-2" style="line-height: 1.6;">Implemented check-in
						and check-out functionality. Created modular JSP includes for top
						navigation bar and responsive sidebar with active route states.
						Tested biometric device payload ingestion mock.</p>
					<div class="d-flex flex-wrap gap-2 mb-2">
						<span class="tag-pill">#CheckIn</span> <span class="tag-pill">#Auth</span>
						<span class="tag-pill">#JSP</span>
					</div>
					<div
						class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-2 pt-2"
						style="border-top: 1px solid var(--surface-container);">
						<div class="slot-footer-note">
							<span class="material-symbols-outlined" style="font-size: 14px;">schedule_send</span>
							<span>Submitted at 01:02 PM via Web Portal</span>
						</div>
						<button class="btn-linklike" type="button">
							<span class="material-symbols-outlined fs-16">edit_note</span>View
							/ Edit Entry
						</button>
					</div>
				</div>

				<!-- SLOT 3: ACTIVE / CURRENT -->
				<div class="slot-card active-slot">
					<div class="slot-header emphasized">
						<div class="d-flex align-items-center gap-2">
							<span class="slot-num current">03</span>
							<div class="d-flex flex-column">
								<span class="h6 mb-0 fw-bold">01:00 PM – 03:00 PM</span> <span
									class="fw-semibold"
									style="color: var(--primary); font-size: 11px;">Duration:
									2h 00m • Slot Closes in 45 Minutes</span>
							</div>
						</div>
						<span class="status-pill status-current"><span
							style="width: 8px; height: 8px; border-radius: 50%; background: var(--secondary-container); display: inline-block;"></span>Current
							Window (Action Required)</span>
					</div>

					<form class="d-flex flex-column gap-3">
						<div>
							<div
								class="d-flex align-items-center justify-content-between mb-2">
								<label class="fw-semibold d-flex align-items-center gap-1"
									for="slot-activity-input" style="font-size: 14px;">
									What did you work on during this time? <span
									style="color: var(--error);">*</span>
								</label> <span
									style="color: var(--on-surface-variant); font-size: 11px; font-variant-numeric: tabular-nums;"
									id="char-counter">142 / 500 characters</span>
							</div>
							<textarea class="form-control slot-textarea p-3"
								id="slot-activity-input" rows="4"
								placeholder="What did you work on during this time? Describe deliverables, tickets resolved, or commits...">Integrating JDBC query handlers for activity_log table and creating prepared statements for batch insertion of 2-hour slot records...</textarea>
						</div>

						<div>
							<span
								style="color: var(--on-surface-variant); font-size: 11px; text-transform: uppercase; letter-spacing: .04em;">Categorization
								Tags</span>
							<div class="d-flex flex-wrap gap-2 mt-2">
								<button
									class="tag-btn selected d-inline-flex align-items-center gap-1"
									type="button">
									<span class="material-symbols-outlined"
										style="font-size: 12px;">check</span> Development
								</button>
								<button class="tag-btn unselected" type="button">+ Bug
									Fixing</button>
								<button class="tag-btn unselected" type="button">+
									Meeting / Review</button>
								<button class="tag-btn unselected" type="button">+ Code
									Review</button>
							</div>
						</div>

						<div class="slot-action-bar">
							<div class="d-flex align-items-center gap-2"
								style="color: var(--secondary); font-size: 12px;">
								<span class="material-symbols-outlined fs-16">verified</span> <span>Minimum
									20 characters satisfied (Draft Auto-saved)</span>
							</div>
							<div class="d-flex gap-2">
								<button class="btn btn-save-draft" type="button">Save
									Draft</button>
								<button
									class="btn btn-submit-activity d-inline-flex align-items-center gap-2"
									type="submit">
									<span class="material-symbols-outlined fs-16">send</span>Submit
									Activity
								</button>
							</div>
						</div>
					</form>
				</div>

				<!-- SLOT 4: Upcoming / Locked -->
				<div class="slot-card locked-slot">
					<div class="slot-header">
						<div class="d-flex align-items-center gap-2">
							<span class="slot-num locked">04</span>
							<div class="d-flex flex-column">
								<span class="h6 mb-0">03:00 PM – 05:00 PM</span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">Duration:
									2h 00m • Shift Wrap-up</span>
							</div>
						</div>
						<span class="status-pill status-locked"><span
							class="material-symbols-outlined" style="font-size: 12px;">lock</span>Upcoming
							• Locked</span>
					</div>
					<div class="locked-note">
						<div class="d-flex align-items-center gap-2"
							style="color: var(--on-surface-variant); font-size: 13px;">
							<span class="material-symbols-outlined"
								style="color: var(--outline);">info</span> <span>Available
								at 03:00 PM. Future time slots unlock automatically during
								standard shift hours.</span>
						</div>
						<button class="btn-locked" disabled type="button">Slot
							Locked until 03:00 PM</button>
					</div>
				</div>

				<!-- Empty state demo box -->
				<div class="empty-state-box">
					<div class="d-flex align-items-center gap-2">
						<span class="empty-state-icon"><span
							class="material-symbols-outlined fs-20">tips_and_updates</span></span>
						<div class="d-flex flex-column">
							<span class="fw-semibold" style="font-size: 13px;">Slot
								Empty State Handling</span> <span
								style="color: var(--on-surface-variant); font-size: 12px;">When
								an active slot contains zero keystrokes, standard state presents
								an explicit prompt with direct tag templates.</span>
						</div>
					</div>
					<button
						class="btn-sample-prompt d-inline-flex align-items-center gap-1"
						type="button">
						<span class="material-symbols-outlined fs-16">add_circle</span><span>Sample
							Prompt State</span>
					</button>
				</div>
			</div>

			<!-- Right rail -->
			<div class="col-12 col-lg-4 d-flex flex-column gap-3">

				<!-- Biometric sync -->
				<div class="card-surface p-3">
					<div class="d-flex align-items-center justify-content-between pb-2">
						<div class="d-flex align-items-center gap-2">
							<span class="material-symbols-outlined fs-20"
								style="color: var(--primary);">fingerprint</span> <span
								class="h6 mb-0">Biometric Sync</span>
						</div>
						<span class="sync-badge">Active</span>
					</div>
					<div class="d-flex flex-column gap-2">
						<div class="sync-row">
							<span style="color: var(--on-surface-variant); font-size: 13px;">Shift
								Terminal Check-in</span> <span class="fw-bold"
								style="font-variant-numeric: tabular-nums;">08:58 AM</span>
						</div>
						<div class="d-flex flex-column gap-1 pt-1">
							<div class="d-flex justify-content-between"
								style="font-size: 12px;">
								<span style="color: var(--on-surface-variant);">Logged
									Activity vs Shift Target</span> <span class="fw-semibold"
									style="color: var(--primary); font-variant-numeric: tabular-nums;">4h
									00m / 8h 00m</span>
							</div>
							<div class="progress-track">
								<div
									style="width: 50%; height: 100%; background: var(--primary); border-radius: 999px;"></div>
							</div>
							<div class="d-flex justify-content-between"
								style="font-size: 11px; color: var(--on-surface-variant);">
								<span>0h (Start)</span> <span class="fw-medium"
									style="color: var(--secondary);">50% Completed</span> <span>8h
									(Quota)</span>
							</div>
						</div>
						<div class="reminder-box mt-1">
							<span class="material-symbols-outlined"
								style="color: var(--secondary);">notifications_active</span>
							<div>
								<span class="fw-semibold d-block" style="font-size: 12px;">Next
									Interval Reminder:</span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">02:50
									PM (10 min prior to slot lock)</span>
							</div>
						</div>
					</div>
				</div>

				<!-- Compliance -->
				<div class="card-surface p-3">
					<div class="d-flex align-items-center gap-2 pb-2">
						<span class="material-symbols-outlined fs-20"
							style="color: var(--primary);">policy</span> <span
							class="h6 mb-0">Audit &amp; Policy Guidelines</span>
					</div>
					<div
						style="color: var(--on-surface-variant); font-size: 13px; line-height: 1.6;">
						<p>
							<strong style="color: var(--on-surface);">Why 2-Hour
								Logging?</strong> Frequent granular updates prevent end-of-day reporting
							fatigue, ensure sprint accuracy, and provide automated timesheet
							verification for compliance audits.
						</p>
						<ul class="policy-list mb-2">
							<li>Entries must exceed minimum 20 characters</li>
							<li>Submit before interval close to avoid late flags</li>
							<li>Tag appropriate Jira/Sprint delivery components</li>
						</ul>
						<a class="policy-link" href="#"><span>Corporate Logging
								Policy Manual</span><span class="material-symbols-outlined fs-16">arrow_forward</span></a>
					</div>
				</div>

				<!-- Reviewer -->
				<div class="card-surface p-3 reviewer-card">
					<span
						style="color: var(--on-surface-variant); font-size: 11px; text-transform: uppercase; letter-spacing: .04em;">Designated
						Reviewer</span>
					<div class="d-flex align-items-center gap-2 mt-2 mb-3">
						<img class="reviewer-avatar" alt="Evelyn Vance"
							src="https://lh3.googleusercontent.com/aida-public/AB6AXuDTSZTiCSmOtZuixElnSf_Uua6RGyUjcKSfMSQ5ruKxmaHzNHdvORxVrDodm3OutPEaoN_NT-9KLm7uvq53mlTDTfTelBSLlY2taIsaIW_i8R-MGc1U9pWlm1gMEvRo9AivhdIzYS5vsbn39TW07psTeylERhWXguclgXx7Hlo-H1yOWm0C4wcrh8O-j87hPteQRsTFoylkFDxZv6-22s55vW03o6Rtd92o2oU08IoY2-vVM-Gly1WOmg">
						<div class="d-flex flex-column">
							<span class="fw-semibold" style="font-size: 13px;">Evelyn
								Vance</span> <span
								style="color: var(--on-surface-variant); font-size: 12px;">Lead
								Architect • Platform Eng</span>
						</div>
					</div>
					<div class="reviewer-footer">
						<span>Auto-digest dispatch:</span> <span class="fw-medium"
							style="color: var(--on-surface); font-variant-numeric: tabular-nums;">17:00
							PM</span>
					</div>
				</div>

				<!-- Tips -->
				<div class="tips-card">
					<div class="d-flex align-items-start gap-2">
						<span class="material-symbols-outlined"
							style="color: var(--secondary-container);">electric_bolt</span>
						<div>
							<h2 class="h6 mb-1" style="color: var(--on-primary);">Keyboard
								Shortcuts</h2>
							<p class="mb-0" style="font-size: 13px; color: #cce5ff;">
								Press
								<kbd>Ctrl + Enter</kbd>
								to submit your current active slot directly without reaching for
								the mouse.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>

	</main>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<style>
@
keyframes ping { 75%, 100% {
	transform: scale(2);
	opacity: 0;
}
}
</style>
</body>
</html>