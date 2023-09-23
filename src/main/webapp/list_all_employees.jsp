<%@page import="in.fssa.leavepulse.dto.EmployeeDTO"%>
<%@page import="in.fssa.leavepulse.model.Employee"%>
<%@page import="in.fssa.leavepulse.service.EmployeeService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="in.fssa.leavepulse.model.Role"%>
<%@page import="java.util.List"%>
<%@page import="in.fssa.leavepulse.service.RoleService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Employees Page</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/overlay.css">

</head>
<body id="body">

	<%
	List<EmployeeDTO> employeesList = (List<EmployeeDTO>) request.getAttribute("employeesList");
	%>
	<%
	List<Role> rolesList = (List<Role>) request.getAttribute("rolesList");
	%>

	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
	</div>

	<div class="body_section">

		<div class="sidebar_section">
			<jsp:include page="/sidebar.jsp" />
		</div>

		<script
			src="<%=request.getContextPath()%>/assets/js/toggleRoleContainer.js"></script>

		<div class="page_section">

			<div id="overlay_container">

				<div class="container">

					<div class="head_container">
						<div class="title_container">
							<h2>Employee Details</h2>
						</div>
						<div id="xmark_container">
							<i class="fa-solid fa-xmark"></i>
						</div>
					</div>

					<form action="employee?action=updaterole" method="post">

						<div class="fields_container">
							<div class="field_container">
								<label> First Name </label> <input type="text"
									class="non_editable_fields" id="first_name_field" readonly>
							</div>
							<div class="field_container">
								<label> Last Name </label> <input type="text"
									class="non_editable_fields" id="last_name_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Employee Id </label> <input type="text"
									class="non_editable_fields" name="employee_id" id="id_field"
									readonly>
							</div>
							<div class="field_container">
								<label> Email </label> <input type="text"
									class="non_editable_fields" id="email_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Manager</label> <input type="text"
									class="editable_fields" id="manager_id_field" name="manager_id"
									required readonly>
							</div>
							<div class="field_container role_field">
								<label> Role </label>
								<div class="select_tag_container">
									<button class="select_tag" type="button" id="role_field">
									</button>
									<i class="fa-solid fa-angle-down dropdown_icon"
										id="fa-angle-down"></i>
								</div>
							</div>
						</div>

						<input type="hidden" name="role" id="selectedRole" value="">

						<div class="role_type_container">
							<%
							for (Role role : rolesList) {
							%>
							<div class="role_container"
								onclick="selectRole( '<%=role.getRoleName()%>')">
								<p>
									<%=role.getRoleName()%>
								</p>
							</div>
							<%
							}
							%>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Phone </label> <input type="tel"
									class="non_editable_fields" id="phone_no_field" readonly>
							</div>
							<div class="field_container">
								<label> Joined Date </label> <input type="text"
									class="non_editable_fields" id="joined_date_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container address_field_container">
								<label> Address </label> <input type="text"
									class="non_editable_fields" id="address_field" readonly>
							</div>

						</div>

						<div class="form_btn_container">
							<button class="btn" type="button" id="edit_btn">Edit</button>
							<button class="btn" id="save_btn">Save</button>
							<button class="btn" type="button">
								<a id="delete_path"> Delete </a>
							</button>
						</div>

					</form>

				</div>

			</div>

			<div class="breadcrumbs_section">
				<jsp:include page="/breadcrumbs.jsp" />
			</div>

			<div class="main_section">
				<script
					src="<%=request.getContextPath()%>/assets/js/toggleFilterContainer.js"></script>
				<div class="table_container">
					<div class="table_header_container">
						<div class="table_heading_container">
							<h2>All Employees</h2>
						</div>
						<div class="search_container">
							<input type="search" placeholder="Search" class="search_bar">
							<i class="fa-solid fa-magnifying-glass"></i>
						</div>
						<div class="filter_container" onclick="toggleFilterContainer()">
							<button class="filter_btn">
								Filter by <i class="fa-solid fa-angle-down"></i>
							</button>
						</div>
					</div>

					<div class="filter_dropdown_container">
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Ascending Order</p>
							</div>
						</div>
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Descending Order</p>
							</div>
						</div>
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Minimum employees</p>
							</div>
						</div>
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Maximum employees</p>
							</div>
						</div>
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item">Name</div>
							<div class="header__item">Email</div>
							<div class="header__item">Manager</div>
							<div class="header__item">Role</div>
							<div class="header__item">Action</div>
						</div>
						<div class="table-content">
							<%
							int i = 1;
							%>
							<%
							for (EmployeeDTO employee : employeesList) {
							%>
							<div class="table-row">
								<div class="table-data">
									<%=i%>
								</div>
								<div class="table-data">
									<%=employee.getFirstName() + " " + employee.getLastName()%>
								</div>
								<div class="table-data">
									<%=employee.getEmail()%>
								</div>
								<div class="table-data">
									<%=employee.getManagerEmail()%>
								</div>
								<div class="table-data">
									<%=employee.getRoleName()%>
								</div>
								<div class="table-data">
									<button class="view_btn view"
										data-id="<%=employee.getEmployeeId()%>">View</button>
								</div>
							</div>
							<%
							i++;
							%>
							<%
							}
							%>
						</div>
					</div>

				</div>
			</div>

			<div class="footer_section">
				<jsp:include page="/footer.jsp" />
			</div>

		</div>

	</div>

	<script> 
    
		let employeesList = <%=employeesList%>;
    	
	    let view = document.querySelectorAll(".view");
	    let xmark_container = document.getElementById("xmark_container");
	    let edit_btn = document.getElementById("edit_btn");
	    let editable_fields = document.querySelectorAll(".editable_fields");
	    let non_editable_fields = document.querySelectorAll(".non_editable_fields");
	    let save_btn = document.getElementById("save_btn");
	    let select_tag_container = document.querySelector(".select_tag_container");
	    let dropdown_icon = document.querySelector(".dropdown_icon");
	    
	    let first_name_field = document.getElementById("first_name_field");
	    let last_name_field = document.getElementById("last_name_field");
	    let id_field = document.getElementById("id_field");
	    let email_field = document.getElementById("email_field");
	    let manager_id_field = document.getElementById("manager_id_field");
	    let role_field = document.getElementById("role_field");
	    let phone_no_field = document.getElementById("phone_no_field");
	    let joined_date_field = document.getElementById("joined_date_field");
	    let address_field = document.getElementById("address_field");
	    let selectedRole = document.getElementById("selectedRole");
	    let delete_path = document.getElementById("delete_path");
	    
	    // To open overlay container

	    view.forEach((e) => {
	    	e.addEventListener("click", () => {
	    		let id = e.getAttribute("data-id");
	    		let employee = employeesList.find((e) => e.employee_id == id);
	    		
		        document.getElementById("overlay_container").style.display = "flex";
		        document.getElementById("body").style.overflow = "hidden";
			        
		        first_name_field.value = employee.first_name;
		        last_name_field.value = employee.last_name;
		        id_field.value = employee.employee_id;
		        email_field.value = employee.email;
		        manager_id_field.value = employee.manager_id;
		        role_field.innerHTML = employee.roleName;
		        phone_no_field.value = employee.phone_no;
		        joined_date_field.value = employee.hire_date;
		        address_field.value = employee.address;
		        delete_path.setAttribute("href","employee?action=delete&id=" + employee.employee_id);
		    })
	    })
	
	    // To close overlay container
	    
	    xmark_container.addEventListener("click", () => {
	        document.getElementById("overlay_container").style.display = "none"
	        document.getElementById("body").style.overflow = "auto";
	        save_btn.style.display = "none";
	    	edit_btn.style.display = "block";
	    	editable_fields.forEach((e) => {
	    		e.setAttribute("readonly","readonly");
	    	})
	    	non_editable_fields.forEach((e) => {
	    		e.removeAttribute("id");
	    	})
	    	delete_path.removeAttribute("href");
	    	select_tag_container.removeAttribute("onclick");
	    	dropdown_icon.style.display = "none";
	        
	    })
	    
	    // Remove readonly while clicking edit button
	    
	    edit_btn.addEventListener("click", () => {
	    	editable_fields.forEach((e) => {
	    		e.removeAttribute("readonly");
	    	})
	    	non_editable_fields.forEach((e) => {
	    		e.setAttribute("id","non_editable_fields");
	    	})
	    	manager_id_field.focus();
	    	selectedRole.value = role_field.innerHTML;
	    	select_tag_container.setAttribute("onclick","toggleRoleSelectContainer()");
	    	dropdown_icon.style.display = "block";
	    	edit_btn.style.display = "none";
	    	save_btn.style.display = "block";
	    })
    
    </script>

</body>
</html>