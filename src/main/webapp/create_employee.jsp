<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<h1> Create Employee </h1>
	<form action="create" method="post">
		<label for = "first_name"> First Name: </label>
		<input type = "text" name="first_name" required> <br>
		<label for = "last_name"> Last Name: </label>
		<input type = "text" name="last_name" required> <br>
		<label for = "email"> Email: </label>
		<input type = "text" name="email" required> <br>
		<label for = "phone"> Phone No: </label>
		<input type = "text" name="phone" required> <br>
		<label for = "password"> Password: </label>
		<input type = "text" name="password" required> <br>
		<label for = "address"> Address: </label>
		<input type = "text" name="address" required> <br>
		<label for = "role"> Role: </label>
		<input type = "text" name="role" required> <br>
		<label for = "manager_id"> Manager: </label>
		<input type = "text" name="manager_id" required> <br>
		<button type = "submit"> Submit </button>
	</form>

</body>
</html>