(function() {
	// Checkbox toggles submit button
	const ackCheck = document.getElementById('employeeAckCheckbox');
	const submitBtn = document.getElementById('submitToManagerBtn');
	const topSubmitBtn = document.getElementById('topSubmitBtn');

	function showLocalDateTime() {
		const today = new Date();
		const options = {
			weekday: "long",
			day: "2-digit",
			month: "long",
			year: "numeric"
		};

		document.getElementById("localDateTime").textContent =
			today.toLocaleDateString("en-GB", options);
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
		greetName.textContent =
			`${greeting}, ${greetName.textContent.trim()}`;
	}

	// -------CHECK IN--------	

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
				alert(error.message || "Unable to check in.");
			});
	}
	
	
	// -------CHECK OUT--------

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


	//-----------------------------------------------

	if (ackCheck && submitBtn) {
		ackCheck.addEventListener('change', function() {
			submitBtn.disabled = !this.checked;
		});

		submitBtn.addEventListener('click', function() {
			if (!ackCheck.checked) return;
			submitBtn.innerHTML = '<span class="material-symbols-outlined fs-18">progress_activity</span> Submitting...';
			setTimeout(() => {
				alert('Timesheet for Week 38 successfully submitted to Marcus Vance.');
				submitBtn.innerHTML = '<span class="material-symbols-outlined fs-18">done</span> Submitted';
				submitBtn.style.background = 'var(--secondary)';
			}, 600);
		});
	}

	if (topSubmitBtn && ackCheck) {
		topSubmitBtn.addEventListener('click', function() {
			ackCheck.checked = true;
			submitBtn.disabled = false;
			ackCheck.scrollIntoView({ behavior: 'smooth', block: 'center' });
		});
	}

	// Modal interaction
	const modal = document.getElementById('detailModal');
	const modalDayTitle = document.getElementById('modalDayTitle');
	const modalInTime = document.getElementById('modalInTime');
	const modalOutTime = document.getElementById('modalOutTime');
	const modalDuration = document.getElementById('modalDuration');
	const modalDesc = document.getElementById('modalDesc');
	const closeModalBtn = document.getElementById('closeModalBtn');
	const modalOkBtn = document.getElementById('modalOkBtn');

	function closeModal() { modal.classList.remove('show'); }

	if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
	if (modalOkBtn) modalOkBtn.addEventListener('click', closeModal);

	document.querySelectorAll('.view-detail-btn').forEach(btn => {
		btn.addEventListener('click', function() {
			modalDayTitle.textContent = this.dataset.day || 'Work Log Details';
			modalInTime.textContent = this.dataset.in || '--';
			modalOutTime.textContent = this.dataset.out || '--';
			modalDuration.textContent = this.dataset.hours || '--';
			modalDesc.textContent = this.dataset.desc || '--';
			modal.classList.add('show');
		});
	});

	// CSV export
	const exportCsvBtn = document.getElementById('exportCsvBtn');
	if (exportCsvBtn) {
		exportCsvBtn.addEventListener('click', function() {
			const rows = [
				["Date", "Day", "Check In", "Check Out", "Duration", "Status", "Description"],
				["14-Sep-2026", "Monday", "09:15 AM", "06:05 PM", "8h 50m", "Present", "Setup MySQL local replica, handled user auth bugs"],
				["15-Sep-2026", "Tuesday", "09:20 AM", "06:00 PM", "8h 40m", "Present", "Developed REST endpoints for timesheet servlet"],
				["16-Sep-2026", "Wednesday", "09:00 AM", "06:00 PM", "9h 00m", "Present", "Code review, unit testing for JDBC transaction handlers"],
				["17-Sep-2026", "Thursday", "09:35 AM", "06:07 PM", "8h 32m", "Late", "Fixed frontend form validation and session timeout"],
				["18-Sep-2026", "Friday", "09:32 AM", "06:15 PM", "8h 43m", "Present", "Fixed teacher registration issue, finalized weekly report"]
			];

			let csvContent = "data:text/csv;charset=utf-8," + rows.map(e => e.map(i => '"' + i + '"').join(",")).join("\n");
			const encodedUri = encodeURI(csvContent);
			const link = document.createElement("a");
			link.setAttribute("href", encodedUri);
			link.setAttribute("download", "timesheet_week_38_2026.csv");
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
		});
	}
})();
