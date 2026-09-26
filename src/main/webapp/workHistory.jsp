<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.sql.Date"%>
<%@ page import="model.ActivityRecord"%>

<%
Map<Date, List<ActivityRecord>> groupedRecords = (Map<Date, List<ActivityRecord>>) request
		.getAttribute("groupedRecords");

if (groupedRecords == null) {
	groupedRecords = new java.util.LinkedHashMap<>();
}

Long totalWorkDays = (Long) request.getAttribute("totalWorkDays");

Integer totalSlots = (Integer) request.getAttribute("totalSlots");

Integer completedSlots = (Integer) request.getAttribute("completedSlots");

if (totalWorkDays == null) {
	totalWorkDays = 0L;
}

if (totalSlots == null) {
	totalSlots = 0;
}

if (completedSlots == null) {
	completedSlots = 0;
}

/*
 * ============================
 * PAGINATION VALUES
 * ============================
 */

Integer currentPageObj = (Integer) request.getAttribute("currentPage");

Integer pageSizeObj = (Integer) request.getAttribute("pageSize");

Integer totalPagesObj = (Integer) request.getAttribute("totalPages");

Integer totalRecordsObj = (Integer) request.getAttribute("totalRecords");

int currentPage = currentPageObj != null ? currentPageObj : 1;

int pageSize = pageSizeObj != null ? pageSizeObj : 5;

int totalPages = totalPagesObj != null ? totalPagesObj : 1;

int totalRecords = totalRecordsObj != null ? totalRecordsObj : 0;

int startRecord = totalRecords == 0 ? 0 : ((currentPage - 1) * pageSize) + 1;

int endRecord = Math.min(currentPage * pageSize, totalRecords);
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Work History</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/workHistory.css">

</head>


