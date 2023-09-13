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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

.view {
    background-color: #27ae60; /* Green background color for View button */
    color: #fff; /* Text color */
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-decoration: none;
}

.view:hover {
    background-color: #219d53; /* Darker green on hover */
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

.no-records {
    text-align: center;
    font-size: 18px;
    margin-top: 20px;
    color: blue;
}

.search {
  display: flex;
}

.searchTerm {
     width: 70%;
    border: 3px solid darkslategray;
    border-right: none;
    padding: 0px 10px;
    height: 40px;
    border-radius: 5px 0 0 5px;
    outline: none;
    font-size: 16px;
}

.searchButton {
  width: 40px;
  height: 40px;
  border: 1px solid darkslategray;
  background: darkslategray;
  text-align: center;
  color: #fff;
  border-radius: 0 5px 5px 0;
  cursor: pointer;
  font-size: 20px;
}

.wrap{
  width: 30%;
}


</style>
</head>
<body>

	<jsp:include page="/header.jsp"/>
	<% List<Employee> employeeList = (List<Employee>)request.getAttribute("employeesList"); %>
		
	<div class="heading_container"> 
		<div class="head_container">
			<h1>Employees List</h1> 
		</div>
		
		<div class="wrap">
   <div class="search">
      <input type="text" class="searchTerm" placeholder="Search">
      <button type="submit" class="searchButton">
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>

		<div class="add_btn_container">
			<a href="employee/new">
				<button class = "add">Add Employee</button>
			</a>
		</div>
	</div>

	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Name</div>
			<div class="header__item">Email</div>
			<div class="header__item">Phone No</div>
			<div class="header__item">Employee ID</div>
			<div class="header__item">View</div>
			<div class="header__item">Delete</div>
		</div>
		<div class="table-content">
		<% if (employeeList != null && !employeeList.isEmpty()) { %>
			<% int i = 1; %>
			<% for (Employee employee : employeeList) { %>
				<div class="table-row">
					<div class="table-data"> <%= i %> </div>
					<div class="table-data"> <%= employee.getFirst_name() + " " + employee.getLast_name() %> </div>
					<div class="table-data"> <%= employee.getEmail() %> </div>
					<div class="table-data"> <%= employee.getPhone_no() %> </div>
					<div class="table-data"> <%= employee.getEmployee_id() %> </div>
					<div class="table-data"> <a href="employee/view?id=<%= employee.getEmployee_id() %>"> <button class="view"> View </button> </a> </div>
					<div class="table-data"> <a href="employee/delete?id=<%= employee.getEmployee_id() %>"> <button class="delete"> Delete </button> </a> </div>
				</div>
				<% i++; %>
				<% } %>
			<% } else { %>
            	<div class="no-records">No records found.</div>
        	<% } %>
        	
		</div>
	</div>
	
</body>
</html>