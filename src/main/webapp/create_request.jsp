<%@page import="in.fssa.leavepulse.model.Request"%>
<%@page import="in.fssa.leavepulse.dto.LeaveBalanceDTO"%>
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/createleave.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

</head>

<body>

	<% List<Leave> leavesList = (List<Leave>) request.getAttribute("leaveList"); %>
	<% List<LeaveBalanceDTO> availableLeaves = (List<LeaveBalanceDTO>) request.getAttribute("availableLeaves"); %>
	
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<% Request invalidRequest = (Request) request.getAttribute("requestsData"); %>
	<% String invalidLeave = (String) request.getAttribute("leave"); %>

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

				<script src="<%=request.getContextPath()%>/assets/js/toggleLeaveContainer.js"></script>

				<div class="application_form_container">
					<div>
						<h3 class="form_title">Application Form</h3>
					</div>
					<form class="form" action="request" method="post">
						<div class="form_container">
							<div class="fields_container">
								<div class="field_container">
									<label for="start_date"> Start Date </label> 
									<input id="start_date" name="start_date" class="apply_leave_inputs" type="date" required min="<%= LocalDate.now() %>">
								</div>
								<div class="field_container">
									<label for="end_date"> End date </label> 
									<input id="end_date" name="end_date" class="apply_leave_inputs" required type="date" min="<%= LocalDate.now() %>">
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
								<!-- <div class="field_container">
									<label> Upload Document </label> <input
										class="apply_leave_inputs" type="file" id="document_field" multiple="multiple">
								</div> -->
								<div class="field_container">
									<label> Remaining Leaves </label> <input
										class="apply_leave_inputs remaining_leaves_field" type="text" disabled>
								</div>
							</div>
							
							<input type="hidden" name="leave" id="selectedLeave" value="">
							
							<div class="leave_type_container">
								<% for (Leave leave : leavesList) { %>
									<div class="leave_container" onclick="selectLeave('<%= leave.getLeaveType() %>'); selectedLeave('<%= leave.getLeaveType() %>')"> <p> <%= leave.getLeaveType() %> </p> </div>
								<% } %>
							</div>
							<div class="fields_container">
								<div class="field_container">
									<label for="reason"> Reason </label>
									<textarea id="reason" class="apply_leave_textarea" name="reason"> </textarea>
								</div>
								<div class="field_container submit_btn_container">
									<button class="submit_btn">Submit</button>
								</div>
							</div>
						</div>
						
						<input type="hidden" name="isLossOfPay" id="lossOfPay" value="no">
						<input type="hidden" name="days" class="hidden_days">
						
					</form>
				</div>

			</div>

			<div class="footer_section">
				<jsp:include page="/footer.jsp" />
			</div>

		</div>

	</div>

	<script>
	
		const startDate = document.querySelector("#start_date");
		const endDate = document.querySelector("#end_date");
		const reason = document.querySelector(".apply_leave_textarea");
		
		const errorMessage = "<%= errorMessage %>";
		const invalidRequest = <%= invalidRequest %>;
		const invalidLeave = "<%= invalidLeave %>";
		
		const popUpContainer = document.querySelector(".pop_up_container");
		const okayBtn = document.querySelector(".okay_btn");
		
		function isError(errorMessage) {
			if (errorMessage != "null") {
				popUpContainer.style.display = "block";
				document.querySelector(".error_message").innerHTML = errorMessage;
				reason.value = invalidRequest.reason;
				selectLeave(invalidLeave);
				okayBtn.focus();
				document.getElementById("breadcrumbs_title").innerHTML = "Leave Application";
				document.getElementById("breadcrumbs_path").innerHTML = "Dashboard > Apply Leave";
  				history.replaceState(null, null, window.location.href + "?action=new");
			}
		}
		
		isError(errorMessage);
		
		okayBtn.addEventListener("click", () => {
			popUpContainer.style.display = "none";
			startDate.value = "";
			endDate.value = "";
			startDate.focus()
			return;
		})
		
		startDate.addEventListener('keydown', function (e) {
			e.preventDefault();
		  	});
		endDate.addEventListener('keydown', function (e) {
			e.preventDefault();
		  	});
	
		const availableLeaves = <%= availableLeaves %>;
		const remainingLeavesField = document.querySelector(".remaining_leaves_field");
				
		let count = 0;
		availableLeaves.forEach((e) => {
			if (e.leaveType !== "Loss of Pay")
				count += e.availableLeaveDays;
		})
		
		remainingLeavesField.value = count;
	
		function selectedLeave(leave) {
			remainingLeavesField.value = availableLeaves.find((e) => e.leaveType == leave).availableLeaveDays;
		}
	 		
		startDate.addEventListener("change",() => {
			
		    const startDate1 = new Date(startDate.value);
		    const minEndDate = new Date(startDate1);
		    
		    if (startDate1.getDay() === 0) {
                alert("Sundays are not allowed.");
                startDate.value = ""; 
                return;
            }
		    
		    minEndDate.setDate(startDate1.getDate());
		    const minEndDateFormatted = minEndDate.toISOString().split("T")[0];
		    endDate.min = minEndDateFormatted;
			
		})	
		
		endDate.addEventListener("change",() => {
			
		    const endDate1 = new Date(endDate.value);
		    const maxStartDate = new Date(endDate1);
		    
		    if (endDate1.getDay() === 0) {
                alert("Sundays are not allowed.");
                endDate.value = ""; 
                return;
            }
		    
		    maxStartDate.setDate(endDate1.getDate());
		    const maxStartDateFormatted = maxStartDate.toISOString().split("T")[0];
		    startDate.max = maxStartDateFormatted;
			
		})	
		 
		const submitBtn = document.querySelector(".submit_btn");
		
		submitBtn.addEventListener("click", () => {
			
			event.preventDefault();
			
	        if (!checkEmpty(startDate.value, startDate, "Start date")) return;
	        if (!checkEmpty(endDate.value, endDate, "End date")) return;
							        
	        const reasonPattern = /^[A-Za-z0-9\s\-:;.,]*$/;
	        
	        if (!checkPattern(reasonPattern, reason.value, reason, "Only alphanumeric characters and spaces are allowed")) 
	        	return;
			
			const selectedLeave = document.getElementById("selectedLeave");
	        if (selectedLeave.value == "") {
	            alert("Please select a Leave type");
	            return;
	        }
	        
	        const date1 = new Date(start_date.value);
	        const date2 = new Date(end_date.value);
	        
	     	let differenceInDays = 0;
	     	const currentDate = new Date(date1);
	     	while (currentDate <= date2) {
	     	    if (currentDate.getDay() !== 0) {
	     	        differenceInDays++;
	     	    }
	     	    currentDate.setDate(currentDate.getDate() + 1);
	     	}
	     	
	     	document.querySelector(".hidden_days").value = differenceInDays;
	     	
	        const leaveBalance = availableLeaves.find((e) => e.leaveType == selectedLeave.value).availableLeaveDays;
	        
	        if (count === 0) {
				let userConfirmation = confirm("You have no leaves. Would you like to continue with the loss-of-pay type?");
	        	if (userConfirmation) 
	        		document.getElementById("lossOfPay").value = "yes";
	        	else {
		        	endDate.focus();
		        	return;
	        	}
	        }
	        
	        else if (differenceInDays > leaveBalance && count > differenceInDays) {
	        	alert("Insufficient of " + selectedLeave.value + ". You currently have " + leaveBalance + " days remaining.");
	        	endDate.focus();
	        	return;
	        }
	        
	        /* else if (count < differenceInDays) {
	        	let userConfirmation = confirm("You are crossing your total leave balance. Would you like to continue with the loss-of-pay type?");
	        	if (userConfirmation) 
	        		document.getElementById("lossOfPay").value = "yes";
	        	else {
		        	endDate.focus();
		        	return;
	        	}
	        } */
	        
	     	document.querySelector(".form").submit();
	        
	    });
	
	</script>

</body>
</html>