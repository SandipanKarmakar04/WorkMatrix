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
	href="${pageContext.request.contextPath}/css/activityRecord.css">

<!-- Fonts + Material Symbols -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&display=swap"
	rel="stylesheet">
<style>
#slot-activity-input {
	pointer-events: auto !important;
	position: relative !important;
	z-index: 99999 !important;
	background: white !important;
	color: black !important;
}
</style>

</head>
<body>
	<jsp:include page="/navbar.jsp" />
	<jsp:include page="/sidebar.jsp" />

	<main class="app-main">


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
						<span class="h6 mb-0">Submit Your Work</span> <span
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


				<!-- ACTIVITY RECORDS FROM DATABASE -->

				<%
				java.util.List<model.ActivityRecord> activityRecords = (java.util.List<model.ActivityRecord>) request
						.getAttribute("activityRecords");
				%>


				<!-- SLOT 1 -->

				<%
				boolean slot1Completed = false;
				model.ActivityRecord slot1Record = null;

				if (activityRecords != null) {
					for (model.ActivityRecord record : activityRecords) {
						if (record.getSlotNumber() == 1) {
					slot1Completed = true;
					slot1Record = record;
					break;
						}
					}
				}
				%>

				<div class="slot-card">

					<div class="slot-header">

						<div class="d-flex align-items-center gap-2">

							<span class="slot-num">01</span>

							<div class="d-flex flex-column">

								<span class="h6 mb-0"> 11:00 AM – 13:00 PM </span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">
									Duration: 2h 00m </span>

							</div>

						</div>

						<span
							class="status-pill <%=slot1Completed ? "status-completed" : "status-current"%>">

							<%
							if (slot1Completed) {
							%> <span class="material-symbols-outlined"
							style="font-size: 12px;"> check_circle </span> Completed <%
 } else {
 %> Available <%
 }
 %>

						</span>

					</div>


					<%
					if (slot1Completed) {
					%>

					<p class="mb-2" style="line-height: 1.6;">
						<%=slot1Record.getWorkDescription()%>
					</p>

					<div class="d-flex flex-wrap gap-2 mb-2">

						<span class="tag-pill"> #<%=slot1Record.getCategory()%>
						</span>

					</div>

					<div class="slot-footer-note">
						<span class="material-symbols-outlined" style="font-size: 14px;">
							schedule_send </span> Submitted at
						<%=slot1Record.getSubmittedAt()%>
					</div>

					<%
					} else {
					%>

					<form action="${pageContext.request.contextPath}/submitActivity"
						method="post" class="d-flex flex-column gap-3">

						<input type="hidden" name="slotNumber" value="1"> <input
							type="hidden" name="startTime" value="11:00"> <input
							type="hidden" name="endTime" value="13:00"> <input
							type="hidden" name="category" value="Development">

						<textarea name="workDescription"
							class="form-control slot-textarea p-3" rows="4" maxlength="500"
							required placeholder="What did you work on during this time?"></textarea>

						<div class="slot-action-bar">

							<button type="submit" class="btn btn-submit-activity"
								id="submitRecord">

								<span class="material-symbols-outlined fs-16"> send </span>

								Submit Activity

							</button>

						</div>

					</form>

					<%
					}
					%>

				</div>


				<!-- SLOT 2 -->

				<%
				boolean slot2Completed = false;
				model.ActivityRecord slot2Record = null;

				if (activityRecords != null) {
					for (model.ActivityRecord record : activityRecords) {
						if (record.getSlotNumber() == 2) {
					slot2Completed = true;
					slot2Record = record;
					break;
						}
					}
				}
				%>

				<div class="slot-card">

					<div class="slot-header">

						<div class="d-flex align-items-center gap-2">

							<span class="slot-num">02</span>

							<div class="d-flex flex-column">

								<span class="h6 mb-0"> 14:00 PM – 16:00 PM </span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">
									Duration: 2h 00m </span>

							</div>

						</div>

						<span
							class="status-pill <%=slot2Completed ? "status-completed" : "status-current"%>">

							<%
							if (slot2Completed) {
							%> <span class="material-symbols-outlined"
							style="font-size: 12px;"> check_circle </span> Completed <%
 } else {
 %> Available <%
 }
 %>

						</span>

					</div>


					<%
					if (slot2Completed) {
					%>

					<p class="mb-2" style="line-height: 1.6;">
						<%=slot2Record.getWorkDescription()%>
					</p>

					<div class="d-flex flex-wrap gap-2 mb-2">

						<span class="tag-pill"> #<%=slot2Record.getCategory()%>
						</span>

					</div>

					<div class="slot-footer-note">

						<span class="material-symbols-outlined" style="font-size: 14px;">
							schedule_send </span> Submitted at
						<%=slot2Record.getSubmittedAt()%>

					</div>

					<%
					} else {
					%>

					<form action="${pageContext.request.contextPath}/submitActivity"
						method="post" class="d-flex flex-column gap-3">

						<input type="hidden" name="slotNumber" value="2"> <input
							type="hidden" name="startTime" value="14:00"> <input
							type="hidden" name="endTime" value="16:00"> <input
							type="hidden" name="category" value="Development">

						<textarea name="workDescription"
							class="form-control slot-textarea p-3" rows="4" maxlength="500"
							required placeholder="What did you work on during this time?"></textarea>

						<div class="slot-action-bar">

							<button type="submit" class="btn btn-submit-activity"
								id="submitRecord">

								<span class="material-symbols-outlined fs-16"> send </span>

								Submit Activity

							</button>

						</div>

					</form>

					<%
					}
					%>

				</div>


				<!-- SLOT 3 -->

				<%
				boolean slot3Completed = false;
				model.ActivityRecord slot3Record = null;

				if (activityRecords != null) {
					for (model.ActivityRecord record : activityRecords) {
						if (record.getSlotNumber() == 3) {
					slot3Completed = true;
					slot3Record = record;
					break;
						}
					}
				}
				%>

				<div class="slot-card">

					<div class="slot-header">

						<div class="d-flex align-items-center gap-2">

							<span class="slot-num">03</span>

							<div class="d-flex flex-column">

								<span class="h6 mb-0"> 16:00 PM – 18:00 PM </span> <span
									style="color: var(--on-surface-variant); font-size: 11px;">
									Duration: 2h 00m </span>

							</div>

						</div>

						<span
							class="status-pill <%=slot3Completed ? "status-completed" : "status-current"%>">

							<%
							if (slot3Completed) {
							%> <span class="material-symbols-outlined"
							style="font-size: 12px;"> check_circle </span> Completed <%
 } else {
 %> Available <%
 }
 %>

						</span>

					</div>


					<%
					if (slot3Completed) {
					%>

					<p class="mb-2" style="line-height: 1.6;">
						<%=slot3Record.getWorkDescription()%>
					</p>

					<div class="d-flex flex-wrap gap-2 mb-2">

						<span class="tag-pill"> #<%=slot3Record.getCategory()%>
						</span>

					</div>

					<div class="slot-footer-note">

						<span class="material-symbols-outlined" style="font-size: 14px;">
							schedule_send </span> Submitted at
						<%=slot3Record.getSubmittedAt()%>

					</div>

					<%
					} else {
					%>

					<form action="${pageContext.request.contextPath}/submitActivity"
						method="post" class="d-flex flex-column gap-3">

						<input type="hidden" name="slotNumber" value="3"> <input
							type="hidden" name="startTime" value="16:00"> <input
							type="hidden" name="endTime" value="18:00"> <input
							type="hidden" name="category" value="Development">

						<textarea name="workDescription"
							class="form-control slot-textarea p-3" rows="4" maxlength="500"
							required placeholder="What did you work on during this time?"></textarea>

						<div class="slot-action-bar">

							<button type="submit" class="btn btn-submit-activity"
								id="submitRecord">

								<span class="material-symbols-outlined fs-16"> send </span>

								Submit Activity

							</button>

						</div>

					</form>

					<%
					}
					%>

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
<script src="${pageContext.request.contextPath}/js/auth.js"></script>
</style>
</body>
</html>