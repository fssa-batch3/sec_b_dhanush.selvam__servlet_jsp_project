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
<title> Roles </title>
<style>

body{
  font-family: 'Poppins', sans-serif;
}
	
.table_container {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    text-align: center; /* Center the table within the container */
}

.table {
    width: 90%; /* Set the table width to 90% */
    margin: 0 auto; /* Center the table horizontally */
    border: 1px solid #EEEEEE;
}

.table-header {
    display: flex;
    width: 100%;
    background: darkslategray;
    padding: 15px 0px;
    color: white;
}

.table-row {
    display: flex;
    width: 100%;
    padding: 15px 0px;
    
    &:nth-of-type(odd) {
        background: #EEEEEE;
    }
}

.table-data, .header__item {
    flex: 1 1 20%;
    text-align: center;
}

.edit {
    background-color: #3498db; /* Blue background color for Edit button */
    color: #fff; /* Text color */
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-decoration: none;
}

.edit:hover {
    background-color: #2980b9; /* Darker blue on hover */
}

.delete {
    background-color: #e74c3c; /* Red background color for Delete button */
    color: #fff; /* Text color */
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-decoration: none;
}

.delete:hover {
    background-color: #c0392b; /* Darker red on hover */
}


button:hover {
    cursor: pointer;
}

.heading_container {
	display: flex;
	justify-content: space-between;
	margin-top: 50px;
	padding: 0px 75px;
}

.add_btn_container {
	display: flex;
	justify-content: end;
	margin-bottom: 20px;
}

.add {
	color: white;
    border: none;
    background: darkslategray;
    padding: 10px 15px;
    border-radius: 5px;
}

</style>
</head>
<body>
	
	<jsp:include page="/header.jsp"/>
	<% List<Role> roleList = (List<Role>) request.getAttribute("rolesList"); %>

	<div class="heading_container"> 
		<div class="head_container">
			<h1>Roles List</h1> 
		</div>
		<div class="add_btn_container">
			<a href="role/new">
				<button class = "add">Add Role</button>
			</a>
		</div>
	</div>

	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Role Name</div>
			<div class="header__item">Role ID</div>
			<div class="header__item">Edit</div>
			<div class="header__item">Delete</div>
		</div>
		<div class="table-content">
		<% int i = 1; %>
		<% for (Role role : roleList) { %>
			<div class="table-row">
				<div class="table-data"> <%= i %> </div>
				<div class="table-data"> <%= role.getRoleName() %> </div>
				<div class="table-data"> <%= role.getRoleId() %> </div>
				<div class="table-data"> <a href="role/edit?id=<%= role.getRoleId() %>"> <button class="edit"> Edit </button> </a> </div>
				<div class="table-data"> <a href="role/delete?id=<%= role.getRoleId() %>"> <button class="delete"> Delete </button> </a> </div>
			</div>
			<% i++; %>
			<% } %>
		</div>
	</div>

</body>
</html>