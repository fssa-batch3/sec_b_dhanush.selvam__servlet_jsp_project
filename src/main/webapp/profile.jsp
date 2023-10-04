<%@page import="in.fssa.leavepulse.dto.EmployeeDTO"%>
<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/profile.css">

<title>Profile</title>
</head>
<body>

	<% EmployeeDTO employee = (EmployeeDTO) request.getAttribute("loginEmployee"); %>
	
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% Employee invalidEmployee = (Employee) request.getAttribute("employee"); %>	
	
	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
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

				<div class="user_profile_container">

					<div class="left_container">
						<div class="profile_image_container">
							<img src="<%=request.getContextPath()%>/assets/images/profile.jpg" class="profile_img">
						</div>
						<div class="info_container">
							<p> <%= employee.getEmployeeId() %> </p>
							<div class="email_container">
								<p> <%= employee.getEmail() %> </p>
							</div>
						</div>
					</div>

					<div class="right_container">
						<form class="form" action="employee?action=update" method="post">
						
							<input type="hidden" name="employee_id" value = <%= employee.getEmployeeId() %>>
							<input type="hidden" name="email" value = <%= employee.getEmail() %>>
							
							<div class="fields_container">
								<div class="field_container">
									<label> First Name </label> <input autocomplete="off" name = "first_name" id="first_name_field" class="apply_leave_inputs editable_fields" id="first_field" value="<%= employee.getFirstName() %>" readonly type="text">
								</div>
								<div class="field_container">
									<label> Last Name </label> <input autocomplete="off" name = "last_name" id="last_name_field" class="apply_leave_inputs editable_fields" value="<%= employee.getLastName() %>" readonly type="text">
								</div>
							</div>
							<div class="fields_container">
								<div class="field_container">
									<label> Phone No </label> <input name = "phone_no" autocomplete="off" class="apply_leave_inputs editable_fields" value="<%= employee.getPhoneNo() %>" readonly type="text" id="phone_no_field">
								</div>
								<div class="field_container">
									<label> Role </label> <input class="apply_leave_inputs non_editable_fields" value="<%= employee.getRoleName() %>" readonly type="text">
								</div>
							</div>
							<div class="fields_container">
								<div class="field_container">
									<label> Manager </label> <input class="apply_leave_inputs non_editable_fields" value="<%= employee.getManagerEmail() %>" readonly type="text">
								</div>
								<div class="field_container">
									<label> Joined Date </label> <input class="apply_leave_inputs non_editable_fields" value="<%= employee.getJoiningDate() %>" readonly type="text">
								</div>
							</div>
							<div class="fields_container address">
								<div class="field_container">
									<label> Address </label> <input name="address" autocomplete="off" id="address_field" class="apply_leave_inputs editable_fields" value="<%= employee.getAddress() %>" readonly type="text">
								</div>
								<div class="edit_btn_container">
									<button class="edit_btn" type="button"> Edit </button>
									<button class="save_btn"> Save </button>
								</div>
							</div>
							
						</form>
					</div>

				</div>

			</div>

			<div class="footer_section">
				<jsp:include page="/footer.jsp" />
			</div>

		</div>

	</div>
	
	<script>
	
		const firstNameField = document.querySelector("#first_name_field");
	    const lastNameField = document.querySelector("#last_name_field");
		const phoneNoField = document.querySelector("#phone_no_field") 
	    const addressField = document.querySelector("#address_field");

		const errorMessage = "<%= errorMessage %>";
		const invalidEmployee = <%= invalidEmployee %>;
	
		const popUpContainer = document.querySelector(".pop_up_container");
		const okayBtn = document.querySelector(".okay_btn");
				
		function isError(errorMessage) {
			if (errorMessage != "null") {
				popUpContainer.style.display = "block";
				document.querySelector(".error_message").innerHTML = errorMessage;
				firstNameField.value = invalidEmployee.firstName;
				lastNameField.value = invalidEmployee.LastName;
				addressField.value = invalidEmployee.address;
				phoneNoField.value = "";
				okayBtn.focus();
			}
		}
		
		isError(errorMessage);
		
		okayBtn.addEventListener("click", () => {
			popUpContainer.style.display = "none";
			phoneNoField.focus();
			return;
		})
	
		let edit_btn = document.querySelector(".edit_btn");
		let save_btn = document.querySelector(".save_btn");
		let editable_fields = document.querySelectorAll(".editable_fields");
		let non_editable_fields = document.querySelectorAll(".non_editable_fields")
		
		edit_btn.addEventListener("click",() => {
			editable_fields.forEach((e) => {
				e.removeAttribute("readonly");
			})
			non_editable_fields.forEach((e) => {
				e.setAttribute("id","non_editable_fields");
			})
			edit_btn.style.display = "none";
			save_btn.style.display = "block";
			firstNameField.focus();
		})
		
		save_btn.addEventListener("click", (e) => {
	    	
	    	e.preventDefault();
	    	
			const firstName = firstNameField.value.trim();

		    if (firstName == "") {
		    	alert("First name cannot be empty");
		    	firstNameField.focus();
		    	return;
		    }
		    
		    const namePattern = /^[A-Za-z\s]{3,24}$/;
		
		    if (!namePattern.test(firstName)) {
		        alert("Only letters are allowed in this field. Please remove any numbers or special characters.");
		        firstNameField.value = "";
		        firstNameField.focus();
		        return;
		    }
		    
			const lastName = lastNameField.value.trim();

		    if (lastName == "") {
		    	alert("Last name cannot be empty");
		    	lastNameField.focus();
		    	return;
		    }
		    		
		    if (!namePattern.test(lastName)) {
		        alert("Only letters are allowed in this field. Please remove any numbers or special characters.");
		        lastNameField.value = "";
		        lastNameField.focus();
		        return;
		    }
		   
		    const phone = phoneNoField.value.trim(); 

		    if (phone == "") {
		    	alert("Phone No cannot be empty");
		    	phoneNoField.focus();
		    	return;
		    }

		    const phonePattern = /^[6-9]\d{9}$/;
		
		    if (!phonePattern.test(phone)) {
		        alert("No letters and characters. Start with 6,7,8 and 9. Only 10 digits");
		        phoneNoField.value = "";
		        phoneNoField.focus();
		        return;
		    }
		    
		    const address = addressField.value.trim();

	        if (address == "") {
		    	alert("Address cannot be empty");
		    	addressField.focus();
		    	return;
		    }
	        
	        const addressPattern = /^[A-Za-z0-9\s.,#-/]+$/;
	        
	        if (!addressPattern.test(address)) {
	            alert("Please enter a valid address. Only alphanumeric characters, spaces, periods, commas, hashtags, and hyphens are allowed.");
	            addressField.value = "";
	            addressField.focus();
		        return;
		    }
	        
	        document.querySelector(".form").submit();
	        
	    });
	
	</script>

</body>
</html>