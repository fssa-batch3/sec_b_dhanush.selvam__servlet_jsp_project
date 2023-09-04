<%@page import="in.fssa.leavepulse.model.Leave"%>
<%@page import="java.util.List"%>
<%@page import="in.fssa.leavepulse.service.LeaveService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Leaves </title>
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
</head>
<body>
	<% List<Leave> leaveList = (List<Leave>)request.getAttribute("leavesList"); %>
		
	<div class="heading_container"> <h1>Leave Type List</h1> </div>
	<div class="add_btn_container">
		<a href="leave/new">
			<button class = "add">Add Leave Type</button>
		</a>
	</div>

	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Leave Type</div>
			<div class="header__item">Leave ID</div>
			<div class="header__item">Edit</div>
			<div class="header__item">Delete</div>
		</div>
		<div class="table-content">
		<% int i = 1; %>
		<% for (Leave leave : leaveList) { %>
			<div class="table-row">
				<div class="table-data"> <%= i %> </div>
				<div class="table-data"> <%= leave.getLeaveType() %> </div>
				<div class="table-data"> <%= leave.getLeaveId() %> </div>
				<div class="table-data"> <a href="leave/edit?id=<%= leave.getLeaveId() %>"> <button> Edit </button> </a> </div>
				<div class="table-data"> <a href="leave/delete?id=<%= leave.getLeaveId() %>"> <button> Delete </button> </a> </div>
			</div>
			<% i++; %>
			<% } %>
		</div>
	</div>
	
</body>
</html>