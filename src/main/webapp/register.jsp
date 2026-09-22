<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>WorkMatrix | Employee Account Registration</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/register.css">

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

	<div class="d-flex flex-column align-items-center w-100">

		<!-- Top pill -->
		<div class="d-flex justify-content-center mb-4">
			<span class="top-pill"><span class="pill-dot"></span>PCS
				GLOBAL PVT. LTD. • Account Onboarding</span>
		</div>

		<div class="onboard-card">

			<!-- Brand & Header -->
			<div class="d-flex flex-column align-items-center text-center">
				<div class="mb-3">
					<h1 class="headline" style="color: rgb(0, 0, 65);">
						W<span style="color: rgb(0, 201, 154);">o</span>rk<span
							style="color: rgb(0, 201, 154);">Matrix</span>
					</h1>
				</div>
				<p class="subtext" style="font-size: small;">Create your corporate credentials to access
					timesheet logging and attendance tracking.</p>
			</div>

			<!-- Registration Form -->
			<form id="employeeRegisterForm" class="d-flex flex-column gap-4"
				method="post" action="${pageContext.request.contextPath}/register"
				novalidate>

				<!-- Section 1: Personal Information -->
				<div class="d-flex flex-column gap-3">
					<div class="section-title">
						
					</div>
					<div class="row g-3">
						<div class="col-12 col-sm-6">
							<label class="form-label-custom d-block mb-1" for="firstName">First
								Name <span class="required-mark">*</span>
							</label> <input type="text" id="firstName" name="firstName"
								class="form-control form-control-custom"
								placeholder="e.g. Alexander" required>
						</div>
						<div class="col-12 col-sm-6">
							<label class="form-label-custom d-block mb-1" for="lastName">Last
								Name <span class="required-mark">*</span>
							</label> <input type="text" id="lastName" name="lastName"
								class="form-control form-control-custom"
								placeholder="e.g. Vance" required>
						</div>
					</div>
					<div>
						<label class="form-label-custom d-block mb-1" for="corporateEmail">
							Email Address <span class="required-mark">*</span>
						</label>
						<div class="input-icon-wrap">
							<span class="material-symbols-outlined leading">mail</span> <input
								type="email" id="corporateEmail" name="corporateEmail"
								class="form-control form-control-custom with-icon"
								placeholder=" employee@gmail.com" required>
						</div>
					</div>

					<div>
						<label class="form-label-custom d-block mb-1" for="designation">
							Designation <span class="required-mark">*</span>
						</label> <select id="designation" name="designation"
							class="form-select form-select-custom designation" required>

							<option value="" selected disabled>Select Designation</option>

							<option value="Trainee Software Engineer">Trainee
								Software Engineer</option>

							<option value="Software Engineer">Software Engineer</option>

							<option value="Senior Software Engineer">Senior Software
								Engineer</option>

						</select>
					</div>

					<div>
						<label class="form-label-custom d-block mb-1" for="employeeId">Employee
							Identification (ID) <span class="required-mark">*</span>
						</label>
						<div class="input-icon-wrap">
							<span class="material-symbols-outlined leading">assignment_ind</span>
							<input type="text" id="employeeId" name="employeeId"
								class="form-control form-control-custom with-icon text-uppercase"
								placeholder=" EMP-0000" required>
						</div>
						<p class="helper-text mt-1">Provided in your formal offer
							letter or onboarding kit.</p>
					</div>
				</div>

				<!-- Section 2: Security & Credentials -->
				<div class="d-flex flex-column gap-3">
					<div class="section-title">
						<h2>Security &amp; Credentials</h2>
					</div>
					<div class="row g-3">
						<div class="col-12 col-sm-6">
							<label class="form-label-custom d-block mb-1" for="password">Account
								Password <span class="required-mark">*</span>
							</label>
							<div class="input-icon-wrap">
								<input type="password" id="password" name="password"
									class="form-control form-control-custom"
									placeholder="Minimum 8 characters" required
									autocomplete="new-password" style="padding-right: 40px;">
								<button type="button" class="pwd-toggle-btn"
									id="togglePasswordBtn" aria-label="Toggle password visibility">
									<span class="material-symbols-outlined">visibility</span>
								</button>
							</div>
						</div>
						<div class="col-12 col-sm-6">
							<label class="form-label-custom d-block mb-1"
								for="confirmPassword">Confirm Password <span
								class="required-mark">*</span></label> <input type="password"
								id="confirmPassword" name="confirmPassword"
								class="form-control form-control-custom"
								placeholder="Re-enter password" required
								autocomplete="new-password">
						</div>
					</div>

					<!-- Password strength panel: collapsed by default, expands on focus/typing -->
					<div class="strength-box" id="strengthBox">
						<div class="strength-box-inner">
							<div class="d-flex justify-content-between align-items-center">
								<span
									style="font-size: 12px; color: var(--on-surface-variant); font-weight: 500;">Password
									Strength Assessment</span> <span id="strengthText"
									style="font-size: 12px; font-weight: 600;">Requires 8+
									Chars</span>
							</div>
							<div class="strength-meter mt-2">
								<div class="seg" id="meter1"></div>
								<div class="seg" id="meter2"></div>
								<div class="seg" id="meter3"></div>
								<div class="seg" id="meter4"></div>
							</div>
							<div class="d-flex flex-wrap gap-3 mt-2">
								<span class="req-item" id="reqLength"><span
									class="material-symbols-outlined">radio_button_unchecked</span>
									8+ characters</span> <span class="req-item" id="reqUpper"><span
									class="material-symbols-outlined">radio_button_unchecked</span>
									uppercase</span> <span class="req-item" id="reqNumber"><span
									class="material-symbols-outlined">radio_button_unchecked</span>
									numeric</span> <span class="req-item" id="reqMatch"><span
									class="material-symbols-outlined">radio_button_unchecked</span>
									Passwords match</span>
							</div>
						</div>
					</div>

					<!-- Compliance agreement -->
					<label class="agree-label"> <input type="checkbox"
						id="policyAgreement" name="policyAgreement" required> <span>
							I agree to the <a href="#">Enterprise Acceptable Use Policy</a>
							and provide affirmative consent to Biometric &amp; Geolocation
							Attendance Logging as governed under corporate compliance
							ISO-9001.
					</span>
					</label>
				</div>

				<!-- Submit -->
				<div class="d-flex flex-column gap-3 pt-2">
					<button type="submit" class="btn-create">
						<span>Create Employee Account</span> <span
							class="material-symbols-outlined">arrow_forward</span>
					</button>
					<div class="d-flex align-items-center justify-content-center gap-1"
						style="font-size: 13px; color: var(--on-surface-variant);">
						<span>Already registered with WorkMatrix?</span> <a
							class="signin-link"
							href="${pageContext.request.contextPath}/login.jsp">Sign in
							to your account</a>
					</div>
				</div>
			</form>

		</div>

		<!-- Security & Environment Footer -->
		<div class="footer-block">
			<div class="footer-line">
				<span class="material-symbols-outlined">verified_user</span> <span>Protected
					by PCS Global Enterprise Security v2.4</span>
			</div>
			<p class="footer-sub">JSP-Servlet-MySQL Architecture Compatible
				&bull; TLS 1.3 Encrypted</p>
		</div>

	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		(function() {
			var passwordInput = document.getElementById('password');
			var confirmInput = document.getElementById('confirmPassword');
			var toggleBtn = document.getElementById('togglePasswordBtn');
			var strengthBox = document.getElementById('strengthBox');
			var strengthText = document.getElementById('strengthText');
			var meters = [ document.getElementById('meter1'),
					document.getElementById('meter2'),
					document.getElementById('meter3'),
					document.getElementById('meter4') ];

			var reqLength = document.getElementById('reqLength');
			var reqUpper = document.getElementById('reqUpper');
			var reqNumber = document.getElementById('reqNumber');
			var reqMatch = document.getElementById('reqMatch');

			// Password visibility toggle
			if (toggleBtn && passwordInput) {
				toggleBtn
						.addEventListener(
								'click',
								function() {
									var isPassword = passwordInput.type === 'password';
									passwordInput.type = isPassword ? 'text'
											: 'password';
									toggleBtn
											.querySelector('.material-symbols-outlined').textContent = isPassword ? 'visibility_off'
											: 'visibility';
								});
			}

			function expandStrengthBox() {
				strengthBox.classList.add('open');
			}

			function collapseStrengthBox() {
				// Only collapse if the password field is empty; otherwise keep
				// feedback visible while the user is still working on it.
				if (!passwordInput.value) {
					strengthBox.classList.remove('open');
				}
			}

			function updateItemStatus(elem, met) {
				var icon = elem.querySelector('.material-symbols-outlined');
				icon.textContent = met ? 'check_circle'
						: 'radio_button_unchecked';
				elem.classList.toggle('met', met);
			}

			function resetMeters() {
				meters.forEach(function(m) {
					m.style.background = 'var(--surface-dim)';
				});
			}

			function validateCriteria() {
				var pwd = passwordInput.value || '';
				var conf = confirmInput.value || '';

				var hasLength = pwd.length >= 8;
				var hasUpper = /[A-Z]/.test(pwd);
				var hasNumber = /[0-9]/.test(pwd);
				var matches = pwd.length > 0 && pwd === conf;

				updateItemStatus(reqLength, hasLength);
				updateItemStatus(reqUpper, hasUpper);
				updateItemStatus(reqNumber, hasNumber);
				updateItemStatus(reqMatch, matches);

				var score = 0;
				if (hasLength)
					score++;
				if (hasUpper)
					score++;
				if (hasNumber)
					score++;
				if (/[^A-Za-z0-9]/.test(pwd))
					score++;

				resetMeters();

				if (pwd.length === 0) {
					strengthText.textContent = 'Requires 8+ Chars';
					strengthText.style.color = 'var(--on-surface-variant)';
					return;
				}

				if (score === 1) {
					meters[0].style.background = 'var(--error)';
					strengthText.textContent = 'Weak';
					strengthText.style.color = 'var(--error)';
				} else if (score === 2) {
					meters[0].style.background = 'var(--secondary-container)';
					meters[1].style.background = 'var(--secondary-container)';
					strengthText.textContent = 'Fair';
					strengthText.style.color = 'var(--secondary)';
				} else if (score === 3) {
					meters[0].style.background = 'var(--secondary)';
					meters[1].style.background = 'var(--secondary)';
					meters[2].style.background = 'var(--secondary)';
					strengthText.textContent = 'Good';
					strengthText.style.color = 'var(--secondary)';
				} else if (score >= 4) {
					meters.forEach(function(m) {
						m.style.background = 'var(--primary-container)';
					});
					strengthText.textContent = 'Strong Corporate Grade';
					strengthText.style.color = 'var(--primary)';
				}
			}

			if (passwordInput && confirmInput) {
				passwordInput.addEventListener('focus', expandStrengthBox);
				passwordInput.addEventListener('input', function() {
					expandStrengthBox();
					validateCriteria();
				});
				confirmInput.addEventListener('focus', expandStrengthBox);
				confirmInput.addEventListener('input', function() {
					expandStrengthBox();
					validateCriteria();
				});
				passwordInput.addEventListener('blur', collapseStrengthBox);
				confirmInput.addEventListener('blur', collapseStrengthBox);
			}

			// Basic client-side guard before the form hits the servlet
			var form = document.getElementById('employeeRegisterForm');
			form.addEventListener('submit', function(e) {
				if (!form.checkValidity()) {
					e.preventDefault();
					form.reportValidity();
					return;
				}
				if (passwordInput.value !== confirmInput.value) {
					e.preventDefault();
					alert('Passwords do not match.');
				}
			});
		})();
	</script>
</body>

</html>
