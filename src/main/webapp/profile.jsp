<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">

<title>Profile</title>
<style>
	* {
    margin: 0;
    padding: 0
}

.card {
    width: 350px;
    background-color: #efefef;
    border: none;
    cursor: pointer;
    transition: all 0.5s;
}

.image img {
    transition: all 0.5s
}

.card:hover .image img {
    transform: scale(1.5)
}

.btn {
    height: 140px;
    width: 140px;
    border-radius: 50%
}

.name {
    font-size: 22px;
    font-weight: bold
}

.idd {
    font-size: 14px;
    font-weight: 600
}

.idd1 {
    font-size: 12px
}

.number {
    font-size: 22px;
    font-weight: bold
}

.follow {
    font-size: 12px;
    font-weight: 500;
    color: #444444
}

.btn1 {
    height: 40px;
    width: 150px;
    border: none;
    background-color: #000;
    color: #aeaeae;
    font-size: 15px
}

.text span {
    font-size: 13px;
    color: #545454;
    font-weight: 500
}

.icons i {
    font-size: 19px
}

hr .new1 {
    border: 1px solid
}

.join {
    font-size: 14px;
    color: #a0a0a0;
    font-weight: bold
}

.date {
    background-color: #ccc
}

.dl, ol, ul {
	margin-bottom: 0px;
}

.col-md-12 {
    margin-top: 1rem;
}

.mt-3 {
	margin-top: 0px !important;
}

.mb-5 {
	margin-top: 3rem !important;
    margin-bottom: 0px !important;
}

.btn {
    height: 40px;
    width: 125px;
    border-radius: 5px;
}

.container {
	margin-right: 0;
}

body {
	line-height: normal;
}

input {
	margin-top: 5px;
}

.form-control[readonly] {
    background-color: transparent; /* Set to transparent or any other desired color */
}

.mt-5 {
    display: flex;
    justify-content: space-evenly;
}

.logout {
    background-color: #3498db; /* Blue background color for Edit button */
    border-color: #3498db;
}

.logout:hover {
    background-color: #2980b9; /* Darker blue on hover */
}

.edit {
    background-color: #27ae60; /* Green background color for View button */
    border-color: #27ae60;
}

.edit:hover {
    background-color: #219d53; /* Darker green on hover */
}

</style>
</head>
<body>

	<jsp:include page="/header.jsp"/>
	<% Employee employee = new Employee(); %>
	<% employee = (Employee)request.getAttribute("EMPLOYEEDETAILS"); %>
	<% int manager = (int)request.getAttribute("manager"); %>
	<% String role_name = (String)request.getAttribute("role_name"); %>

	<div class="container rounded bg-white mt-5 mb-5">
		<div class="row">
			<div class="col-md-3 border-right">
				<div
					class="d-flex flex-column align-items-center text-center p-3 py-5">
					<img class="rounded-circle mt-5" width="150px"
						src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span
						class="font-weight-bold"> <%= employee.getEmployee_id() %> </span><span class="text-black-50"> <%= employee.getEmail() %> </span><span>
					</span>
				</div>
			</div>
			<div class="col-md-5 border-right">
				<div class="p-3 py-5">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="text-right">Profile</h4>
					</div>
					<div class="row mt-2">
						<div class="col-md-6">
							<label class="labels">First Name</label><input type="text"
								class="form-control" value = "<%= employee.getFirst_name() %>" readonly>
						</div>
						<div class="col-md-6">
							<label class="labels">Last Name</label><input type="text"
								class="form-control" value="<%= employee.getLast_name() %>" readonly>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-md-12">
							<label class="labels">Phone No</label><input type="text"
								class="form-control" value="<%= employee.getPhone_no() %>" readonly>
							</div>
						<div class="col-md-12">
							<label class="labels">Role</label><input type="text"
								class="form-control" value="<%= role_name %>" readonly>
							</div>
						<div class="col-md-12">
							<label class="labels">Manager ID</label><input type="text"
								class="form-control" value="<%= manager %>" readonly>
						</div>
						<div class="col-md-12">
							<label class="labels">Password</label><input type="text"
								class="form-control" value="<%= employee.getPassword() %>" readonly>
						</div>
						<div class="col-md-12">
							<label class="labels">Address</label><input type="text"
								class="form-control" value="<%= employee.getAddress() %>" readonly>
						</div>
					</div>
					
					<div class="mt-5 text-center">
						<a href="logout"> <button class="btn btn-primary profile-button logout" type="button"> Log Out </button> </a>
						<a href="employee/edit?id=<%= employee.getEmployee_id() %>"> <button class="btn btn-primary profile-button edit" type="button"> Edit </button> </a>
					</div>
				</div>
			</div>
			
		</div>
	</div>

</body>
</html>