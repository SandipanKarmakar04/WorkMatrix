console.log("dashboard.js loaded");

(function() {

	// =========================================
	// LOCAL DATE & GREETING
	// =========================================

	function showLocalDateTime() {

		const today = new Date();

		const options = {
			weekday: "long",
			day: "2-digit",
			month: "long",
			year: "numeric"
		};

		const dateElement = document.getElementById("localDateTime");

		if (dateElement) {
			dateElement.textContent =
				today.toLocaleDateString("en-GB", options);
		}
	}

	showLocalDateTime();


	const currentHour = new Date().getHours();

	let greeting;

	if (currentHour < 12) {
		greeting = "Good Morning";
	} else if (currentHour < 17) {
		greeting = "Good Afternoon";
	} else {
		greeting = "Good Evening";
	}

	const greetName = document.getElementById("greetName");

	if (greetName) {

		const employeeName =
			greetName.textContent.trim();

		greetName.textContent =
			`${greeting}, ${employeeName}`;
	}


	// =========================================
	// CHECK IN
	// =========================================

	window.handleCheckIn = function() {

		fetch(window.contextPath + "/checkin", {
			method: "POST"
		})

			.then(response => {

				if (!response.ok) {

					return response.text().then(message => {
						throw new Error(message);
					});
				}

				return response.text();
			})

			.then(checkInTime => {

				alert("Check-in successful at " + checkInTime);

				location.reload();
			})

			.catch(error => {

				console.error("Check-in error:", error);

				alert(
					error.message ||
					"Unable to check in."
				);
			});
	};


	// =========================================
	// CHECK OUT
	// =========================================

	window.handleCheckOut = function() {

		fetch(window.contextPath + "/checkout", {
			method: "POST"
		})

			.then(response => {

				if (!response.ok) {

					return response.text().then(message => {
						throw new Error(message);
					});
				}

				return response.text();
			})

			.then(checkOutTime => {

				alert("Check-out successful at " + checkOutTime);

				location.reload();
			})

			.catch(error => {

				console.error("Check-out error:", error);

				alert(
					error.message ||
					"Unable to check out."
				);
			});
	};


	// =========================================
	// TIME FORMAT
	// =========================================

	function formatTime(time) {

		const parts = time.split(":");

		let hours = parseInt(parts[0]);

		const minutes = parts[1];

		const ampm = hours >= 12 ? "PM" : "AM";

		hours = hours % 12;

		if (hours === 0) {
			hours = 12;
		}

		return `${String(hours).padStart(2, "0")}:${minutes} ${ampm}`;
	}


	// =========================================
	// TIMESHEET SUBMIT
	// =========================================

	const ackCheck =
		document.getElementById("employeeAckCheckbox");

	const submitBtn =
		document.getElementById("submitToManagerBtn");

	const topSubmitBtn =
		document.getElementById("topSubmitBtn");


	if (ackCheck && submitBtn) {

		ackCheck.addEventListener("change", function() {

			submitBtn.disabled = !this.checked;
		});


		submitBtn.addEventListener("click", function() {

			if (!ackCheck.checked) {
				return;
			}

			submitBtn.innerHTML =
				'<span class="material-symbols-outlined fs-18">progress_activity</span> Submitting...';


			setTimeout(function() {

				alert(
					"Timesheet successfully submitted to Marcus Vance."
				);

				submitBtn.innerHTML =
					'<span class="material-symbols-outlined fs-18">done</span> Submitted';

				submitBtn.style.background =
					"var(--secondary)";

			}, 600);
		});
	}


	if (topSubmitBtn && ackCheck && submitBtn) {

		topSubmitBtn.addEventListener("click", function() {

			ackCheck.checked = true;

			submitBtn.disabled = false;

			ackCheck.scrollIntoView({
				behavior: "smooth",
				block: "center"
			});
		});
	}


	// =========================================
	// DETAIL MODAL
	// =========================================

	const modal =
		document.getElementById("detailModal");

	const modalDayTitle =
		document.getElementById("modalDayTitle");

	const modalInTime =
		document.getElementById("modalInTime");

	const modalOutTime =
		document.getElementById("modalOutTime");

	const modalDuration =
		document.getElementById("modalDuration");

	const modalDesc =
		document.getElementById("modalDesc");

	const closeModalBtn =
		document.getElementById("closeModalBtn");

	const modalOkBtn =
		document.getElementById("modalOkBtn");


	function closeModal() {

		if (modal) {
			modal.classList.remove("show");
		}
	}


	if (closeModalBtn) {
		closeModalBtn.addEventListener(
			"click",
			closeModal
		);
	}


	if (modalOkBtn) {
		modalOkBtn.addEventListener(
			"click",
			closeModal
		);
	}


	document
		.querySelectorAll(".view-detail-btn")
		.forEach(btn => {

			btn.addEventListener("click", function() {

				if (modalDayTitle) {
					modalDayTitle.textContent =
						this.dataset.day ||
						"Work Log Details";
				}

				if (modalInTime) {
					modalInTime.textContent =
						this.dataset.in || "--";
				}

				if (modalOutTime) {
					modalOutTime.textContent =
						this.dataset.out || "--";
				}

				if (modalDuration) {
					modalDuration.textContent =
						this.dataset.hours || "--";
				}

				if (modalDesc) {
					modalDesc.textContent =
						this.dataset.desc || "--";
				}

				if (modal) {
					modal.classList.add("show");
				}
			});
		});


	// =========================================
	// CSV EXPORT
	// =========================================

	const exportCsvBtn =
		document.getElementById("exportCsvBtn");


	if (exportCsvBtn) {

		exportCsvBtn.addEventListener(
			"click",
			function() {

				const rows = [

					[
						"Date",
						"Day",
						"Check In",
						"Check Out",
						"Duration",
						"Status",
						"Description"
					],

					[
						"14-Sep-2026",
						"Monday",
						"09:15 AM",
						"06:05 PM",
						"8h 50m",
						"Present",
						"Setup MySQL local replica, handled user auth bugs"
					],

					[
						"15-Sep-2026",
						"Tuesday",
						"09:20 AM",
						"06:00 PM",
						"8h 40m",
						"Present",
						"Developed REST endpoints for timesheet servlet"
					],

					[
						"16-Sep-2026",
						"Wednesday",
						"09:00 AM",
						"06:00 PM",
						"9h 00m",
						"Present",
						"Code review, unit testing for JDBC transaction handlers"
					],

					[
						"17-Sep-2026",
						"Thursday",
						"09:35 AM",
						"06:07 PM",
						"8h 32m",
						"Late",
						"Fixed frontend form validation and session timeout"
					],

					[
						"18-Sep-2026",
						"Friday",
						"09:32 AM",
						"06:15 PM",
						"8h 43m",
						"Present",
						"Fixed teacher registration issue, finalized weekly report"
					]
				];


				let csvContent =
					"data:text/csv;charset=utf-8," +
					rows
						.map(row =>
							row
								.map(item => `"${item}"`)
								.join(",")
						)
						.join("\n");


				const encodedUri =
					encodeURI(csvContent);

				const link =
					document.createElement("a");

				link.setAttribute(
					"href",
					encodedUri
				);

				link.setAttribute(
					"download",
					"timesheet_week_38_2026.csv"
				);

				document.body.appendChild(link);

				link.click();

				document.body.removeChild(link);
			}
		);
	}

})();


