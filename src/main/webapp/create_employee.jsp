
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/createemployee.css">
    
</head>

<body>
	
	<% List<Role> rolesList = (List<Role>)request.getAttribute("rolesList"); %>
	<% int employeeId = (int) request.getSession().getAttribute("LOGGEDUSER"); %>
	<% int lastEmployeeId = (int) request.getAttribute("lastEmployeeId"); %>
	
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% Employee invalidEmployee = (Employee)request.getAttribute("employee"); %>
	<% String invalidRole = (String) request.getAttribute("role"); %>
	
	<div class="header_section">
        <script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
        <jsp:include page="/header.jsp"/>
    </div>

	<jsp:include page="/error_popup.jsp"/>
	
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
                    <form class="form" action="employee" method="post">
	                    <div class="form_container">
	                        <div class="fields_container">
	                            <div class="field_container">
	                                <label for="first_name"> First Name </label>
	                                <input name="first_name" tabindex=1 id="first_name" autocomplete="off" class="apply_leave_inputs" type="text" required autofocus>
	                            </div>
	                            <div class="field_container">
	                                <label for="last_name"> Last Name </label>
	                                <input name="last_name" tabindex=2 id="last_name" autocomplete="off" class="apply_leave_inputs" type="text" required>
	                            </div>
	                            <div class="field_container">
	                                <label for="email"> Email </label>
	                                <input name="email" tabindex=3 id="email" autocomplete="off" class="apply_leave_inputs" type="text" required>
	                            </div>
	                        </div>
	                        <div class="fields_container">
	                            <div class="field_container">
	                                <label for="phone"> Phone Number </label>
	                                <input name="phone" tabindex=4 id="phone" autocomplete="off" class="apply_leave_inputs" type="tel" required>
	                            </div>
	                            <div class="field_container">
	                                <label for="password_field"> Password </label>
	                                <input name="password" tabindex=5 id="password_field" class="apply_leave_inputs" type="password" required>
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
	                                <input name="address" tabindex=6 id="address" autocomplete="off" required class="apply_leave_inputs" type="text">
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
	                        <div class="fields_container">
	                            <div class="field_container">
	                                <label for="joining_date"> Joining Date </label>
	                                <input name="joining_date" tabindex=7 required class="apply_leave_inputs" type="date" id="joining_date">
	                            </div>
	                            <div class="submit_btn_container">
                              		<button class="submit_btn" tabindex=8 id="submit_btn"> Submit </button>
                            	</div>
	                            <div class="field_container"></div>
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
    
	    const firstNameField = document.querySelector("#first_name");
	    const lastNameField = document.querySelector("#last_name");
		const emailField = document.querySelector("#email");
		const phoneField = document.querySelector("#phone") 
	    const passwordField = document.querySelector("#password_field");
	    const addressField = document.querySelector("#address");
	    const joiningDateInput = document.querySelector('#joining_date');
	    
	    const errorMessage = "<%= errorMessage %>";
		const invalidEmployee = <%= invalidEmployee %>;
		const invalidRole = "<%= invalidRole %>";
		
		const popUpContainer = document.querySelector(".pop_up_container");
		const okayBtn = document.querySelector(".okay_btn");
		
		function isError(errorMessage) {
			if (errorMessage != "null") {
				popUpContainer.style.display = "block";
				document.querySelector(".error_message").innerHTML = errorMessage;
				firstNameField.value = invalidEmployee.firstName;
				lastNameField.value = invalidEmployee.lastName;
				emailField.value = (errorMessage == "Email ID already exist") ? "" : invalidEmployee.email;
				phoneField.value = (errorMessage == "Phone Number already exist") ? "" : invalidEmployee.phoneNo;
				selectRole(invalidRole);
				passwordField.value = invalidEmployee.password;
				addressField.value = invalidEmployee.address;
				joiningDateInput.value = invalidEmployee.joiningDate;
				okayBtn.focus();
				document.getElementById("breadcrumbs_title").innerHTML = "Create Employee";
				document.getElementById("breadcrumbs_path").innerHTML = "Dashboard > New Employee";
  				history.replaceState(null, null, window.location.href + "?action=new");
			}
		}
		
		isError(errorMessage);
		
		okayBtn.addEventListener("click", () => {
			popUpContainer.style.display = "none";
			(emailField.value == "") ? emailField.focus() : phoneField.focus();
			return;
		})
	    		
		const eyeIcon = document.querySelector(".fa-eye");
		const eyeSlashIcon = document.querySelector(".fa-eye-slash");
		const submitBtn = document.getElementById("submit_btn");
		
		
		eyeIcon.addEventListener("click",() => {
			passwordField.setAttribute("type","text");
			eyeIcon.style.display = "none";
			eyeSlashIcon.style.display = "block";
		})
		
		eyeSlashIcon.addEventListener("click",() => {
			passwordField.setAttribute("type","password");
			eyeSlashIcon.style.display = "none";
			eyeIcon.style.display = "block";
		})
		
		const today = new Date();
  		const oneWeekAgo = new Date(today);
	  	oneWeekAgo.setDate(today.getDate() - 7);
	  	const threeMonthsLater = new Date(today);
	  	threeMonthsLater.setMonth(today.getMonth() + 3);
		
	  	function isSunday(date) {
	    	return date.getDay() === 0;
	  	}
	
	  	joiningDateInput.min = oneWeekAgo.toISOString().split('T')[0];
	  	joiningDateInput.max = threeMonthsLater.toISOString().split('T')[0];
	  	
  	 	joiningDateInput.addEventListener('keydown', function (e) {
    		e.preventDefault();
  	  	});
  	 	
  	 	joiningDateInput.addEventListener('input', function () {
  	 	    const selectedDate = new Date(this.value);
  	 	    if (isSunday(selectedDate)) {
  	 	      alert('Sundays are not allowed. Please choose another date.');
  	 	      this.value = '';
  	 	    }
  	 	  });
	
	    submitBtn.addEventListener("click", (e) => {
	    	
	    	e.preventDefault();
	    	
	    	const firstName = firstNameField.value.trim();
			const lastName = lastNameField.value.trim();
	    	const email = emailField.value.trim();
		    const phone = phoneField.value.trim(); 
		    const password = passwordField.value.trim();
	        const address = addressField.value.trim();
		    const selectedRole = document.getElementById("selectedRole").value;

		    const namePattern = /^[A-Za-z\s]*$/;
		    const nameLengthPattern = /^[A-Za-z\s]{3,24}$/;
		    const emailPattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
		    const phonePattern = /^[6-9]\d{9}$/;
		    const passwordPattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,24}$/;
	        const addressPattern = /^[A-Za-z0-9\s.,#-/]+$/;
	        
	        if (!checkEmpty(firstName, firstNameField, "First name")) return;
	        if (!checkLength(nameLengthPattern, firstName, firstNameField, "First name")) return;
	        if (!checkPattern(namePattern, firstName, firstNameField, "Only letters are allowed in the First name field. Please remove any numbers or special characters.")) 
	        	return;
	        
	        if (!checkEmpty(lastName, lastNameField, "Last name")) return;
	        if (!checkLength(nameLengthPattern, lastName, lastNameField, "Last name")) return;
	        if (!checkPattern(namePattern, lastName, lastNameField, "Only letters are allowed in the Last name field. Please remove any numbers or special characters.")) 
	        	return;
	        
	        if (!checkEmpty(email, emailField, "Email")) return;
	        if (!checkPattern(emailPattern, email, emailField, "Email doesn't match the pattern. Ex:abc@gmail.com")) 
	        	return;
	        
	        if (!checkEmpty(phone, phoneField, "Phone number")) return;
	        if (!checkPattern(phonePattern, phone, phoneField, "No letters and characters. Start with 6,7,8 and 9. Only 10 digits")) 
	        	return;
	        
	        if (!checkEmpty(password, passwordField, "Password")) return;
	        if (!checkPattern(passwordPattern, password, passwordField, "Password doesn't match the pattern. The password must contain at least one capital letter, at least one small letter, at least one number and at least one special characters, minimum of eight and maximum of twenty four characters")) 
	        	return;
	        
	        if (selectedRole == "") {
	            alert("Please select a Role");
	            return;
	        }
	        
	        if (!checkEmpty(address, addressField, "Address")) return;
	        if (!checkPattern(addressPattern, address, addressField, "Please enter a valid address. Only alphanumeric characters, spaces, periods, commas, hashtags, and hyphens are allowed.")) 
	        	return;
	        
	        if (!checkEmpty(joiningDateInput.value, joiningDateInput, "Joining date")) return;
	       
	        document.querySelector(".form").submit();
	        
	    });
    
    </script>
    
</body>
</html>