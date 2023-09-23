<%@page import="in.fssa.leavepulse.model.Leave"%>
<%@page import="java.util.List"%>
<%@page import="in.fssa.leavepulse.model.Role"%>



<% List<Role> rolesList = null; %>
<% int lastRoleId = 0; %>

<% List<Leave> leavesList = null; %>
<% int lastLeaveId = 0; %>

<% String fileName = (String) request.getParameter("type"); %>

<% if(fileName.equals("role")) { %>
	<% rolesList = (List<Role>) request.getAttribute("rolesList"); %>
	<% lastRoleId = Integer.parseInt(request.getParameter("lastRoleId")); %>	
	<% } %>

<% if(fileName.equals("leave")) { %>
	<% leavesList = (List<Leave>) request.getAttribute("leavesList"); %>
	<% lastLeaveId = Integer.parseInt(request.getParameter("lastLeaveId")); %>
<% } %>

<div class="form_container">
	<h2 class="breadcrumbs" id="createFormTitle"> </h2>
	<form action class="form" =<%= fileName %> method="post">
		<div class="field_container">
			<label id = "createFormField1"> </label> <input id="name_field" name="<%= fileName %>_name" type="text">
		</div>
		<div class="field_container">
			<label id = "createFormField2"> </label> <input id="id_field" type="text" name="<%= fileName %>_id" readonly>
		</div>
		<div class="submit_btn_container">
			<button class="submit_btn">Submit</button>
		</div>
	</form>
</div>

<div class="table_container">
	<div class="table_header_container">
		<div class="table_heading_container">
			<h2 id = "tableTitle"> </h2>
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
			<input type="checkbox" class="checkbox">
			<div class="field_name_container">
				<p>Ascending Order</p>
			</div>
		</div>
		<div class="filter_field_container" onclick="stopPropagation(event)">
			<input type="checkbox" class="checkbox">
			<div class="field_name_container">
				<p>Descending Order</p>
			</div>
		</div>
		<div class="filter_field_container min_emp_filter_container"
			onclick="stopPropagation(event)">
			<input type="checkbox" class="checkbox">
			<div class="field_name_container">
				<p>Minimum employees</p>
			</div>
		</div>
		<div class="filter_field_container min_emp_filter_container"
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
			<div class="header__item" id = "columnTitle1"> </div>
			<div class="header__item" id = "columnTitle2"></div>
			<div class="header__item"> Edit </div>
			<div class="header__item"> Delete </div>
		</div>
		<div class="table-content">
			<% if (fileName.equals("role")) { %>
				<% int i = 1; %>
				<% for (Role role : rolesList) { %>
					<div class="table-row">
						<div class="table-data"> <%= i %> </div>
			            <div class="table-data"> <%= role.getRoleName() %> </div>
			            <div class="table-data"> <%= role.getRoleId() %> </div>
			            <div class="table-data"> <button class="edit_btn" data-id="<%= role.getRoleId() %>"> Edit </button> </div>			            
       			        <div class="table-data"> <a href="role?action=delete&id=<%= role.getRoleId() %>"> <button class="delete_btn" > Delete </button> </a> </div>
		            </div>
	            <% i++; %>
	            
				<% } %>
			<% } %>
			<% if (fileName.equals("leave")) { %>
				<% int i = 1; %>
				<% for (Leave leave : leavesList) { %>
					<div class="table-row">
						<div class="table-data"> <%= i %> </div>
			            <div class="table-data"> <%= leave.getLeaveType() %> </div>
			            <div class="table-data"> <%= leave.getLeaveId() %> </div>
			            <div class="table-data" id="edit"> <button class="edit_btn" data-id="<%= leave.getLeaveId() %>"> Edit </button> </div>
                		<div class="table-data"> <a href="leave?action=delete&id=<%= leave.getLeaveId() %>"> <button class="delete_btn" > Delete </button> </a> </div>
		            </div>
	            <% i++; %>
				<% } %>
			<% } %>
		</div>
	</div>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	let rolesList = <%= rolesList %>;
	let leavesList = <%= leavesList %>;

	if (fileName == "role") {
		
		document.getElementById("createFormTitle").innerHTML = createFormTitle;
		document.getElementById("createFormField1").innerHTML = createFormField1;
		document.getElementById("createFormField2").innerHTML = createFormField2;
		document.getElementById("tableTitle").innerHTML = tableTitle;
		document.getElementById("columnTitle1").innerHTML = columnTitle1;
		document.getElementById("columnTitle2").innerHTML = columnTitle2;
	
	}
	
	if (fileName == "leave") {
	    
		document.getElementById("createFormTitle").innerHTML = createFormTitle;
		document.getElementById("createFormField1").innerHTML = createFormField1;
		document.getElementById("createFormField2").innerHTML = createFormField2;
		document.getElementById("tableTitle").innerHTML = tableTitle;
		document.getElementById("columnTitle1").innerHTML = columnTitle1;
		document.getElementById("columnTitle2").innerHTML = columnTitle2;
		
	    const minEmpFilterContainers = document.querySelectorAll(".min_emp_filter_container");
	    minEmpFilterContainers.forEach(container => {
	        container.style.display = "none";
	    });  
	    
	}	
	
	let name_field = document.getElementById("name_field");
	let id_field = document.getElementById("id_field");
	let edit_btn = document.querySelectorAll(".edit_btn");
	
	let isEditClicked = false;
				
	// Edit function
	
	edit_btn.forEach((e) => {
		e.addEventListener("click", function () {
			let id = e.getAttribute("data-id");
			isEditClicked = true;
			if (id_field.value !== id){
				id_field.value = id;
				if (fileName == "role") {
					let role_name = rolesList.find((e) => e.role_id == id).role_name;
					name_field.value = role_name;
				}
				if (fileName == "leave") {
					let leave_type = leavesList.find((e) => e.leave_id == id).leave_type;
					name_field.value = leave_type;
				}
				name_field.focus();
			}
	        else {
	        	id_field.value = "";
	        	name_field.value = "";
	        	isEditClicked = false;
	        }
			window.scrollTo({
		        top: 0,
		        behavior: "smooth"
		    });
			
		})
	})		
	
	// Generate Id
	
	name_field.addEventListener("input", function () {
		let value = name_field.value.trim();
		if (value.length > 2 && !isEditClicked) {
			if (fileName == "role") id_field.value = <%= lastRoleId + 1 %>;
			if (fileName == "leave") id_field.value = <%= lastLeaveId + 1 %>;
		}
		else if (value.length == 0 && !isEditClicked) id_field.value = "";
	})
		
	document.querySelector(".submit_btn").addEventListener("click",(e) => {
			
        e.preventDefault();

	    const name = name_field.value.trim();
	    
	    if (name == "") {
	    	alert(document.getElementById("createFormField1").innerHTML + " cannot be empty");
	    	name_field.focus();
	    	return;
	    }
	    
	    const pattern = /^[A-Za-z\s]{3,24}$/;
	
	    if (!pattern.test(name)) {
	        alert("Only letters are allowed in this field. Please remove any numbers or special characters.");
	        name_field.focus();
	        return;
	    }
		
	})
	
		
</script>

