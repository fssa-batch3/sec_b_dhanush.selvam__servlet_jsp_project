<%@page import="in.fssa.leavepulse.dto.EmployeeRoleDTO"%>
<%@page import="in.fssa.leavepulse.model.EmployeeRole"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Employee-Role </title>
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

button:hover {
    cursor: pointer;
}

.heading_container {
	display: flex;
	justify-content: space-between;
	margin-top: 50px;
	padding: 0px 75px;
	margin-bottom: 20px;
}

.no-records {
    text-align: center;
    font-size: 18px;
    margin-top: 20px;
    color: blue;
}

</style>
</head>
<body>

	<jsp:include page="/header.jsp"/>
	<% List<EmployeeRoleDTO> empRoleList = (List<EmployeeRoleDTO>)request.getAttribute("empRolesList"); %>
		
	<div class="heading_container"> 
		<div class="head_container">
			<h1>Employee-Role List</h1> 
		</div>
	</div>
	
	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Employee Name</div>
			<div class="header__item">Manager Name</div>
			<div class="header__item">Role</div>
			<div class="header__item">Edit</div>
		</div>
		<div class="table-content">
		<% if (empRoleList != null && !empRoleList.isEmpty()) { %>
			<% int i = 1; %>
			<% for (EmployeeRoleDTO empRole : empRoleList) { %>
				<div class="table-row">
					<div class="table-data"> <%= i %> </div>
					<div class="table-data"> <%= empRole.getEmployeeName() %> </div>
					<div class="table-data"> <%= empRole.getManagerName() %> </div>
					<div class="table-data"> <%= empRole.getRoleName() %> </div>
					<div class="table-data"> <a href="empRole/edit?id=<%= empRole.getEmpRoleId() %>"> <button class="edit"> Edit </button> </a> </div>
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