<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/navbar.css">

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
	<header class="app-header">
		<div class="d-flex align-items-center gap-3">
			<span class="fw-semibold"
				style="color: var(--primary); font-size: 16px; display: inline-flex;">W<span
				style="color: rgb(0, 201, 154); font-size: 16px;">o</span>rk<span
				style="color: rgb(0, 201, 154); font-size: 16px; margin-right: 15px;">Matrix</span></span>
			<div class="divider-v"></div>
			<span class="fw-semibold"
				style="color: var(--primary); font-size: 16px; margin-left: 15px; margin-right: 15px">Employee
				Timesheet</span> <span class="role-pill d-none d-sm-inline-flex"><span
				class="dot dot-secondary"></span>Role: Intern</span>
		</div>
		<div class="d-flex align-items-center gap-2">
			<button class="icon-btn" aria-label="Notifications" type="button">
				<span class="material-symbols-outlined fs-22">notifications</span> <span
					class="notif-dot"></span>
			</button>
			<div class="divider-v-lg d-none d-sm-block"></div>
			<div class="d-flex align-items-center gap-2"></div>
			<a class="icon-btn danger" aria-label="Sign Out" href="${pageContext.request.contextPath}/login.jsp"> 
			<a href="${pageContext.request.contextPath}/logout" onclick="return confirmLogout();"> 
			<span class="material-symbols-outlined">logout</span> <span>Logout</span>
			</a>
			</a>
		</div>
	</header>
</body>
<script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/navbar.js">
	
</script>
</html>