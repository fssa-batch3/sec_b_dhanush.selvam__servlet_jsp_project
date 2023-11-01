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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Employees Page</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/overlay.css">

<style>
	.pop_up_container {
		z-index: 2;
	}
</style>
</head>
<body id="body">

	<% List<EmployeeDTO> employeesList = (List<EmployeeDTO>) request.getAttribute("employeesList"); %>
	<% List<Role> rolesList = (List<Role>) request.getAttribute("rolesList"); %>
	
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% Integer invalidEmployeeId = (Integer) request.getAttribute("employeeId"); %>
	<% String invalidRole = (String) request.getAttribute("role"); %>	

	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
	</div>
	
	<jsp:include page="/error_popup.jsp"/>

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

					<form id="form" action="employee?action=updaterole" method="post">

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
								<label for="manager_id_field"> Manager </label> <input type="text"
									class="editable_fields" id="manager_id_field" name="manager_id" autocomplete="off" required readonly>
							</div>
							<div class="field_container role_field">
								<label> Role </label>
								<div class="select_tag_container">
									<button class="select_tag" type="button" id="role_field"> </button>
									<i class="fa-solid fa-angle-down dropdown_icon" id="fa-angle-down"></i>
								</div>
							</div>
						</div>

						<input type="hidden" name="role" id="selectedRole" value="">

						<div class="role_type_container">
							<% for (Role role : rolesList) { %>
							<div class="role_container"
								onclick="selectRole( '<%=role.getRoleName()%>')">
								<p> <%=role.getRoleName()%> </p>
							</div>
							<% } %>
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
							<button class="btn" type="button" id="edit_btn"> Edit </button>
							<button class="btn" id="save_btn"> Save </button>
							<button class="btn" type="button" id="del_btn">
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
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="asc_order" onclick="handleCheckboxClick('asc_order')"> 
							<div class="field_name_container">
								<label for="asc_order"> Ascending Order </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="desc_order" onclick="handleCheckboxClick('desc_order')">
							<div class="field_name_container">
								<label for="desc_order"> Descending Order </label>
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
							<% int i = 1; %>
							<% for (EmployeeDTO employee : employeesList) { %>
							<div class="table-row">
								<div class="table-data"> <%=i%> </div>
								<div class="table-data"> <%=employee.getFirstName() + " " + employee.getLastName()%> </div>
								<div class="table-data"> <%=employee.getEmail()%> </div>
								<div class="table-data"> <%=employee.getManagerEmail()%> </div>
								<div class="table-data"> <%=employee.getRoleName()%> </div>
								<div class="table-data">
									<button class="view_btn view" data-id="<%=employee.getEmployeeId()%>">View</button>
								</div>
							</div>
							<% i++; %>
							<% } %>
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
    
		const employeesList = <%=employeesList%>;
		
		const tableContent = document.querySelector(".table-content");
		
  		if (employeesList.length == 0) noRecord(tableContent);
		
		else {
	    	
		    const view = document.querySelectorAll(".view");
		    const xmarkContainer = document.getElementById("xmark_container");
		    const editBtn = document.getElementById("edit_btn");
		    const editableFields = document.querySelectorAll(".editable_fields");
		    const nonEditableFields = document.querySelectorAll(".non_editable_fields");
		    const saveBtn = document.getElementById("save_btn");
		    const selectTagContainer = document.querySelector(".select_tag_container");
		    const dropdownIcon = document.querySelector(".dropdown_icon");
		    
		    const firstNameField = document.getElementById("first_name_field");
		    const lastNameField = document.getElementById("last_name_field");
		    const idField = document.getElementById("id_field");
		    const emailField = document.getElementById("email_field");
		    const managerIdField = document.getElementById("manager_id_field");
		    const roleField = document.getElementById("role_field");
		    const phoneNoField = document.getElementById("phone_no_field");
		    const joinedDateField = document.getElementById("joined_date_field");
		    const addressField = document.getElementById("address_field");
		    const selectedRole = document.getElementById("selectedRole");
		    const deletePath = document.getElementById("delete_path");
		    
		    const errorMessage = "<%= errorMessage %>";
			const invalidEmployeeId = "<%= invalidEmployeeId %>";
			const invalidRole = "<%= invalidRole %>";
					
			const popUpContainer = document.querySelector(".pop_up_container");
			const okayBtn = document.querySelector(".okay_btn");
			
			const search = document.querySelector(".search_bar");
						
			// To open overlay container
			
			let employee;
	
		    tableContent.addEventListener('click', (event) => {
	    		if (event.target.classList.contains('view_btn')) {
		    		const id = event.target.getAttribute("data-id");
		    		employee = employeesList.find((e) => e.employeeId == id);
		    		
			        document.getElementById("overlay_container").style.display = "flex";
			        document.getElementById("body").style.overflow = "hidden";
				        
			        firstNameField.value = employee.firstName;
			        lastNameField.value = employee.lastName;
			        idField.value = employee.employeeId;
			        emailField.value = employee.email;
			        managerIdField.value = employee.managerId;
			        roleField.innerHTML = employee.roleName;
			        phoneNoField.value = employee.phoneNo;
			        joinedDateField.value = employee.joiningDate;
			        addressField.value = employee.address;
			        deletePath.setAttribute("href","employee?action=delete&id=" + employee.employeeId);
			    };
		    })
		    
		    function isError(errorMessage) {
				if (errorMessage != "null") {
					document.getElementById("breadcrumbs_title").innerHTML = "Team Members";
					document.getElementById("breadcrumbs_path").innerHTML = "Dashboard > Manage Employee";
	  				history.replaceState(null, null, window.location.href.replace("?action=updaterole",""));
					document.querySelector(`button.view`).click();
					popUpContainer.style.display = "block";
					document.querySelector(".error_message").innerHTML = errorMessage;
					okayBtn.focus();
				}
			}
			
			isError(errorMessage);
			
			okayBtn.addEventListener("click", () => {
				popUpContainer.style.display = "none";
				editBtn.click();
				managerIdField.value = "";
	    		managerIdField.focus();
			})
		
		    // To close overlay container
		    
		    xmarkContainer.addEventListener("click", () => {
		        document.getElementById("overlay_container").style.display = "none"
		        document.getElementById("body").style.overflow = "auto";
		        saveBtn.style.display = "none";
		        editBtn.style.display = "block";
		        editableFields.forEach((e) => {
		    		e.setAttribute("readonly","readonly");
		    	})
		    	nonEditableFields.forEach((e) => {
		    		e.removeAttribute("id");
		    	})
		    	deletePath.removeAttribute("href");
		        selectTagContainer.removeAttribute("onclick");
		        dropdownIcon.style.display = "none";
		        selectedRole.value = "";
		    })
		    
		    // Remove readonly while clicking edit button
		    
		    editBtn.addEventListener("click", () => {
		    	editableFields.forEach((e) => {
		    		e.removeAttribute("readonly");
		    	})
		    	nonEditableFields.forEach((e) => {
		    		e.setAttribute("id","nonEditableFields");
		    	})
		    	managerIdField.focus();
		    	selectedRole.value = roleField.innerHTML;
		    	selectTagContainer.setAttribute("onclick","toggleRoleSelectContainer()");
		    	dropdownIcon.style.display = "block";
		    	editBtn.style.display = "none";
		    	saveBtn.style.display = "block";
		    })
		    
		    saveBtn.addEventListener("click", (e) => {
		    	e.preventDefault();
		    	
		    	const managerId = managerIdField.value;
		    	
		    	if (employee.managerId == managerId && employee.roleName === selectedRole.value) {
			    	location.reload();
			    	return;
			    }
		    	
		    	if (managerId < 1) {
		    		alert("Invalid Manager Id");
		    		managerIdField.value = "";
		    		managerIdField.focus();
		    		return;
		    	}
		    	
				const numPattern = /^[0-9]+$/;
			    
			    if (!numPattern.test(managerId)) {
			        alert("Only numbers are allowed");
			        managerIdField.value = "";
			        managerIdField.focus();
			        return;
			    }
			    
		    	document.querySelector("#form").submit();
		    	
		    })
		    		    
		    // Search
		    
		    function createRow(i, employee) {
				
				const row = document.createElement('div');
			  	row.classList.add('table-row');
	
			  	const data1 = document.createElement('div');
			  	data1.textContent = i;
			  	data1.classList.add('table-data');
	
			  	const data2 = document.createElement('div');
			  	data2.classList.add('table-data');
			  	data2.textContent = employee.firstName + " " + employee.lastName;
	
			  	const data3 = document.createElement('div');
			  	data3.classList.add('table-data');
			  	data3.textContent = employee.email;
			  	
			  	const data4 = document.createElement('div');
			  	data4.classList.add('table-data');
			  	data4.textContent = employee.managerEmail;
			  	
			  	const data5 = document.createElement('div');
			  	data5.classList.add('table-data');
			  	data5.textContent = employee.roleName;
	
			  	const data6 = document.createElement('div');
			  	data6.classList.add('table-data');
			  	const viewButton = document.createElement('button');
			  	viewButton.classList.add('view_btn');
			  	viewButton.classList.add('view');
			  	viewButton.setAttribute('data-id', employee.employeeId);
			  	viewButton.textContent = 'View';
			  	data6.appendChild(viewButton);
	
			  	row.appendChild(data1);
			  	row.appendChild(data2);
			  	row.appendChild(data3);
			  	row.appendChild(data4);
			  	row.appendChild(data5);
			  	row.appendChild(data6);
	
			  	tableContent.appendChild(row);
			}
			
			function defaultOrder() {
				tableContent.innerHTML = "";
		        let i = 1;
		        employeesList.sort((a,b) => {
		        	  return a.employeeId - b.employeeId;
		        	})
		        employeesList.forEach((employee) => {
		            createRow(i, employee);
		            i++;
		        });
			}
			
			let searchedEmployees = [];
			
			search.addEventListener("focus",() => {
				scroll(150);
			})
			
			search.addEventListener("input", () => {
				
				const value = search.value.toLowerCase().trim();
				
				searchedEmployees = employeesList.filter((employee) => {
				    const employeeName = employee.firstName.toLowerCase() + employee.lastName.toLowerCase();
				    const employeeEmail = employee.email.toLowerCase();
				    const managerEmail = employee.managerEmail.toLowerCase();
				    const roleName = employee.roleName.toLowerCase();
				    const searchValue = value.toLowerCase();
				
				    return employeeName.includes(searchValue) || employeeEmail.includes(searchValue) || managerEmail.includes(searchValue) || roleName.includes(searchValue);
				});
	
				tableContent.innerHTML = "";
				
				if (searchedEmployees.length != 0) {
					let i = 1;
					searchedEmployees.forEach((employee) => {
					  createRow(i, employee);
					  i++;
					});
				}
				
				else noRecord(tableContent)
					
				scroll(150);
			})
			
			// Sort
			
			const ascOrder = document.querySelector("#asc_order");
			const descOrder = document.querySelector("#desc_order");
			
			function sortByEmployeeName(sortOrder, tableContent, employeesList) {
				
				employeesList.sort((a, b) => {
			        const nameA = a.firstName.toLowerCase();
			        const nameB = b.firstName.toLowerCase();
			        const comparison = sortOrder === 'asc' ? 1 : -1;
			        return nameA.localeCompare(nameB) * comparison;
			    });
			
			    tableContent.innerHTML = '';
			    let i = 1;
			    employeesList.forEach((employee) => {
			        createRow(i, employee);
			        i++;
			    });
			    
			}
			
			ascOrder.addEventListener('change', () => {
			    if (ascOrder.checked)
			    	sortByEmployeeName('asc', tableContent, employeesList);
			    else
			        defaultOrder(tableContent, employeesList);
			    scroll(150);
			});
			
			descOrder.addEventListener('change', () => {
			    if (descOrder.checked)
			    	sortByEmployeeName('desc', tableContent, employeesList);
			    else
			        defaultOrder(tableContent, employeesList);
			    scroll(150);
			});
			
		}
	    	
    </script>

</body>
</html>