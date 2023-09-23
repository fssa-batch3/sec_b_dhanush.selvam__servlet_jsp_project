<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@page import="in.fssa.leavepulse.model.Role"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title> Create Employee </title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/createemployee.css">
    
</head>

<body>
	
	<% List<Role> rolesList = (List<Role>)request.getAttribute("rolesList"); %>
	<% int employeeId = (int) request.getSession().getAttribute("LOGGEDUSER"); %>
	<% int lastEmployeeId = (int) request.getAttribute("lastEmployeeId"); %>
	
	<div class="header_section">
        <script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
        <jsp:include page="/header.jsp"/>
    </div>

    <div class="body_section">

        <div class="sidebar_section">
            <jsp:include page="/sidebar.jsp" />
        </div>

        <div class="page_section">

            <div class="breadcrumbs_section">
                <jsp:include page="/breadcrumbs.jsp" />
            </div>

            <div class="main_section">
            
            	<script src="<%=request.getContextPath()%>/assets/js/toggleRoleContainer.js"></script>

                <div class="application_form_container">
                    <div>
                        <h3 class="form_title"> Application Form </h3>
                    </div>
                    <form action="employee" method="post">
	                    <div class="form_container">
	                        <div class="fields_container">
	                            <div class="field_container">
	                                <label for="first_name"> First Name </label>
	                                <input name="first_name" class="apply_leave_inputs first_name" type="text" required autofocus>
	                            </div>
	                            <div class="field_container">
	                                <label for="last_name"> Last Name </label>
	                                <input name="last_name" class="apply_leave_inputs last_name" type="text" required>
	                            </div>
	                            <div class="field_container">
	                                <label for="email"> Email </label>
	                                <input name="email" class="apply_leave_inputs email" type="text" required>
	                            </div>
	                        </div>
	                        <div class="fields_container">
	                            <div class="field_container">
	                                <label for="phone"> Phone Number </label>
	                                <input name="phone" class="apply_leave_inputs phone" type="tel" required>
	                            </div>
	                            <div class="field_container">
	                                <label for="password"> Password </label>
	                                <input name="password" id="password_field" class="apply_leave_inputs" type="password" required>
	                                <div class = "eye_container"> <i class="fa-solid fa-eye"></i> <i class="fa-solid fa-eye-slash"></i> </div> 
	                            </div>
	                            <div class="field_container">
	                                <label> Role </label>
	                                <div class="select_tag_container" onclick="toggleRoleSelectContainer()">
	                                    <button class="select_tag" type="button"> Select Role </button>
	                                    <i class="fa-solid fa-angle-down"></i>
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <input type="hidden" name="role" id="selectedRole" value="">
	            
	                        <div class="role_type_container">
	                        	<% for (Role role : rolesList) { %>
	                            	<div class="role_container" onclick="selectRole( '<%= role.getRoleName() %>')"> <p> <%= role.getRoleName() %> </p> </div>
	                           	<% } %>
	                        </div>
						
	                        <div class="fields_container">
	                            <div class="field_container">
	                                <label for="address"> Address </label>
	                                <input name="address" required class="apply_leave_inputs address" type="text">
	                            </div>
	                            <div class="field_container">
	                                <label> Employee Id </label>
	                                <input class="apply_leave_inputs" value=<%= lastEmployeeId + 1 %> readonly>
	                            </div>
	                            <div class="field_container">
	                                <label> Manager Id </label>
	                                <input name="manager_id" class="apply_leave_inputs" value=<%= employeeId %> type="text" readonly>
	                            </div>
	                        </div>
                            <div class="submit_btn_container">
                                <button class="submit_btn" id="submit_btn"> Submit </button>
                            </div>
	                    </div>
                    </form>
                </div>

            </div>
        
            <div class="footer_section">
                <jsp:include page="/footer.jsp" />
            </div>

        </div>

    </div>
    
    <script>
    
	    let eye_icon = document.querySelector(".fa-eye");
		let eye_slash_icon = document.querySelector(".fa-eye-slash");
		let password_field = document.getElementById("password_field");
		let submit_btn = document.getElementById("submit_btn");
		
		
		eye_icon.addEventListener("click",() => {
			password_field.setAttribute("type","text");
			eye_icon.style.display = "none";
			eye_slash_icon.style.display = "block";
		})
		
		eye_slash_icon.addEventListener("click",() => {
			password_field.setAttribute("type","password");
			eye_slash_icon.style.display = "none";
			eye_icon.style.display = "block";
		})
	    
	    submit_btn.addEventListener("click", (e) => {
	    	
	    	e.preventDefault();
	    	
	    	const first_name = document.querySelector(".first_name").value.trim();
		    
		    if (first_name == "") {
		    	alert("First name cannot be empty");
		    	first_name.focus();
		    	return;
		    }
		    
		    const name_pattern = /^[A-Za-z\s]{3,24}$/;
		
		    if (!name_pattern.test(first_name)) {
		        alert("Only letters are allowed in this field. Please remove any numbers or special characters.");
		        first_name.focus();
		        return;
		    }
		    
			const last_name = document.querySelector(".last_name").value.trim();
		    
		    if (last_name == "") {
		    	alert("Last name cannot be empty");
		    	last_name.focus();
		    	return;
		    }
		    		
		    if (!name_pattern.test(last_name)) {
		        alert("Only letters are allowed in this field. Please remove any numbers or special characters.");
		        last_name.focus();
		        return;
		    }
	    	
	    	const email = document.querySelector(".email").value.trim();
		    
		    if (email == "") {
		    	alert("Email cannot be empty");
		    	emailField.focus();
		    	return;
		    }
		    
		    const email_pattern = /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
		
		    if (!email_pattern.test(email)) {
		        alert("Email doesn't match the pattern. Ex:abc@gmail.com");
		        emailField.focus();
		        return;
		    }
		    
		    const phone = document.querySelector(".phone").value.trim(); 
		    
		    if (phone == "") {
		    	alert("Phone No cannot be empty");
		    	phone.focus();
		    	return;
		    }

		    const phone_pattern = /^[6-9]\d{9}$/;
		
		    if (!phone_pattern.test(phone)) {
		        alert("No letters and characters. Start with 6,7,8 and 9. Only 10 digits");
		        phone.focus();
		        return;
		    }
		    
		    const password = document.querySelector("#password_field").value.trim();
		    
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
	    	
		    let selectedRole = document.getElementById("selectedRole").value;
	        if (selectedRole == "") {
	            alert("Please select a role before submitting the form.");
	        }
	        
	        const address = document.querySelector(".address").value.trim();
	        
	        if (address == "") {
		    	alert("Address cannot be empty");
		    	address.focus();
		    	return;
		    }
	        
	        const address_pattern = /^[A-Za-z0-9\s.,#-]+$/;
	        
	        if (!address_pattern.test(address)) {
	            alert("Please enter a valid address. Only alphanumeric characters, spaces, periods, commas, hashtags, and hyphens are allowed.");
		        address.focus();
		        return;
		    }
	        
	    });
    
    </script>
    
</body>
</html>