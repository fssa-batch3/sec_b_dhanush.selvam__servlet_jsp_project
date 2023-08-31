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
	<% RoleService roleService = new RoleService(); %>
	<% List<Role> roleList = roleService.getAllRole(); %>
		
	<div>
		<h1>Roles List</h1>
	</div>
	<div class="add">
		<a href="role/new"> <button> Add Role </button> </a>
	</div>
	
	<table>
		<tr>
			<th>S.No</th>
			<th>Role Name</th>
			<th>Role Id</th>
			<th>Edit</th>
			<th>Delete</th>
		</tr>
		<% int i = 1; %>
		<% for (Role role : roleList) {%>
		<tr>
			<td> <%= i %> </td>
			<td> <%= role.getRoleName() %> </td>
			<td> <%= role.getRoleId() %> </td>
			<td> <a href="role/edit?id=<%= role.getRoleId() %>"> <button> Edit </button> </a> </td>
			<td> <a href="role/delete?id=<%= role.getRoleId()%>"> <button> Delete </button> </a> </td>
		</tr>
		<% i++; %>
		<% } %>
	</table>
</body>
</html>