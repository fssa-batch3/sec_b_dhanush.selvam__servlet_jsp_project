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
<title>Insert title here</title>
<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid black;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}

div {
	display: flex;
	justify-content: center;
}

.add {
	justify-content: end;
}

</style>
</head>
<body>
	<% EmployeeService employeeService = new EmployeeService(); %>
	<% List<Employee> employeeList = employeeService.getAllEmployee(); %>
		
	<div>
		<h1>Roles List</h1>
	</div>
	<div class="add">
		<a href="employee/new"> <button> Add Employee </button> </a>
	</div>
	
	<table>
		<tr>
			<th>S.No</th>
			<th>Name</th>
			<th>Email</th>
			<th>Phone No</th>
			<th>Employee ID</th>
			<th>Edit</th>
			<th>Delete</th>
			<th>View</th>
		</tr>
		<% int i = 1; %>
		<% for (Employee employee : employeeList) {%>
		<tr>
			<td> <%= i %> </td>
			<td> <%= employee.getFirst_name() + " " + employee.getLast_name() %> </td>
			<td> <%= employee.getEmail() %> </td>
			<td> <%= employee.getPhone_no() %> </td>
			<td> <%= employee.getEmployee_id() %> </td>
			<td> <a href="employee/edit?id=<%= employee.getEmployee_id() %>"> <button> Edit </button> </a> </td>
			<td> <a href="employee/delete?id=<%= employee.getEmployee_id() %>"> <button> Delete </button> </a> </td>
			<td> <a href="employee/delete?id=<%= employee.getEmployee_id() %>"> <button> View </button> </a> </td>
		</tr>
		<% i++; %>
		<% } %>
	</table>
</body>
</html>