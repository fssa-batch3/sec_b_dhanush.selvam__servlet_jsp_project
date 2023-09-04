<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="in.fssa.leavepulse.model.Request"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Requests </title>
</head>
<style>

body{
  font-family: 'Poppins', sans-serif;
}
	
.table_container {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
}

.table_header_container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.table {
	width:100%;
	border:1px solid #EEEEEE;
}

.table-header {
	display:flex;
	width:100%;
	background:#000;
	padding: 15px 0px;
	color: white;
}

.table-row {
	display:flex;
	width:100%;
	padding: 15px 0px;
	
	&:nth-of-type(odd) {
		background: #EEEEEE;
	}
}

.table-data, .header__item {
	flex: 1 1 20%;
	text-align:center;
} 

button:hover {
    cursor: pointer;
}

.heading_container {
	display: flex;
	justify-content: center;
}

.add_btn_container {
	display: flex;
	justify-content: end;
	margin-bottom: 20px;
}

.add {
	color: white;
    border: none;
    background: black;
    padding: 10px 15px;
    border-radius: 5px;
}

</style>
<body>

	<% List<Request> requestList = (List<Request>)request.getAttribute("requests"); %>
	
	<div class="heading_container"> <h1>Requests List</h1> </div>
	<div class="add_btn_container">
		<a href="request/new">
			<button class = "add">Add Request</button>
		</a>
	</div>

	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Name</div>
			<div class="header__item">Leave Type</div>
			<div class="header__item">Applied Date</div>
			<div class="header__item">Status</div>
			<div class="header__item">Edit</div>
			<div class="header__item">View</div>
		</div>
		<div class="table-content">
		<% int i = 1; %>
		<% for (Request requests : requestList) { %>
			<div class="table-row">
				<div class="table-data"> <%= i %> </div>
				<div class="table-data"> <%= requests.getCreatedBy() %> </div>
				<div class="table-data"> <%= requests.getLeaveId() %> </div>
				<% String originalDateString = requests.getCreatedAt() + ""; %>
				<% DateTimeFormatter originalFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"); %>
				<% LocalDate localDate = LocalDate.parse(originalDateString, originalFormatter); %>
				<% DateTimeFormatter desiredFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); %>
				<% String desiredDateString = localDate.format(desiredFormatter); %>
				<div class="table-data"> <%= desiredDateString %> </div>
				<div class="table-data"> <%= requests.getLeaveStatus() %> </div>
				<div class="table-data"> <a href="request/edit?id=<%= requests.getRequestId() %>"> <button> Edit </button> </a> </div>
				<div class="table-data"> <a href="request/view?id=<%= requests.getRequestId() %>"> <button> View </button> </a> </div>
			</div>
			<% i++; %>
			<% } %>
		</div>
	</div>
	
</body>
</html>