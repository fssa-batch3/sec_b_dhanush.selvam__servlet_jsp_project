<%@page import="in.fssa.leavepulse.dto.EmployeeDTO"%>
<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="./assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/index.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

</head>

<body>

	<% String employeeName = (String) request.getSession().getAttribute("LOGGEDUSERNAME"); %>

	<div class="header_section">
		<jsp:include page="/header.jsp" />
	</div>

	<div class="body_section">

		<div class="sidebar_section">
			<jsp:include page="/sidebar.jsp" />
		</div>

		<div class="page_section">

			<div class="poster_container">
				<div class="poster_image_container">
					<img src="./assets/images/banner-img.png" class="banner_img">
				</div>
				<div class="poster_content_container">
					<p class="welcome_tag">Welcome Back</p>
					<h2 class="poster_user_name">
						<%= employeeName %>
					</h2>
					<p class="poster_line">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Unde hic non repellendus debitis iure,
						doloremque assumenda.</p>
				</div>
			</div>

			<div class="info_container">

				<div class="individual_info_container">
					<div class="count_container">
						<span class="count"> 7 </span>
						<p class="count_title">Total Leave Request</p>
					</div>
					<div class="image_container">
						<i class="fa-regular fa-file-lines"></i>
					</div>
				</div>

				<div class="individual_info_container">
					<div class="count_container">
						<span class="count"> 4 </span>
						<p class="count_title">Approved Leave</p>
					</div>
					<div class="image_container">
						<i class="fa-regular fa-circle-check"></i>
					</div>
				</div>

				<div class="individual_info_container">
					<div class="count_container">
						<span class="count"> 2 </span>
						<p class="count_title">Pending Leave</p>
					</div>
					<div class="image_container">
						<i class="fa-regular fa-circle-question"></i>
					</div>
				</div>

				<div class="individual_info_container">
					<div class="count_container">
						<span class="count"> 5 </span>
						<p class="count_title">Rejected Leave</p>
					</div>
					<div class="image_container">
						<i class="fa-regular fa-circle-xmark"></i>
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
