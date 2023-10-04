<%@page import="in.fssa.leavepulse.dto.EmployeeDTO"%>
<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/profile.css">

<title>Profile</title>
</head>
<body>

	<% EmployeeDTO employee = (EmployeeDTO) request.getAttribute("EMPLOYEEDETAILS"); %>

	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
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
						<form action="employee?action=update" method="post">
						
							<input type="hidden" name="employee_id" value = <%= employee.getEmployeeId() %>>
							<input type="hidden" name="email" value = <%= employee.getEmail() %>>
							
							<div class="fields_container">
								<div class="field_container">
									<label> First Name </label> <input name = "first_name" class="apply_leave_inputs editable_fields" id="first_field" value="<%= employee.getFirstName() %>" readonly type="text">
								</div>
								<div class="field_container">
									<label> Last Name </label> <input name = "last_name" class="apply_leave_inputs editable_fields" value="<%= employee.getLastName() %>" readonly type="text">
								</div>
							</div>
							<div class="fields_container">
								<div class="field_container">
									<label> Phone No </label> <input name = "phone_no" class="apply_leave_inputs editable_fields" value="<%= employee.getPhoneNo() %>" readonly type="text">
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
							<div class="fields_container">
								<div class="field_container">
									<label> Password </label> 
									<input name="password" class="apply_leave_inputs non_editable_fields" id="password_field" value="<%= employee.getPassword() %>" readonly type="password">
									<div class = "eye_container"> <i class="fa-solid fa-eye"></i> <i class="fa-solid fa-eye-slash"></i> </div> 
								</div>
								<div class="field_container">
									<label> Address </label> <input name="address" class="apply_leave_inputs editable_fields" value="<%= employee.getAddress() %>" readonly type="text">
								</div>
							</div>
							<div class="edit_btn_container">
								<button class="edit_btn" type="button"> Edit </button>
								<button class="save_btn"> Save </button>
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
	
		let eye_icon = document.querySelector(".fa-eye");
		let eye_slash_icon = document.querySelector(".fa-eye-slash");
		let password_field = document.getElementById("password_field");
		
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
	
		let edit_btn = document.querySelector(".edit_btn");
		let save_btn = document.querySelector(".save_btn");
		let editable_fields = document.querySelectorAll(".editable_fields");
		let non_editable_fields = document.querySelectorAll(".non_editable_fields")
		let first_field = document.getElementById("first_field");
		
		edit_btn.addEventListener("click",() => {
			editable_fields.forEach((e) => {
				e.removeAttribute("readonly");
			})
			non_editable_fields.forEach((e) => {
				e.setAttribute("id","non_editable_fields");
			})
			edit_btn.style.display = "none";
			save_btn.style.display = "block";
			 first_field.focus();
		})
	
	</script>

</body>
</html>