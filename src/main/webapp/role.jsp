<%@page import="in.fssa.leavepulse.model.Role"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Role Page</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/roleleave.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">
</head>
<body>

	<% List<Role> rolesList = (List<Role>) request.getAttribute("rolesList"); %>
	<% int lastRoleId = (int) request.getAttribute("lastRoleId"); %>
	
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% String invalidRoleName = (String) request.getAttribute("roleName"); %>
	<% Integer invalidRoleId = (Integer) request.getAttribute("roleId"); %>	
	
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
			
				<div class="form_container">
				
					<h2 class="breadcrumbs" id="action_title"> Add Role </h2>
					<form action="role" class="form" method="post">
						<div class="field_container">
							<label for="name_field"> Role Name </label> 
							<input id="name_field" name="role_name" autocomplete="off" type="text" tabindex=1>
						</div>
						<div class="field_container">
							<label> Role Id </label> 
							<input id="id_field" type="text" autocomplete="off" name="role_id" readonly>
						</div>
						<div>
							<button class="submit_btn" tabindex=2> Submit </button>
						</div>
					</form>
					
				</div>

				<div class="table_container">
					<div class="table_header_container">
						<div class="table_heading_container">
							<h2> Role List </h2>
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
								<label class="filter_label" for="asc_order"> Ascending Order </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="desc_order" onclick="handleCheckboxClick('desc_order')">
							<div class="field_name_container">
								<label class="filter_label" for="desc_order"> Descending Order </label>
							</div>
						</div>
						<!-- <div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="min_emp">
							<div class="field_name_container">
								<label class="filter_label" for="min_emp"> Minimum employees </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="max_emp">
							<div class="field_name_container">
								<label class="filter_label" for="max_emp"> Maximum employees </label>
							</div>
						</div> -->
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item"> Role </div>
							<div class="header__item"> Role Id </div>
							<div class="header__item">Edit</div>
							<div class="header__item">Delete</div>
						</div>
						<div class="table-content">
							<% int i = 1; %>
							<% for (Role role : rolesList) { %>
								<div class="table-row">
									<div class="table-data"> <%=i%> </div>
									<div class="table-data"> <%=role.getRoleName()%> </div>
									<div class="table-data"> <%=role.getRoleId()%> </div>
									<div class="table-data"> <button class="edit_btn" data-id="<%=role.getRoleId()%>"> Edit</button> </div>
									<div class="table-data"> 
										<a href="role?action=delete&id=<%=role.getRoleId()%>">
											<button class="delete_btn">Delete</button>
										</a>
									</div>
								</div>
							<% i++; %>
							<% } %>
						</div>
						
					</div>

				</div>

				<script src="<%=request.getContextPath()%>/assets/js/toggleFilterContainer.js"></script>
			</div>

			<div class="footer_section">
				<jsp:include page="/footer.jsp" />
			</div>

		</div>

	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	
		const rolesList = <%= rolesList %>;

		const tableContent = document.querySelector(".table-content");

  		if (rolesList.length == 0) noRecord(tableContent);

		else {
			
			const nameField = document.getElementById("name_field");
			const idField = document.getElementById("id_field");
			const editBtn = document.querySelectorAll(".edit_btn_container");
			
			const errorMessage = "<%= errorMessage %>";
			const invalidRoleName = "<%= invalidRoleName %>";
			const invalidRoleId = "<%= invalidRoleId %>";
	
			const popUpContainer = document.querySelector(".pop_up_container");
			const okayBtn = document.querySelector(".okay_btn");
			
			const search = document.querySelector(".search_bar");
					
			let isEditClicked = false;
			
			function isError(errorMessage) {
				if (errorMessage != "null") {
					popUpContainer.style.display = "block";
					document.querySelector(".error_message").innerHTML = errorMessage;
					nameField.value = "";
					idField.value = invalidRoleId;
					if (<%= lastRoleId + 1 %> != invalidRoleId) isEditClicked = true;
					okayBtn.focus();
				}
			}
			
			isError(errorMessage);
			
			okayBtn.addEventListener("click", () => {
				popUpContainer.style.display = "none";
				nameField.focus();
				return;
			});
			
			const actionTitle = document.getElementById("action_title");
			
			// Edit function
			
			let roleName;
			
			tableContent.addEventListener('click', (event) => {
	    		if (event.target.classList.contains('edit_btn')) {
					const id = event.target.getAttribute("data-id");
					isEditClicked = true;
					if (idField.value !== id){
						actionTitle.innerText = "Edit Role";
						idField.value = id;
						roleName = rolesList.find((e) => e.roleId == id).roleName;
						nameField.value = roleName;
						nameField.focus();
					}
			        else {
			        	actionTitle.innerText = "Add Role";
			        	idField.value = "";
			        	nameField.value = "";
			        	isEditClicked = false;
			        }
					scroll(0);
	    		}
			});	
			
			// Generate Id
			
			nameField.addEventListener("input", function () {
				const value = nameField.value.trim();
				if (value.length > 2 && !isEditClicked) {
					idField.value = <%= lastRoleId + 1 %>;
				}
				else if (value.length == 0 && !isEditClicked) idField.value = "";
			})
				
			document.querySelector(".submit_btn").addEventListener("click",(e) => {
					
		        e.preventDefault();
		
			    const name = nameField.value.trim();
			    
			    if (roleName === name) {
			    	location.reload();
			    	return;
			    }
			    
			    if (name == "") {
			    	alert("Role name cannot be empty");
			    	nameField.value = "";
			    	nameField.focus();
			    	return;
			    }
			    		    
			    const charPattern = /^[A-Za-z\s]*$/;
			    const countPattern = /^[A-Za-z\s]{3,24}$/;
			
			    if (!charPattern.test(name)) {
			        alert("Only letters are allowed in the Role name field. Please remove any numbers or special characters.");
			        nameField.value = "";
			        nameField.focus();
			        if(isEditClicked == false)
			    		idField.value = "";
			        return;
			    }
			    
			    if (!countPattern.test(name)) {
			    	alert("Role name should contain a minimum of 3 letters and a maximum of 24 letters.");
			        nameField.focus();
			        if(isEditClicked == false)
			    		idField.value = "";
			        return;
			    }
			  
			    document.querySelector(".form").submit();
				
			})
			
			// Search 
			
			function createRow(i, role) {
				
				const row = document.createElement('div');
			  	row.classList.add('table-row');
	
			  	const data1 = document.createElement('div');
			  	data1.textContent = i;
			  	data1.classList.add('table-data');
	
			  	const data2 = document.createElement('div');
			  	data2.classList.add('table-data');
			  	data2.textContent = role.roleName;
	
			  	const data3 = document.createElement('div');
			  	data3.classList.add('table-data');
			  	data3.textContent = role.roleId;
	
			  	const data4 = document.createElement('div');
			  	data4.classList.add('table-data');
			  	const editButton = document.createElement('button');
			  	editButton.classList.add('edit_btn');
			  	editButton.setAttribute('data-id', role.roleId);
			  	editButton.textContent = 'Edit';
			  	data4.appendChild(editButton);
	
			  	const data5 = document.createElement('div');
			  	data5.classList.add('table-data');
			  	const deleteButton = document.createElement('button');
			  	deleteButton.classList.add('delete_btn');
			  	const deleteLink = document.createElement('a');
			  	deleteLink.href = "role?action=delete&id=" + role.roleId;
			  	deleteButton.textContent = 'Delete';
			  	deleteLink.appendChild(deleteButton);
			  	data5.appendChild(deleteLink);
	
			  	row.appendChild(data1);
			  	row.appendChild(data2);
			  	row.appendChild(data3);
			  	row.appendChild(data4);
			  	row.appendChild(data5);
	
			  	tableContent.appendChild(row);
			}
			
			function defaultOrder() {
				tableContent.innerHTML = "";
		        let i = 1;
		        rolesList.sort((a,b) => {
		        	  return a.roleId - b.roleId;
		        	})
		        rolesList.forEach((role) => {
		            createRow(i, role);
		            i++;
		        });
			}
			
			let searchedRoles = [];
			
			search.addEventListener("focus",() => {
				scroll(320);
			})
			
			search.addEventListener("input", () => {
				
				const value = search.value.toLowerCase().trim();
				
				searchedRoles = rolesList.filter((role) => {
				    const roleName = role.roleName.toLowerCase();
				    const roleId = role.roleId.toString().toLowerCase();
				    const searchValue = value.toLowerCase();
				
				    return roleName.includes(searchValue) || roleId.includes(searchValue);
				});
	
				tableContent.innerHTML = "";
				
				if (searchedRoles.length != 0) {
					let i = 1;
					searchedRoles.forEach((role) => {
					  createRow(i, role);
					  i++;
					});
				}
				
				else noRecord(tableContent)
				
				scroll(320);
			})
			
			// Sort
			
			const ascOrder = document.querySelector("#asc_order");
			const descOrder = document.querySelector("#desc_order");
			
			function sortByRoleName(sortOrder, tableContent, rolesList) {
				
			    rolesList.sort((a, b) => {
			        const nameA = a.roleName.toLowerCase();
			        const nameB = b.roleName.toLowerCase();
			        const comparison = sortOrder === 'asc' ? 1 : -1;
			        return nameA.localeCompare(nameB) * comparison;
			    });
			
			    tableContent.innerHTML = '';
			    let i = 1;
			    rolesList.forEach((role) => {
			        createRow(i, role);
			        i++;
			    });
			    
			}
			
			ascOrder.addEventListener('change', () => {
			    if (ascOrder.checked)
			    	sortByRoleName('asc', tableContent, rolesList);
			    else
			        defaultOrder(tableContent, rolesList);
			    scroll(320);
			});
			
			descOrder.addEventListener('change', () => {
			    if (descOrder.checked)
			    	sortByRoleName('desc', tableContent, rolesList);
			    else
			        defaultOrder(tableContent, rolesList);
			    scroll(320);
			});
			
		}
	
	</script>

</body>
</html>