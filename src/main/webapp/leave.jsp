<%@page import="in.fssa.leavepulse.model.Leave"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Leave Page</title>

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

	<% List<Leave> leavesList = (List<Leave>) request.getAttribute("leavesList"); %>
	<% int lastLeaveId = (int) request.getAttribute("lastLeaveId"); %>

	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% Integer invalidLeaveDays = (Integer) request.getAttribute("leaveDays"); %>
	<% Integer invalidLeaveId = (Integer) request.getAttribute("leaveId"); %>	
	
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
			
				<div class="form_container">
				
					<h2 class="breadcrumbs"> New Leave </h2>
					<form action="leave" class="form leave_form" method="post">
						<div class="fields_container">
							<div class="field_container leave_field_container">
								<label> Leave Name </label> <input class="leave_fields" id="name_field"
									name="leave_name" autocomplete="off" type="text">
							</div>
							<div class="field_container leave_field_container">
								<label> Leave Days </label> <input class="leave_fields" id="days_field"
									type="text" autocomplete="off" name="leave_days">
							</div>
							<div class="field_container leave_field_container">
								<label> Leave Id </label> <input class="leave_fields" id="id_field"
									type="text" name="leave_id" autocomplete="off" readonly>
							</div>
						</div>
						<div class="submit_btn_container">
							<button class="submit_btn">Submit</button>
						</div>
					</form>
					
				</div>

				<div class="table_container">
					<div class="table_header_container">
						<div class="table_heading_container">
							<h2> Leave List </h2>
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
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item">Leave</div>
							<div class="header__item">Leave Id</div>
							<div class="header__item">Leave Days</div>
							<div class="header__item">Edit</div>
							<div class="header__item">Delete</div>
						</div>
						<div class="table-content">
							<% int i = 1; %>
							<% for (Leave leave : leavesList) { %>
							<div class="table-row">
								<div class="table-data"> <%= i %> </div>
								<div class="table-data"> <%=leave.getLeaveType()%> </div>
								<div class="table-data"> <%=leave.getLeaveId()%> </div>
								<div class="table-data"> <%=leave.getLeaveDays() %> </div>
								<div class="table-data"> <button class="edit_btn" data-id="<%=leave.getLeaveId()%>"> Edit</button> </div>
								<div class="table-data">
									<a href="leave?action=delete&id=<%=leave.getLeaveId()%>">
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
	
	<script>
	
		let leavesList = <%= leavesList %>;
		
		let nameField = document.getElementById("name_field");
		let idField = document.getElementById("id_field");
		let daysField = document.getElementById("days_field");
		let editBtn = document.querySelectorAll(".edit_btn");
		
		const errorMessage = "<%= errorMessage %>";
		const invalidLeaveDays = "<%= invalidLeaveDays %>";
		const invalidLeaveId = "<%= invalidLeaveId %>";
		
		const popUpContainer = document.querySelector(".pop_up_container");
		const okayBtn = document.querySelector(".okay_btn");
		
		let isEditClicked = false;

		function isError(errorMessage) {
			if (errorMessage != "null") {
				popUpContainer.style.display = "block";
				document.querySelector(".error_message").innerHTML = errorMessage;
				nameField.value = "";
				daysField.value = invalidLeaveDays;
				idField.value = invalidLeaveId;
				if (<%= lastLeaveId + 1 %> != invalidLeaveId) isEditClicked = true;
				okayBtn.focus();
			}
		}
		
		isError(errorMessage);
		
		okayBtn.addEventListener("click", () => {
			popUpContainer.style.display = "none";
			nameField.focus();
			return;
		})
							
		// Edit function
		
		editBtn.forEach((e) => {
			e.addEventListener("click", function () {
				
				let id = e.getAttribute("data-id");
				isEditClicked = true;
				if (idField.value !== id){
					duplicateLeavesList = leavesList;
					idField.value = id;
					let leave = leavesList.find((e) => e.leaveId == id);
					nameField.value = leave.leaveType;
					daysField.value = leave.leaveDays;
					nameField.focus();
				}				
		        else {
		        	idField.value = "";
		        	nameField.value = "";
		        	daysField.value = "";
		        	isEditClicked = false;
		        }
				
				window.scrollTo({
			        top: 0,
			        behavior: "smooth"
			    });
										
			})
		})		
		
		// Generate Id
		
		nameField.addEventListener("input", function () {
			let value = nameField.value.trim();
			if (value.length > 2 && !isEditClicked) {
				idField.value = <%= lastLeaveId + 1 %>;
			}
			else if (value.length == 0 && !isEditClicked) idField.value = "";
		})
					
		document.querySelector(".submit_btn").addEventListener("click",(e) => {
				
	        e.preventDefault();
	
		    const name = nameField.value.trim();
		    const pattern = /^[A-Za-z\s]{3,24}$/;
		    
		    const days = daysField.value.trim();
		    const numPattern = /^[0-9]+$/;
		    
		    if (name == "") {
		    	alert("Leave name cannot be empty");
		    	nameField.focus();
		    	return;
		    }
		    
		    if (!pattern.test(name)) {
		        alert("Only letters are allowed in this field. Please remove any numbers or special characters.");
		        nameField.value = "";
		        nameField.focus();
		        if(isEditClicked == false && days == "") {
		        	idField.value = "";
		        }
		        return;
		    }
		    
		    if (days == "") {
		    	alert("Leave days cannot be empty");
		    	daysField.focus();
		    	return;
		    }
		    
		    if (days < 1) {
		    	alert("Leave days cannot be less than 1");
		    	daysField.value = "";
		    	daysField.focus();
		    	return;
		    }
		    
		    if (days > 31) {
		    	alert("Leave days cannot be more than 30");
		    	daysField.value = "";
		    	daysField.focus();
		    	return;
		    }
		    
		    if (!numPattern.test(days)) {
		        alert("Only numbers are allowed");
		        daysField.value = "";
		        daysField.focus();
		        return;
		    }
		    		    
		    document.querySelector(".form").submit();
			
		})
	
	</script>

</body>
</html>