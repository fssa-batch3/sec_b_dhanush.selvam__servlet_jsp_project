<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@page import="in.fssa.leavepulse.service.EmployeeService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="in.fssa.leavepulse.model.Role"%>
<%@page import="java.util.List"%>
<%@page import="in.fssa.leavepulse.service.RoleService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Employees </title>
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
	<% List<Employee> employeeList = (List<Employee>)request.getAttribute("employeesList"); %>
		
	<div class="heading_container"> <h1>Employees List</h1> </div>
	<div class="add_btn_container">
		<a href="employee/new">
			<button class = "add">Add Employee</button>
		</a>
	</div>

	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Name</div>
			<div class="header__item">Email</div>
			<div class="header__item">Phone No</div>
			<div class="header__item">Employee ID</div>
			<div class="header__item">Edit</div>
			<div class="header__item">Delete</div>
			<div class="header__item">View</div>
		</div>
		<div class="table-content">
		<% int i = 1; %>
		<% for (Employee employee : employeeList) { %>
			<div class="table-row">
				<div class="table-data"> <%= i %> </div>
				<div class="table-data"> <%= employee.getFirst_name() + " " + employee.getLast_name() %> </div>
				<div class="table-data"> <%= employee.getEmail() %> </div>
				<div class="table-data"> <%= employee.getPhone_no() %> </div>
				<div class="table-data"> <%= employee.getEmployee_id() %> </div>
				<div class="table-data"> <a href="employee/edit?id=<%= employee.getEmployee_id() %>"> <button> Edit </button> </a> </div>
				<div class="table-data"> <a href="employee/delete?id=<%= employee.getEmployee_id() %>"> <button> Delete </button> </a> </div>
				<div class="table-data"> <a href="employee/view?id=<%= employee.getEmployee_id() %>"> <button> View </button> </a> </div>
			</div>
			<% i++; %>
			<% } %>
		</div>
	</div>
	
</body>
</html>