// =========================================
// DAILY WORK DESCRIPTION
// =========================================

function saveSummary() {

    console.log("SAVE SUMMARY CLICKED");

    const display =
        document.getElementById("work-summary-display");

    const textarea =
        document.getElementById("work-summary-textarea");

    const statusTag =
        document.getElementById("save-status-tag");

    if (!textarea || !display) {
        console.error("Work summary elements not found.");
        return;
    }

    const workDescription =
        textarea.value.trim();

    if (!workDescription) {
        alert("Please enter your work description.");
        textarea.focus();
        return;
    }

    fetch(window.contextPath + "/dailyWork", {
        method: "POST",
        headers: {
            "Content-Type":
                "application/x-www-form-urlencoded"
        },
        body:
            "workDescription=" +
            encodeURIComponent(workDescription)
    })
    .then(response => {

        console.log(
            "Daily work response:",
            response.status
        );

        if (response.ok) {

            // Show saved description
            display.textContent = workDescription;

            // Hide textarea
            textarea.style.display = "none";

            // Show description
            display.style.display = "block";

            // Update save status
            if (statusTag) {
				const now = new Date();

				const time = now.toLocaleTimeString([], {
				    hour: "2-digit",
				    minute: "2-digit"
				});

				statusTag.innerHTML = `
				    <span class="material-symbols-outlined"
				        style="font-size: 16px; color: #059669;">
				        cloud_done
				    </span>
				    Last saved at ${time}
				`;
            }

            // SUCCESS ALERT
            alert("Work description saved successfully!");

        } else if (response.status === 401) {

            alert("Your session has expired. Please login again.");

        } else if (response.status === 400) {

            alert("Please enter a valid work description.");

        } else {

            alert("Failed to save work description.");
        }
    })
    .catch(error => {

        console.error("Error saving work:", error);

        alert("Unable to connect to the server.");
    });
}


