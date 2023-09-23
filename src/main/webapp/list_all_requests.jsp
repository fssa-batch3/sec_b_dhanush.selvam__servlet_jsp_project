<%@page import="in.fssa.leavepulse.dto.RequestDTO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="in.fssa.leavepulse.model.Request"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Requests Page</title>

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
	List<RequestDTO> requestList = (List<RequestDTO>) request.getAttribute("requests");
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
			src="<%=request.getContextPath()%>/assets/js/toggleStatusContainer.js"></script>

		<div class="page_section">

			<div id="overlay_container">

				<div class="container">

					<div class="head_container">
						<div class="title_container">
							<h2>Request Details</h2>
						</div>
						<div id="xmark_container">
							<i class="fa-solid fa-xmark"></i>
						</div>
					</div>

					<form action="request?action=updaterequest" method="post">

						<input type="hidden" value="" name="request_id"
							id="request_id_field">

						<div class="fields_container employee_hiddent_container">
							<div class="field_container">
								<label> Employee </label> <input type="text"
									class="non_editable_fields" id="name_field" readonly>
							</div>
							<div class="field_container">
								<label> Email </label> <input type="text"
									class="non_editable_fields" id="email_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Leave Type </label> <input type="text"
									class="non_editable_fields" id="leave_field" readonly>
							</div>
							<div class="field_container">
								<label> Reason </label> <input type="text"
									class="non_editable_fields" id="reason_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Start Date </label> <input type="text"
									class="non_editable_fields" id="start_date" readonly>
							</div>
							<div class="field_container role_field">
								<label> End Date </label> <input type="text"
									class="non_editable_fields" id="end_date" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Applied Date </label> <input type="text"
									class="non_editable_fields" id="applied_date" readonly>
							</div>
							<div class="field_container status_field">
								<label> Status </label>
								<div class="select_tag_container">
									<button class="select_tag" type="button" id="status_field">
									</button>
									<i class="fa-solid fa-angle-down dropdown_icon"
										id="fa-angle-down"></i>
								</div>
							</div>
						</div>

						<input type="hidden" name="status" id="selectedStatus" value="">

						<div class="status_type_container">
							<div class="status_container" onclick="selectStatus('Pending')">
								<p>Pending</p>
							</div>
							<div class="status_container" onclick="selectStatus('Accepted')">
								<p>Accepted</p>
							</div>
							<div class="status_container" onclick="selectStatus('Rejected')">
								<p>Rejected</p>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container comment_field_container">
								<label> Comments </label> <input name="comments" type="text"
									class="editable_fields" id="comment_field" readonly>
							</div>

						</div>

						<div class="form_btn_container">
							<button class="btn" type="button" id="edit_btn">Edit</button>
							<button class="btn" id="save_btn">Save</button>
							<button class="btn" type="button" id="delete_btn"> <a id="cancel_path"> Delete </a> </button>
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
							<h2>All Requests</h2>
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
								<p>Approved Leave</p>
							</div>
						</div>
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Pending Leave</p>
							</div>
						</div>
						<div class="filter_field_container"
							onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox">
							<div class="field_name_container">
								<p>Rejected Leave</p>
							</div>
						</div>
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item">Name</div>
							<div class="header__item">Leave Type</div>
							<div class="header__item">Applied Date</div>
							<div class="header__item">Status</div>
							<div class="header__item">Action</div>
						</div>
						<div class="table-content">
							<%
							int i = 1;
							%>
							<%
							for (RequestDTO requests : requestList) {
							%>
							<div class="table-row">
								<div class="table-data">
									<%=i%>
								</div>
								<div class="table-data">
									<%=requests.getEmployeeName()%>
								</div>
								<div class="table-data">
									<%=requests.getLeaveType()%>
								</div>

								<%
								String originalDateString = requests.getCreatedAt() + "";
								%>
								<%
								DateTimeFormatter originalFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
								%>
								<%
								LocalDate localDate = LocalDate.parse(originalDateString, originalFormatter);
								%>
								<%
								DateTimeFormatter desiredFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
								%>
								<%
								String desiredDateString = localDate.format(desiredFormatter);
								%>

								<div class="table-data">
									<%=desiredDateString%>
								</div>
								<div class="table-data">
									<% if (!requests.getCancelledLeave()) { %>
									    <%=requests.getLeaveStatus()%>
									<% } else { %>
										Request Cancelled
									<% } %>									
								</div>
								
								<div class="table-data">
									<button class="view_btn view"
										data-id="<%=requests.getRequestId()%>">View</button>
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
    	
    	let requestsList = <%=requestList%>;
    	    	
    	let view = document.querySelectorAll(".view");
	    let xmark_container = document.getElementById("xmark_container");
	    let edit_btn = document.getElementById("edit_btn");
	    let editable_fields = document.querySelectorAll(".editable_fields");
	    let non_editable_fields = document.querySelectorAll(".non_editable_fields");
	    let save_btn = document.getElementById("save_btn");
	    let select_tag_container = document.querySelector(".select_tag_container");
	    let dropdown_icon = document.querySelector(".dropdown_icon");
	    
	    let request_id_field = document.getElementById("request_id_field");
    	let name_field = document.getElementById("name_field");
    	let email_field = document.getElementById("email_field");
   		let leave_field = document.getElementById("leave_field");
   		let reason_field = document.getElementById("reason_field");
   		let start_date = document.getElementById("start_date");
   		let end_date = document.getElementById("end_date");
   		let applied_date = document.getElementById("applied_date");
   		let selectedStatus = document.getElementById("selectedStatus");
   		let comment_field = document.getElementById("comment_field");
   		let status_field = document.getElementById("status_field");
   		
	   	// To open overlay container
	   		
		    view.forEach((e) => {
		    	e.addEventListener("click", () => {
		    		let id = e.getAttribute("data-id");
		    		let request = requestsList.find((e) => e.requestId == id);
		    		
		    		document.getElementById("overlay_container").style.display = "flex";
			        document.getElementById("body").style.overflow = "hidden";
				        
			        name_field.value = request.employeeName;
			        email_field.value = request.employeeEmail;
			        leave_field.value = request.leaveType;
			        reason_field.value = request.reason;
			        start_date.value = request.startDate;
			        end_date.value = request.endDate;
			        const dateParts = request.createdAt.split(' ');
			        applied_date.value = dateParts[0];
			        
			        if (request.cancelledLeave == true){
			        	 status_field.innerHTML = "Request Cancelled";
			        	 edit_btn.style.display = "none";
			        }
			        
			        let startDate = new Date(request.startDate);
		   			let currentDate = new Date();
		   			
			        if (startDate <= currentDate) edit_btn.style.display = "none";
			        
			        status_field.innerHTML = request.leaveStatus
			        if (request.comments == "null") comment_field.setAttribute("placeholder","Add comment")
			        else comment_field.value = request.comments;
			        request_id_field.value = request.requestId;
			        
			        if (fileName == "request?action=employeerequests") {
			   			document.querySelector(".employee_hiddent_container").style.display = "none";
			   			edit_btn.style.display = "none";
			   			
			   			if (startDate > currentDate) {
			   				if (request.cancelledLeave == false) {
				   				document.getElementById("delete_btn").style.display = "block";
				   				document.getElementById("cancel_path").setAttribute("href","request?action=cancel&id=" + request.requestId);
			   				}
			   			}
			   		}
			        
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
		    	select_tag_container.removeAttribute("onclick");
		    	dropdown_icon.style.display = "none";
		    	comment_field.value = "";
		        
		    })
		    
		    // Remove readonly while clicking edit button
	    
		    edit_btn.addEventListener("click", () => {
		    	editable_fields.forEach((e) => {
		    		e.removeAttribute("readonly");
		    	})
		    	non_editable_fields.forEach((e) => {
		    		e.setAttribute("id","non_editable_fields");
		    	})
		    	selectedStatus.value = status_field.innerHTML;
		    	select_tag_container.setAttribute("onclick","toggleStatusSelectContainer()");
		    	dropdown_icon.style.display = "block";
		    	edit_btn.style.display = "none";
		    	save_btn.style.display = "block";
		    })
		    
		    save_btn.addEventListener("click",(e) => {
		    	e.preventDefault();
		    	
		    	const comment = comment_field.value.trim();
		        
		        const comment_pattern = /^[A-Za-z0-9\s]*$/;
		        
		        if (!comment_pattern.test(reason)) {
		            alert("Only alphanumeric characters and spaces are allowed");
		            comment_field.focus();
					event.preventDefault();
			        return;
			    }

		    })
			        
    </script>

</body>
</html>