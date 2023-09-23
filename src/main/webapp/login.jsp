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
    
</head>
<body>

	<div class="header_section">
        <div>

		  <div class="header">
		
		    <div class="logo_container">
		      <h2 class = "logo"> LeavePulse </h2>
		    </div>
		
		</div>
        
    </div>

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
                    <input class="field email_field" type="email" placeholder="Email" name="email" autofocus>
                </div>
                <div class="field_container">
                    <input id="password_field" class="field" type="password" placeholder="Password" name="password">
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
	
		const password_field = document.getElementById("password_field");
	    const checkbox = document.getElementById("checkbox");
	
	    checkbox.addEventListener("click", function ()  {
	        let type = password_field.getAttribute("type") == "password" ? "text" : "password";
	        password_field.setAttribute("type",type);
	    })
	    
	    document.querySelector(".login_btn").addEventListener("click",(e) => {
	    	
		    e.preventDefault();
		    
		    const emailField = document.querySelector(".email_field");
		    const email = emailField.value.trim();
		    
		    if (email == "") {
		    	alert("Email cannot be empty");
		    	emailField.focus();
		    	return;
		    }
		    
		    const pattern = /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
		
		    if (!pattern.test(email)) {
		        alert("Email doesn't match the pattern. Ex:abc@gmail.com");
		        emailField.focus();
		        return;
		    }
		    
		    const passwordField = document.querySelector("#password_field")
		    const password = passwordField.value.trim();
		    
		    if (password == "") {
		    	alert("Password cannot be empty");
		    	passwordField.focus();
		    	return;
		    }
		    
		    const password_pattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,24}$/;

		    if (!password_pattern.test(password)) {
		        alert("Password doesn't match the pattern. The password must contain at least one capital letter, at least one small letter, at least one number and at least one special characters, minimum eight to maximum twenty four characters");
		        passwordField.focus();
		        return;
		    }
		    
		    document.querySelector(".form").submit();
		    		    
		});

	    
	</script>
	
</body>
</html>