<body>


	<jsp:include page="/navbar.jsp" />

	<jsp:include page="/sidebar.jsp" />


	<main class="app-main">


		<!-- ========================= -->
		<!-- SUMMARY CARDS -->
		<!-- ========================= -->

		<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-3 mb-4">


			<!-- Total Work Days -->

			<div class="col">

				<div class="stat-card">

					<div class="d-flex flex-column gap-1">

						<span class="stat-label"> Total Work Days </span>

						<div class="d-flex align-items-baseline gap-1">

							<span class="stat-value"> <%=totalWorkDays%>
							</span> <span style="color: var(--on-surface-variant); font-size: 13px;">
								Days </span>

						</div>

						<span style="color: var(--outline); font-size: 12px;"> All
							recorded work days </span>

					</div>


					<span class="stat-icon-box"
						style="background: var(--secondary-fixed); color: var(--on-secondary-fixed);">

						<span class="material-symbols-outlined fs-20">
							calendar_month </span>

					</span>

				</div>

			</div>


			<!-- Slots Submitted -->

			<div class="col">

				<div class="stat-card">

					<div class="d-flex flex-column gap-1">

						<span class="stat-label"> Slots Submitted </span>

						<div class="d-flex align-items-baseline gap-1">

							<span class="stat-value"> <%=totalSlots%>
							</span> <span style="color: var(--on-surface-variant); font-size: 13px;">
								Slots </span>

						</div>

						<span class="d-flex align-items-center gap-1"
							style="color: var(--secondary); font-size: 12px;"> <span
							class="material-symbols-outlined" style="font-size: 14px;">
								fact_check </span> Activity entries submitted

						</span>

					</div>


					<span class="stat-icon-box"
						style="background: var(--primary-fixed); color: var(--on-primary-fixed);">

						<span class="material-symbols-outlined fs-20"> fact_check </span>

					</span>

				</div>

			</div>


			<!-- Recorded Slots -->

			<div class="col">

				<div class="stat-card">

					<div class="d-flex flex-column gap-1">

						<span class="stat-label"> Recorded Slots </span>

						<div class="d-flex align-items-baseline gap-1">

							<span class="stat-value"> <%=completedSlots%>
							</span> <span style="color: var(--on-surface-variant); font-size: 13px;">
								Slots </span>

						</div>

						<span style="color: var(--outline); font-size: 12px;">
							Successfully recorded </span>

					</div>


					<span class="stat-icon-box"
						style="background: var(--surface-container-high); color: var(--primary);">

						<span class="material-symbols-outlined fs-20"> check_circle
					</span>

					</span>

				</div>

			</div>


			<!-- Current Period -->

			<div class="col">

				<div class="stat-card">

					<div class="d-flex flex-column gap-1">

						<span class="stat-label"> Slots Missed </span> <span
							class="stat-value" style="font-size: 20px;">0
						</span> <span style="color: var(--outline); font-size: 12px;">
							Page <%=currentPage%> of <%=totalPages%>
						</span>

					</div>


					<span class="stat-icon-box"
						style="background: var(--surface-container-high); color: var(--on-surface-variant);">

						<span class="material-symbols-outlined fs-20"> date_range </span>

					</span>

				</div>

			</div>

		</div>


		<!-- ========================= -->
		<!-- FILTER TOOLBAR -->
		<!-- ========================= -->

		<div class="card-surface p-3 mb-4">

			<div
				class="d-flex flex-column flex-xl-row justify-content-between gap-3">


				<form class="row g-2 flex-grow-1" id="filterForm"
					onsubmit="event.preventDefault();">


					<!-- Search -->

					<div class="col-12 col-sm-6 col-md-4 col-lg-2dot4"
						style="flex: 1 1 220px;">

						<div class="filter-icon-wrap">

							<span class="material-symbols-outlined leading"> search </span> <input
								type="text" id="searchInput"
								class="form-control filter-input with-icon"
								placeholder="Search work description...">

						</div>

					</div>


					<!-- Start Date -->

					<div style="flex: 1 1 150px;">

						<div class="filter-icon-wrap">

							<span class="material-symbols-outlined leading"
								style="font-size: 15px;"> event </span> <input type="text"
								id="startDate" class="form-control filter-input with-icon"
								placeholder="Start date">

						</div>

					</div>


					<!-- End Date -->

					<div style="flex: 1 1 150px;">

						<div class="filter-icon-wrap">

							<span class="material-symbols-outlined leading"
								style="font-size: 15px;"> event </span> <input type="text"
								id="endDate" class="form-control filter-input with-icon"
								placeholder="End date">

						</div>

					</div>


					<!-- Slot -->

					<div style="flex: 1 1 170px;">

						<select class="form-select filter-select" id="slotFilter">

							<option value="all">All Slots</option>

							<option value="1">Slot 1 (10 AM - 12 PM)</option>

							<option value="2">Slot 2 (12 PM - 02 PM)</option>

							<option value="3">Slot 3 (02 PM - 04 PM)</option>

						</select>

					</div>


					<!-- Category -->

					<div style="flex: 1 1 170px;">

						<select class="form-select filter-select" id="categoryFilter">

							<option value="all">All Categories</option>

							<option value="Development">Development</option>

							<option value="Testing">Testing</option>

							<option value="Meeting">Meeting</option>

							<option value="Documentation">Documentation</option>

							<option value="Training">Training</option>

							<option value="Support">Support</option>

							<option value="Other">Other</option>

						</select>

					</div>

				</form>


				<!-- Filter Buttons -->

				<div
					class="d-flex align-items-center gap-2 align-self-end align-self-xl-center">

					<button class="btn btn-primary-soft" style="height: 36px;"
						type="button" id="applyFiltersBtn">Apply</button>


					<button class="btn btn-soft"
						style="height: 36px; box-shadow: none; background: none;"
						type="button" id="clearFiltersBtn">Clear</button>

				</div>

			</div>


			<!-- Status Legend -->

			<div class="status-legend mt-3">

				<span
					style="color: var(--outline); font-size: 11px; text-transform: uppercase; letter-spacing: .04em;">

					Status Index: </span>


				<div class="d-flex flex-wrap gap-3">

					<span class="legend-item"> <span class="legend-dot"
						style="background: var(--secondary);"> </span> Completed

					</span> <span class="legend-item"> <span class="legend-dot"
						style="background: var(--error);"> </span> Not Submitted

					</span>

				</div>

			</div>

		</div>


		<!-- ========================= -->
		<!-- WORK HISTORY -->
		<!-- ========================= -->

		<div class="d-flex flex-column gap-4 mb-4" id="workHistoryContainer">


			<%
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd MMM yyyy");

			java.text.SimpleDateFormat dayFormat = new java.text.SimpleDateFormat("EEEE");

			java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("hh:mm a");

			for (Map.Entry<Date, List<ActivityRecord>> entry : groupedRecords.entrySet()) {

				Date activityDate = entry.getKey();

				List<ActivityRecord> dayRecords = entry.getValue();

				int recordedSlots = dayRecords.size();

				int totalDayMinutes = 0;

				for (ActivityRecord r : dayRecords) {

					if (r.getStartTime() != null && r.getEndTime() != null) {

				long diff = r.getEndTime().getTime() - r.getStartTime().getTime();

				totalDayMinutes += (int) (diff / (1000 * 60));
					}
				}

				int hours = totalDayMinutes / 60;

				int minutes = totalDayMinutes % 60;
			%>


			<!-- DATE GROUP -->

			<article class="card-surface overflow-hidden"
				data-date="<%=activityDate%>">


				<!-- Date Header -->

				<div class="date-group-header">

					<div class="d-flex align-items-center gap-2 flex-wrap">

						<span class="h6 mb-0 fw-bold"> <%=dateFormat.format(activityDate)%>

						</span> <span class="date-badge"> <%=dayFormat.format(activityDate)%>

						</span>

					</div>


					<%
					if (recordedSlots == 3) {
					%>


					<span class="day-summary-pill"> <span
						class="material-symbols-outlined fs-16"> check_circle </span> 3/3
						Slots Recorded (<%=hours%>h <%=String.format("%02d", minutes)%>m)

					</span>


					<%
					} else {
					%>


					<span class="day-summary-pill warning"> <span
						class="material-symbols-outlined fs-16"> warning </span> <%=recordedSlots%>/3
						Slots Recorded (<%=hours%>h <%=String.format("%02d", minutes)%>m)

					</span>


					<%
					}
					%>

				</div>


				<!-- SLOTS -->

				<div class="p-3 d-flex flex-column gap-2">


					<%
					for (int slotNumber = 1; slotNumber <= 3; slotNumber++) {

						ActivityRecord slotRecord = null;

						for (ActivityRecord r : dayRecords) {

							if (r.getSlotNumber() == slotNumber) {

						slotRecord = r;

						break;
							}
						}

						/*
						 * SLOT NOT SUBMITTED
						 */

						if (slotRecord == null) {
					%>


					<div
						class="slot-row empty-slot flex-lg-row lg-align-items-center justify-content-between">


						<div class="d-flex align-items-start gap-3 flex-grow-1">


							<div class="slot-time-box">

								<span class="slot-time-label error-label"> Slot <%=slotNumber%>

								</span> <span class="slot-time-range"> <%
 if (slotNumber == 1) {
 %> 10 AM - 12 PM <%
 } else if (slotNumber == 2) {
 %> 12 PM - 02 PM <%
 } else {
 %> 02 PM - 04 PM <%
 }
 %>

								</span>

							</div>


							<div class="d-flex flex-column gap-1">

								<div class="d-flex flex-wrap align-items-center gap-2">

									<span class="status-not-submitted"> <span
										class="material-symbols-outlined" style="font-size: 13px;">
											error </span> Not Submitted

									</span> <span class="category-pill unassigned"> Unassigned </span>

								</div>


								<p class="mb-0 fw-medium" style="color: var(--error);">No
									work activity was recorded for this slot.</p>

							</div>

						</div>

					</div>


					<%
					} else {

					/*
					 * SLOT SUBMITTED
					 */

					String slotStart = "-";
					String slotEnd = "-";
					String submittedTime = "-";

					if (slotRecord.getStartTime() != null) {

						slotStart = timeFormat.format(slotRecord.getStartTime());
					}

					if (slotRecord.getEndTime() != null) {

						slotEnd = timeFormat.format(slotRecord.getEndTime());
					}

					if (slotRecord.getSubmittedAt() != null) {

						submittedTime = timeFormat.format(slotRecord.getSubmittedAt());
					}

					int slotMinutes = 0;

					if (slotRecord.getStartTime() != null && slotRecord.getEndTime() != null) {

						long diff = slotRecord.getEndTime().getTime() - slotRecord.getStartTime().getTime();

						slotMinutes = (int) (diff / (1000 * 60));
					}

					int slotHours = slotMinutes / 60;

					int remainingMinutes = slotMinutes % 60;

					String category = slotRecord.getCategory();

					if (category == null || category.trim().isEmpty()) {

						category = "Unassigned";
					}

					String description = slotRecord.getWorkDescription();

					if (description == null || description.trim().isEmpty()) {

						description = "No description provided.";
					}
					%>


					<!-- Submitted Slot -->

					<div
						class="slot-row flex-lg-row lg-align-items-center justify-content-between"
						data-slot="<%=slotNumber%>" data-category="<%=category%>"
						data-description="<%=description.toLowerCase()%>"
						data-date="<%=activityDate%>">


						<div class="d-flex align-items-start gap-3 flex-grow-1">


							<!-- Slot Time -->

							<div class="slot-time-box">

								<span class="slot-time-label"> Slot <%=slotRecord.getSlotNumber()%>

								</span> <span class="slot-time-range"> <%=slotStart%> - <%=slotEnd%>

								</span>

							</div>


							<!-- Work Details -->

							<div class="d-flex flex-column gap-1">


								<div class="d-flex flex-wrap align-items-center gap-2">


									<span class="status-completed"> <span
										class="material-symbols-outlined" style="font-size: 13px;">
											check </span> Completed

									</span> <span class="category-pill"> <%=category%>

									</span> <span style="color: var(--outline); font-size: 12px;">

										• Submitted <%=submittedTime%>

									</span>

								</div>


								<p class="mb-0">

									<%=description%>

								</p>

							</div>

						</div>


						<!-- Duration -->

						<div class="d-flex align-items-center gap-2 align-self-end">


							<span
								style="color: var(--on-surface-variant); font-variant-numeric: tabular-nums;">

								<%=slotHours%>h <%=String.format("%02d", remainingMinutes)%>m

							</span>


							<button class="btn-view-details" title="View Details"
								type="button">

								<span class="material-symbols-outlined fs-18">

									open_in_new </span>

							</button>

						</div>

					</div>


					<%
					}

					}
					%>

				</div>

			</article>


			<%
			}

			/*
			 * NO RECORDS
			 */

			if (groupedRecords.isEmpty()) {
			%>


			<div class="card-surface p-4 text-center">

				<span class="material-symbols-outlined" style="font-size: 40px;">

					history </span>


				<h5 class="mt-2">No Work History</h5>


				<p class="mb-0" style="color: var(--on-surface-variant);">No
					activity records have been submitted yet.</p>

			</div>


			<%
			}
			%>

		</div>


		<!-- ========================= -->
		<!-- PAGINATION -->
		<!-- ========================= -->

		<footer
			class="card-surface p-3 d-flex flex-column flex-sm-row align-items-center justify-content-between gap-3">


			<!-- Result Information -->

			<div style="color: var(--on-surface-variant); font-size: 13px;">

				Showing <span class="fw-semibold" style="color: var(--on-surface);">

					<%=startRecord%>–<%=endRecord%>

				</span> of <span class="fw-semibold" style="color: var(--on-surface);">

					<%=totalRecords%>

				</span> work days

			</div>


			<!-- Pagination -->

			<nav aria-label="Pagination" class="d-flex align-items-center gap-1">


				<!-- Previous -->

				<%
				if (currentPage > 1) {
				%>


				<a class="page-btn"
					href="${pageContext.request.contextPath}/workHistory?page=<%=currentPage - 1%>">

					<span class="material-symbols-outlined fs-18"> chevron_left
				</span>

				</a>


				<%
				} else {
				%>


				<button class="page-btn" disabled type="button">

					<span class="material-symbols-outlined fs-18"> chevron_left
					</span>

				</button>


				<%
				}
				%>


				<!-- Page Numbers -->

				<%
				int startPage = Math.max(1, currentPage - 2);

				int endPage = Math.min(totalPages, startPage + 4);

				if (endPage - startPage < 4) {

					startPage = Math.max(1, endPage - 4);
				}

				for (int pageNumber = startPage; pageNumber <= endPage; pageNumber++) {
				%>


				<a class="page-btn <%=pageNumber == currentPage ? "active" : ""%>"
					href="${pageContext.request.contextPath}/workHistory?page=<%=pageNumber%>">

					<%=pageNumber%>

				</a>


				<%
				}
				%>


				<!-- Next -->

				<%
				if (currentPage < totalPages) {
				%>


				<a class="page-btn"
					href="${pageContext.request.contextPath}/workHistory?page=<%=currentPage + 1%>">

					<span class="material-symbols-outlined fs-18"> chevron_right
				</span>

				</a>


				<%
				} else {
				%>


				<button class="page-btn" disabled type="button">

					<span class="material-symbols-outlined fs-18"> chevron_right
					</span>

				</button>


				<%
				}
				%>

			</nav>

		</footer>


	</main>


	<!-- External JavaScript -->

	<script src="${pageContext.request.contextPath}/js/workHistory.js">
		
	</script>


</body>

</html>