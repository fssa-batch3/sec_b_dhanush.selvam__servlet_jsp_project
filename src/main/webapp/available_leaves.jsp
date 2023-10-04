<%@page import="in.fssa.leavepulse.dto.LeaveBalanceDTO"%>
<%@page import="java.util.List"%>
<%@page import="in.fssa.leavepulse.service.RoleService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Available Leaves Page</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

</head>
<body>

	<% List<LeaveBalanceDTO> availableLeaves = (List<LeaveBalanceDTO>) request.getAttribute("availableLeaves"); %>

	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
	</div>

	<div class="body_section">

		<div class="sidebar_section">
			<jsp:include page="/sidebar.jsp" />
		</div>

		<div class="page_section">

			<div class="breadcrumbs_section">
				<jsp:include page="/breadcrumbs.jsp" />
			</div>

			<div class="main_section">
				<script src="<%=request.getContextPath()%>/assets/js/toggleFilterContainer.js"></script>
				<div class="table_container">
					<div class="table_header_container">
						<div class="table_heading_container">
							<h2>Available Leaves</h2>
						</div>
						<div class="search_container">
							<input type="search" placeholder="Search" class="search_bar">
							<i class="fa-solid fa-magnifying-glass"></i>
						</div>
						<div class="filter_container" onclick="toggleFilterContainer()">
							<button class="filter_btn">
								Filter by <i class="fa-solid fa-angle-down"></i>
							</button>
						</div>
					</div>

					<div class="filter_dropdown_container">
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Minimum leaves</p>
							</div>
						</div>
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Maximum leaves</p>
							</div>
						</div>
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item">Leave Type</div>
							<div class="header__item">Available days</div>
						</div>
						<div class="table-content">
							<% int i = 1; %>
								<% for (LeaveBalanceDTO leave : availableLeaves) { %>
								<div class="table-row">
									<div class="table-data"> <%= i %> </div>
									<div class="table-data"> <%= leave.getLeaveType() %> </div>
									<div class="table-data"> <%= leave.getAvailableLeaveDays() %> </div>
								</div>
							<% i++; %>
							<% } %>
						</div>
					</div>

				</div>
			</div>

			<div class="footer_section">
				<jsp:include page="/footer.jsp" />
			</div>

		</div>

	</div>
	
</body>
</html>