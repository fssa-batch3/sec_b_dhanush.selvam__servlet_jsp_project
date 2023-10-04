<%@page import="java.time.LocalDate"%>
<%@page import="in.fssa.leavepulse.model.Leave"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Create Request</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/applyleave.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

</head>

<body>

	<% List<Leave> leavesList = (List<Leave>) request.getAttribute("leaveList"); %>

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

				<script src="<%=request.getContextPath()%>/assets/js/toggleLeaveContainer.js"></script>

				<div class="application_form_container">
					<div>
						<h3 class="form_title">Application Form</h3>
					</div>
					<form action="request" method="post">
						<div class="form_container">
							<div class="fields_container">
								<div class="field_container">
									<label> Start Date </label> <input name="start_date" class="apply_leave_inputs start_date" type="date" required min="<%= LocalDate.now() %>">
								</div>
								<div class="field_container">
									<label> End date </label> <input name="end_date" class="apply_leave_inputs end_date" required type="date" min="<%= LocalDate.now() %>">
								</div>
							</div>
							<div class="fields_container">
								<div class="field_container">
									<label> Leave Type </label>
									<div class="select_tag_container">
										<button class="select_tag" type="button" onclick="toggleLeaveSelectContainer()">Select leave type</button>
										<i class="fa-solid fa-angle-down"></i>
									</div>
								</div>
								<div class="field_container">
									<label> Upload Document </label> <input
										class="apply_leave_inputs" type="file" id="document_field" multiple="multiple">
								</div>
							</div>
							
							<input type="hidden" name="leave" id="selectedLeave" value="">
							
							<div class="leave_type_container">
								<% for (Leave leave : leavesList) { %>
									<div class="leave_container" onclick="selectLeave('<%= leave.getLeaveType() %>')"> <p> <%= leave.getLeaveType() %> </p> </div>
								<% } %>
							</div>
							<div class="fields_container">
								<div class="field_container">
									<label> Reason </label>
									<textarea class="apply_leave_textarea" name="reason"> </textarea>
								</div>
								<div class="field_container submit_btn_container">
									<button class="submit_btn">Submit</button>
								</div>
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
			 
		const start_date = document.querySelector(".start_date");
		const end_date = document.querySelector(".end_date");
		
		start_date.addEventListener("change",() => {
			
		    const startDate = new Date(start_date.value);
		    const minEndDate = new Date(startDate);
		    
		    minEndDate.setDate(startDate.getDate());
		    const minEndDateFormatted = minEndDate.toISOString().split("T")[0];
		    end_date.min = minEndDateFormatted;
			
		})	
		
		end_date.addEventListener("change",() => {
			
		    const endDate = new Date(end_date.value);
		    const maxStartDate = new Date(endDate);
		    
		    maxStartDate.setDate(endDate.getDate());
		    const maxStartDateFormatted = maxStartDate.toISOString().split("T")[0];
		    start_date.max = maxStartDateFormatted;
			
		})	
		 
		let submit_btn = document.querySelector(".submit_btn");
		
		submit_btn.addEventListener("click", () => {
						
			const reason = document.querySelector(".apply_leave_textarea").value.trim();
	        
	        const reason_pattern = /^[A-Za-z0-9\s]*$/;
	        
	        if (!reason_pattern.test(reason)) {
	            alert("Only alphanumeric characters and spaces are allowed");
	            reason.focus();
				event.preventDefault();
		        return;
		    }
			
			let selectedLeave = document.getElementById("selectedLeave").value;
	        if (selectedLeave == "") {
	            alert("Please select a leave before submitting the form.");
				event.preventDefault();
	        }
	        
	    });
	
	</script>

</body>
</html>