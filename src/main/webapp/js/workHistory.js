document.addEventListener("DOMContentLoaded", function() {

	const searchInput =
		document.getElementById("searchInput");

	const slotFilter =
		document.getElementById("slotFilter");

	const categoryFilter =
		document.getElementById("categoryFilter");

	const applyFiltersBtn =
		document.getElementById("applyFiltersBtn");

	const clearFiltersBtn =
		document.getElementById("clearFiltersBtn");

	const workHistoryContainer =
		document.getElementById("workHistoryContainer");


	/*
	 * Apply Filters
	 */
	function applyFilters() {

		const searchText =
			searchInput.value.trim().toLowerCase();

		const selectedSlot =
			slotFilter.value;

		const selectedCategory =
			categoryFilter.value.toLowerCase();


		const rows =
			workHistoryContainer.querySelectorAll(
				".slot-row:not(.empty-slot)"
			);


		rows.forEach(function(row) {

			const description =
				row.dataset.description || "";

			const slot =
				row.dataset.slot || "";

			const category =
				(row.dataset.category || "").toLowerCase();


			const searchMatch =
				searchText === ""
				|| description.includes(searchText);


			const slotMatch =
				selectedSlot === "all"
				|| slot === selectedSlot;


			const categoryMatch =
				selectedCategory === "all"
				|| category === selectedCategory;


			if (
				searchMatch
				&& slotMatch
				&& categoryMatch
			) {

				row.style.display = "";

			} else {

				row.style.display = "none";

			}

		});

	}


	/*
	 * Apply button
	 */
	if (applyFiltersBtn) {

		applyFiltersBtn.addEventListener(
			"click",
			applyFilters
		);

	}


	/*
	 * Clear button
	 */
	if (clearFiltersBtn) {

		clearFiltersBtn.addEventListener(
			"click",
			function() {

				searchInput.value = "";

				document.getElementById("startDate").value = "";

				document.getElementById("endDate").value = "";

				slotFilter.value = "all";

				categoryFilter.value = "all";


				const rows =
					workHistoryContainer.querySelectorAll(
						".slot-row"
					);


				rows.forEach(function(row) {

					row.style.display = "";

				});

			}
		);

	}

});