<%@page import="in.fssa.leavepulse.model.Role"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Role Page</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/roleleave.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">
</head>
<body>

	<% List<Role> rolesList = (List<Role>) request.getAttribute("rolesList"); %>
	<% int lastRoleId = (int) request.getAttribute("lastRoleId"); %>

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
				<jsp:include page="/roleleave.jsp">
					<jsp:param name="rolesList" value="<%=rolesList%>" />
					<jsp:param name="lastRoleId" value="<%= lastRoleId %>" />
					<jsp:param name="type" value="role" />
				</jsp:include>
				<script
					src="<%=request.getContextPath()%>/assets/js/toggleFilterContainer.js"></script>
			</div>

			<div class="footer_section">
				<jsp:include page="/footer.jsp" />
			</div>

		</div>

	</div>

</body>
</html>