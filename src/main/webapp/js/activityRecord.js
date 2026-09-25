// Sidebar active-route highlight (kept from original behavior)
document.addEventListener("DOMContentLoaded", () => {
	const links = document.querySelectorAll(".app-sidebar nav a");
	links.forEach(link => {
		// "Activity" is already marked active in the markup above.
	});
});

// Character counter for the active slot textarea
const textarea = document.getElementById('slot-activity-input');
const counter = document.getElementById('char-counter');
if (textarea && counter) {
	textarea.addEventListener('input', () => {
		const len = textarea.value.length;
		counter.textContent = `${len} / 500 characters`;
	});
}

// Tag selection toggle
document.querySelectorAll('.tag-btn').forEach(btn => {
	btn.addEventListener('click', function() {
		const selected = this.classList.contains('selected');
		this.classList.toggle('selected', !selected);
		this.classList.toggle('unselected', selected);
	});
});

window.addEventListener("pageshow", function(event) {

	if (event.persisted) {
		window.location.reload();
	}

});