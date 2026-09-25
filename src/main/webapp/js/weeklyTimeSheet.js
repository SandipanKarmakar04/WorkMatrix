document.addEventListener("DOMContentLoaded", function() {

	/* =========================
	   TABLE SEARCH
	   ========================= */

	const searchInput = document.getElementById("timesheetSearch");
	const clearButton = document.getElementById("clearTimesheetSearch");
	const table = document.getElementById("timesheetTable");

	console.log("Search input:", searchInput);
	console.log("Clear button:", clearButton);
	console.log("Table:", table);

	if (!searchInput || !table) {
		console.log("Search elements not found.");
		return;
	}

	const tbody = table.querySelector("tbody");

	searchInput.addEventListener("input", function() {

		const searchValue = searchInput.value
			.toLowerCase()
			.trim();

		const rows = tbody.querySelectorAll("tr");

		rows.forEach(function(row) {

			const rowText = row.textContent
				.toLowerCase()
				.trim();

			if (searchValue === "" || rowText.includes(searchValue)) {
				row.style.display = "";
			} else {
				row.style.display = "none";
			}

		});

	});


	/* =========================
	   CLEAR SEARCH
	   ========================= */

	if (clearButton) {

		clearButton.addEventListener("click", function() {

			searchInput.value = "";

			const rows = tbody.querySelectorAll("tr");

			rows.forEach(function(row) {
				row.style.display = "";
			});

			searchInput.focus();

		});

	}


	/* =========================
	   CSV EXPORT
	   ========================= */

	const exportCsvBtn = document.getElementById("exportCsvBtn");

	if (exportCsvBtn) {

		exportCsvBtn.addEventListener("click", function() {

			const table = document.getElementById("timesheetTable");

			if (!table) {
				alert("Timesheet table not found.");
				return;
			}

			let csv = [];

			/* HEADER */

			const headerRow = table.querySelector("thead tr");

			if (headerRow) {

				const headers = headerRow.querySelectorAll("th");
				let headerData = [];

				headers.forEach(function(header) {

					let text = header.textContent
						.replace(/\s+/g, " ")
						.replace(/"/g, '""')
						.trim();

					headerData.push('"' + text + '"');

				});

				csv.push(headerData.join(","));
			}


			/* BODY */

			const rows = table.querySelectorAll("tbody tr");

			rows.forEach(function(row) {

				if (row.cells.length !== 8) {
					return;
				}

				const cols = row.querySelectorAll("td");
				let rowData = [];

				cols.forEach(function(col) {

					let text = col.textContent
						.replace(/\s+/g, " ")
						.replace(/"/g, '""')
						.trim();

					rowData.push('"' + text + '"');

				});

				csv.push(rowData.join(","));

			});


			if (csv.length <= 1) {
				alert("There are no attendance records to export.");
				return;
			}


			const csvContent =
				"\ufeff" + csv.join("\r\n");

			const blob = new Blob(
				[csvContent],
				{
					type: "text/csv;charset=utf-8;"
				}
			);

			const url = URL.createObjectURL(blob);

			const link = document.createElement("a");

			link.href = url;
			link.download = "Weekly_Timesheet.csv";

			document.body.appendChild(link);

			link.click();

			document.body.removeChild(link);

			setTimeout(function() {
				URL.revokeObjectURL(url);
			}, 100);

		});

	}

});

/* =========================
   PAGINATION
   ========================= */

const paginationInfo = document.getElementById("paginationInfo");
const paginationNumbers = document.getElementById("paginationNumbers");
const prevPage = document.getElementById("prevPage");
const nextPage = document.getElementById("nextPage");

const table = document.getElementById("timesheetTable");

if (
	paginationInfo &&
	paginationNumbers &&
	prevPage &&
	nextPage &&
	table
) {

	const tbody = table.querySelector("tbody");

	const rows = Array.from(
		tbody.querySelectorAll("tr")
	);

	const rowsPerPage = 5;

	let currentPage = 1;

	let filteredRows = rows;


	function displayPage(page) {

		const totalPages = Math.ceil(
			filteredRows.length / rowsPerPage
		);

		if (totalPages === 0) {

			currentPage = 1;

			rows.forEach(function(row) {
				row.style.display = "none";
			});

			paginationInfo.textContent =
				"Showing 0–0 of 0 records";

			paginationNumbers.innerHTML = "";

			prevPage.disabled = true;
			nextPage.disabled = true;

			return;
		}


		if (page < 1) {
			page = 1;
		}

		if (page > totalPages) {
			page = totalPages;
		}

		currentPage = page;


		// Hide all rows first
		rows.forEach(function(row) {
			row.style.display = "none";
		});


		// Calculate range
		const startIndex =
			(currentPage - 1) * rowsPerPage;

		const endIndex =
			Math.min(
				startIndex + rowsPerPage,
				filteredRows.length
			);


		// Show current page rows
		for (
			let i = startIndex;
			i < endIndex;
			i++
		) {

			filteredRows[i].style.display = "";
		}


		// Update information
		paginationInfo.textContent =
			"Showing " +
			(startIndex + 1) +
			"–" +
			endIndex +
			" of " +
			filteredRows.length +
			" records";


		// Previous button
		prevPage.disabled =
			currentPage === 1;


		// Next button
		nextPage.disabled =
			currentPage === totalPages;


		// Generate page numbers
		createPaginationNumbers(totalPages);
	}


	function createPaginationNumbers(totalPages) {

		paginationNumbers.innerHTML = "";


		for (
			let page = 1;
			page <= totalPages;
			page++
		) {

			const button =
				document.createElement("button");

			button.type = "button";

			button.className =
				"pagination-number";

			button.textContent = page;


			if (page === currentPage) {
				button.classList.add("active");
			}


			button.addEventListener(
				"click",
				function() {

					displayPage(page);

				}
			);


			paginationNumbers.appendChild(button);
		}
	}


	prevPage.addEventListener(
		"click",
		function() {

			displayPage(currentPage - 1);

		}
	);


	nextPage.addEventListener(
		"click",
		function() {

			displayPage(currentPage + 1);

		}
	);


	/* =========================
	   SEARCH + PAGINATION
	   ========================= */

	const searchInput =
		document.getElementById("timesheetSearch");


	if (searchInput) {

		searchInput.addEventListener(
			"input",
			function() {

				const searchText =
					this.value
						.toLowerCase()
						.trim();


				filteredRows =
					rows.filter(function(row) {

						const rowText =
							row.textContent
								.toLowerCase();

						return rowText.includes(
							searchText
						);

					});


				currentPage = 1;

				displayPage(currentPage);

			}
		);
	}


	/* =========================
	   CLEAR SEARCH
	   ========================= */

	const clearButton =
		document.getElementById(
			"clearTimesheetSearch"
		);


	if (clearButton) {

		clearButton.addEventListener(
			"click",
			function() {

				if (searchInput) {
					searchInput.value = "";
				}

				filteredRows = rows;

				currentPage = 1;

				displayPage(currentPage);

				if (searchInput) {
					searchInput.focus();
				}

			}
		);
	}


	// Initial page
	displayPage(1);
}

window.addEventListener("pageshow", function(event) {

	if (event.persisted) {
		window.location.reload();
	}

});