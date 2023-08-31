<%@page import="in.fssa.leavepulse.model.Role"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<% Role role = new Role(); %>
	<% role = (Role)request.getAttribute("roles"); %>
	<h1> Edit Role </h1>
	<form action="update?id=<%= role.getRoleId()%>" method="post">
		<label for = "role_name"> Role Name: </label>
		<input type = "text" name="role_name" value = "<%= role.getRoleName()%>"> <br>
		<button type = "submit"> Submit </button>
	</form>
	
</body>
</html>