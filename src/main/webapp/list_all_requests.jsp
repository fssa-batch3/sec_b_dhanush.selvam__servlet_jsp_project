<%@page import="in.fssa.leavepulse.dto.RequestDTO"%>
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
	margin-bottom: 20px;
}

</style>
<body>

	<jsp:include page="/header.jsp"/>
	<% List<RequestDTO> requestList = (List<RequestDTO>)request.getAttribute("requests"); %>
	
	<div class="heading_container"> 
		<div class="head_container">
			<h1>Requests List</h1> 
		</div>
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
		<% for (RequestDTO requests : requestList) { %>
			<div class="table-row">
				<div class="table-data"> <%= i %> </div>
				<div class="table-data"> <%= requests.getEmployeeName() %> </div>
				<div class="table-data"> <%= requests.getLeaveType() %> </div>
				<% String originalDateString = requests.getCreatedAt() + ""; %>
				<% DateTimeFormatter originalFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"); %>
				<% LocalDate localDate = LocalDate.parse(originalDateString, originalFormatter); %>
				<% DateTimeFormatter desiredFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); %>
				<% String desiredDateString = localDate.format(desiredFormatter); %>
				<div class="table-data"> <%= desiredDateString %> </div>
				<div class="table-data"> <%= requests.getLeaveStatus() %> </div>
				<div class="table-data"> <a href="request/edit?id=<%= requests.getRequestId() %>"> <button class="edit"> Edit </button> </a> </div>
				<div class="table-data"> <a href="request/view?id=<%= requests.getRequestId() %>"> <button class="view"> View </button> </a> </div>
			</div>
			<% i++; %>
			<% } %>
		</div>
	</div>
	
</body>
</html>