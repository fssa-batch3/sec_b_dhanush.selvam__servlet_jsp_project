<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1> 500 </h1>
	<h2> Internal Server Error </h2>
	<% if ((Integer)request.getSession().getAttribute("LOGGEDUSER") != null)  %>
		<button> <a href="<%= request.getContextPath() %>/index"> Back to Home </a></button>
	<% if ((Integer)request.getSession().getAttribute("LOGGEDUSER") == null)  %>
		<button> <a href="<%= request.getContextPath() %>/login"> Back to Login </a></button>
</body>
</html>