<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Login </title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/login.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

<style>

html, body {
	height: 100%;
}

</style>
 
</head>
<body>

	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% String invalidEmail = (String) request.getAttribute("email"); %>
	<% String invalidPassword = (String) request.getAttribute("password"); %>

	<div class="header_section">
	  <div class="header">
	    <div class="logo_container">
	      <h2 class = "logo"> LeavePulse </h2>
	    </div>
	  </div>
    </div>
    
    <jsp:include page="/error_popup.jsp"/>

	<div class="page_container">
        <div class="image_container">
            <img src="./assets/images/login-page-img.png">
        </div>
        <div class="form_container">
            <div class="title_container">
                <h1> Login </h1>
            </div>
            <form class="form" action="login" method="post">
                <div class="field_container">
                    <input class="field email_field" type="email" autocomplete="off" placeholder="Email" name="email" autofocus>
                </div>
                <div class="field_container">
                    <input id="password_field" class="field" type="password" autocomplete="off" placeholder="Password" name="password">
                </div>
                <div class="password_container">
                    <div class="show_password_container">
                        <label> <input name="check" type="checkbox" id="checkbox"> Show Password </label>
                    </div>
                    <div class="forgot_password_container">
                        <a href="#"> Forgot Password </a>
                    </div>
                </div>
                <div>
                    <button class="login_btn"> Login </button>
                </div>
                
            </form>
        </div>
    </div>
	
	<script>
		
		const emailField = document.querySelector(".email_field");
		const passwordField = document.querySelector("#password_field");
	    const checkbox = document.getElementById("checkbox");
	
		const errorMessage = "<%= errorMessage %>";
		const invalidEmail = "<%= invalidEmail %>";
		const invalidPassword = "<%= invalidPassword %>";
		const popUpContainer = document.querySelector(".pop_up_container");
		const okayBtn = document.querySelector(".okay_btn");
		
		if (errorMessage != "null") {
			popUpContainer.style.display = "block";
			document.querySelector(".error_message").innerHTML = errorMessage;
			okayBtn.focus();
		}
		
		okayBtn.addEventListener("click", () => {
			popUpContainer.style.display = "none";
			if (errorMessage == "Email ID not found") {
				emailField.value = "";
				emailField.focus();
				passwordField.value = invalidPassword;
				return;
			}
			else if (errorMessage == "Password mismatch") {
				passwordField.value = "";
				passwordField.focus();
				emailField.value = invalidEmail;
				return;
			}
		})
		
	    checkbox.addEventListener("click", function ()  {
	        let type = password_field.getAttribute("type") == "password" ? "text" : "password";
	        passwordField.setAttribute("type",type);
	    })
	    
	    document.querySelector(".login_btn").addEventListener("click",(e) => {
	    	
		    e.preventDefault();
		    
		    const email = emailField.value.trim();
		    
		    if (email == "") {
		    	alert("Email cannot be empty");
		    	emailField.focus();
		    	return;
		    }
		    
		    const pattern = /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
		
		    if (!pattern.test(email)) {
		        alert("Email doesn't match the pattern. Ex:abc@gmail.com");
		    	emailField.value = "";
		        emailField.focus();
		        return;
		    }
		    
		    const password = passwordField.value.trim();
		    
		    if (password == "") {
		    	alert("Password cannot be empty");
		    	passwordField.focus();
		    	return;
		    }
		    
		    const password_pattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,24}$/;

		    if (!password_pattern.test(password)) {
		        alert("Password doesn't match the pattern. The password must contain at least one capital letter, at least one small letter, at least one number and at least one special characters, minimum eight to maximum twenty four characters");
		    	passwordField.value = "";
		        passwordField.focus();
		        return;
		    }
		    
		    document.querySelector(".form").submit();
		    		    
		});

	    
	</script>
	
</body>
</html>