// =========================================
// EDIT DAILY WORK DESCRIPTION
// =========================================
function focusSummary() {
    const display = document.getElementById("work-summary-display");
    const textarea = document.getElementById("work-summary-textarea");

    if (!display || !textarea) {
        return;
    }

    const placeholder = document.getElementById("work-summary-placeholder");

    if (placeholder) {
        textarea.value = "";
    } else {
        textarea.value = display.textContent.trim();
    }

    display.style.display = "none";
    textarea.style.display = "block";
    textarea.focus();
}

document.addEventListener("click", function (event) {

    const textarea =
        document.getElementById("work-summary-textarea");

    const display =
        document.getElementById("work-summary-display");

    const editButton =
        document.getElementById("edit-summary-btn");

    const saveButton =
        document.getElementById("save-summary-btn");

    if (!textarea || !display) {
        return;
    }

    // Textarea is not currently active
    if (textarea.style.display === "none") {
        return;
    }

    const clickedInsideTextarea =
        textarea.contains(event.target);

    const clickedEditButton =
        editButton && editButton.contains(event.target);

    const clickedSaveButton =
        saveButton && saveButton.contains(event.target);

    // Click happened outside everything related to editing
    if (
        !clickedInsideTextarea &&
        !clickedEditButton &&
        !clickedSaveButton
    ) {
        textarea.style.display = "none";
        display.style.display = "block";
    }
});

// =========================================
// LEAVE REQUEST
// =========================================

function focusLeaveReason() {

    const display =
        document.getElementById("leave-reason-display");

    const textarea =
        document.getElementById("leave-reason-textarea");

    if (!display || !textarea) {
        return;
    }

    const placeholder =
        document.getElementById("leave-reason-placeholder");

    if (placeholder) {
        textarea.value = "";
    } else {
        textarea.value = display.textContent.trim();
    }

    display.style.display = "none";
    textarea.style.display = "block";

    textarea.focus();
}


// =========================================
// SUBMIT LEAVE REQUEST
// =========================================

function submitLeaveRequest() {

    const textarea =
        document.getElementById("leave-reason-textarea");

    const display =
        document.getElementById("leave-reason-display");

    const statusTag =
        document.getElementById("leave-status-tag");

    if (!textarea || !display) {
        return;
    }

    const reason =
        textarea.value.trim();

    if (!reason) {
        alert("Please enter the reason for your leave.");
        textarea.focus();
        return;
    }

    // For now, just display the submitted reason
    display.textContent = reason;

    textarea.style.display = "none";
    display.style.display = "block";

    if (statusTag) {

        statusTag.innerHTML = `
            <span
                class="material-symbols-outlined"
                style="font-size: 16px; color: #059669;">
                check_circle
            </span>
            Request submitted
        `;
    }

    alert("Leave request submitted successfully!");
}

// =========================================
// LEAVE REQUEST OUTSIDE CLICK
// =========================================

// =========================================
// LEAVE REQUEST OUTSIDE CLICK
// =========================================

document.addEventListener("click", function (event) {

    const textarea =
        document.getElementById("leave-reason-textarea");

    const display =
        document.getElementById("leave-reason-display");

    const editButton =
        document.getElementById("edit-leave-btn");

    const submitButton =
        document.getElementById("submit-leave-btn");

    if (!textarea || !display) {
        return;
    }

    // Textarea is not currently active
    if (textarea.style.display === "none") {
        return;
    }

    const clickedInsideTextarea =
        textarea.contains(event.target);

    const clickedEditButton =
        editButton && editButton.contains(event.target);

    const clickedSubmitButton =
        submitButton && submitButton.contains(event.target);

    // Clicked outside
    if (
        !clickedInsideTextarea &&
        !clickedEditButton &&
        !clickedSubmitButton
    ) {
        textarea.style.display = "none";
        display.style.display = "block";

        // IMPORTANT:
        // Do NOT clear textarea.value
    }
});

window.addEventListener("pageshow", function (event) {

    if (event.persisted) {
        window.location.reload();
    }

});