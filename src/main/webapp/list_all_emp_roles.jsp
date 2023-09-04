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

	<% List<EmployeeRole> empRoleList = (List<EmployeeRole>)request.getAttribute("empRolesList"); %>
		
	<div class="heading_container"> <h1>Employee-Role List</h1> </div>
	
	<div class="table">
		<div class="table-header">
			<div class="header__item">S.No</div>
			<div class="header__item">Employee-Role ID</div>
			<div class="header__item">Employee ID</div>
			<div class="header__item">Manager ID</div>
			<div class="header__item">Role</div>
			<div class="header__item">Edit</div>
		</div>
		<div class="table-content">
		<% int i = 1; %>
		<% for (EmployeeRole empRole : empRoleList) { %>
			<div class="table-row">
				<div class="table-data"> <%= i %> </div>
				<div class="table-data"> <%= empRole.getEmpRoleId() %> </div>
				<div class="table-data"> <%= empRole.getEmployeeId() %> </div>
				<div class="table-data"> <%= empRole.getManagerId() %> </div>
				<div class="table-data"> <%= empRole.getRoleId() %> </div>
				<div class="table-data"> <a href="empRole/edit?id=<%= empRole.getEmpRoleId() %>"> <button> Edit </button> </a> </div>
			</div>
			<% i++; %>
			<% } %>
		</div>
	</div>
	
</body>
</html>