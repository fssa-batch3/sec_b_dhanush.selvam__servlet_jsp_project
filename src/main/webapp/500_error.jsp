<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> 500 Error </title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/error.css">

</head>
<body>
	<div class="container">
        <div class="content_container">
            <h1> 500 </h1>
            <h3> Error: 500 Unexpected Error </h3>
            <p> An error occurred and your request couldn't be completed... </p>
            <div class="btn_container">
                <button> <a href="<%= request.getContextPath() %>/login"> Back to Login </a> </button>
            </div>
        </div>
    </div>
</body>
</html>