<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> 404 Error </title>

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
            <h1> 404 </h1>
            <h3> Error: 404 Page Not Found </h3>
            <p> Sorry, the page you're looking for cannot be accessed. </br> Check the URL. </p>
            <div class="btn_container">
                <button> <a href="<%= request.getContextPath() %>/index"> Back to Home </a> </button>
            </div>
        </div>
    </div>
</body>
</html>