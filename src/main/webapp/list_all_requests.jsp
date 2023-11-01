<%@page import="in.fssa.leavepulse.dto.RequestDTO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="in.fssa.leavepulse.model.Request"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Requests Page</title>

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
</head>

<body id="body">

	<% List<RequestDTO> requestList = (List<RequestDTO>) request.getAttribute("requests"); %>

	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
	</div>

	<div class="body_section">

		<div class="sidebar_section">
			<jsp:include page="/sidebar.jsp" />
		</div>

		<script src="<%=request.getContextPath()%>/assets/js/toggleStatusContainer.js"></script>

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

					<form action="request?action=updaterequest" class="form" method="post">

						<input type="hidden" value="" name="request_id" id="request_id_field">

						<div class="fields_container employee_hidden_container">
							<div class="field_container">
								<label> Employee </label> 
								<input type="text" class="non_editable_fields" id="name_field" readonly>
							</div>
							<div class="field_container">
								<label> Email </label> 
								<input type="text" class="non_editable_fields" id="email_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Leave Type </label> 
								<input type="text" class="non_editable_fields" id="leave_field" readonly>
							</div>
							<div class="field_container">
								<label> Reason </label> 
								<input type="text" class="non_editable_fields" id="reason_field" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Start Date </label> 
								<input type="text" class="non_editable_fields" id="start_date" readonly>
							</div>
							<div class="field_container role_field">
								<label> End Date </label> 
								<input type="text" class="non_editable_fields" id="end_date" readonly>
							</div>
						</div>

						<div class="fields_container">
							<div class="field_container">
								<label> Applied Date </label> 
								<input type="text" class="non_editable_fields" id="applied_date" readonly>
							</div>
							<div class="field_container status_field">
								<label> Status </label>
								<div class="select_tag_container">
									<button class="select_tag" type="button"></button>
									<i class="fa-solid fa-angle-down dropdown_icon" id="fa-angle-down"></i>
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
							<div class="status_container hidden_status" onclick="selectStatus('Cancelled')">
								<p>Cancelled</p>
							</div>
						</div>
						
						<div class="fields_container">
							<div class="field_container">
								<label> Total Days </label> 
								<input type="text" class="non_editable_fields" id="total_days" readonly>
							</div>
							<div class="field_container">
								<label for="comment_field"> Comments </label> 
								<input autocomplete="off" name="comments" type="text" class="editable_fields" value="" id="comment_field" readonly>
							</div>
						</div>

						<div class="form_btn_container">
							<button class="btn" type="button" id="edit_btn"> Edit </button>
							<button class="btn" id="save_btn"> Save </button>
							<button class="btn" type="button" id="delete_btn">
								<a id="cancel_path"> Delete </a>
							</button>
						</div>

						<input type="hidden" name="old_status" class="old_status">
						<input type="hidden" name="employee_id" class="hidden_employee_id">
						<input type="hidden" name="leave_id" class="hidden_leave_id">
						<input type="hidden" name="days" class="hidden_days">

					</form>

				</div>

			</div>

			<div class="breadcrumbs_section">
				<jsp:include page="/breadcrumbs.jsp" />
			</div>

			<div class="main_section">

				<script src="<%=request.getContextPath()%>/assets/js/toggleFilterContainer.js"></script>

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
							<button class="filter_btn"> Filter by <i class="fa-solid fa-angle-down"></i> </button>
						</div>
					</div>

					<div class="filter_dropdown_container">
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="app_leave" onclick="handleCheckboxClick('app_leave')">
							<div class="field_name_container">
								<label for="app_leave"> Approved Leave </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="pen_leave" onclick="handleCheckboxClick('pen_leave')">
							<div class="field_name_container">
								<label for="pen_leave"> Pending Leave </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="rej_leave" onclick="handleCheckboxClick('rej_leave')">
							<div class="field_name_container">
								<label for="rej_leave"> Rejected Leave </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="can_leave" onclick="handleCheckboxClick('can_leave')">
							<div class="field_name_container">
								<label for="can_leave"> Cancelled Leave </label>
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
						
						<%! public String formatDate(String originalDateString) {
								DateTimeFormatter originalFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
								LocalDate localDate = LocalDate.parse(originalDateString, originalFormatter);
								DateTimeFormatter desiredFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
								return localDate.format(desiredFormatter);
						} %>
						
						<div class="table-content">
						
							<% int i = 1; %>
							<% for (RequestDTO requests : requestList) { %>
							
							<div class="table-row">
								<div class="table-data"> <%= i %> </div>
								<div class="table-data"> <%=requests.getEmployeeName()%> </div>
								<div class="table-data"> <%=requests.getLeaveType()%> </div>

								<% String originalDateString = requests.getCreatedAt() + ""; %>
								<% DateTimeFormatter originalFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"); %>
								<% LocalDate localDate = LocalDate.parse(originalDateString, originalFormatter); %>
								<% DateTimeFormatter desiredFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); %>
								<% String desiredDateString = localDate.format(desiredFormatter); %>

								<div class="table-data"> <%=desiredDateString%> </div>
								<div class="table-data">
									<% if (!requests.getCancelledLeave()) { %>
									    <%=requests.getLeaveStatus()%>
									<% } else { %>
										Request Cancelled
									<% } %>									
								</div>
								
								<div class="table-data">
									<button class="view_btn view" data-id="<%=requests.getRequestId()%>">View</button>
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
    	
    	const requestsList = <%=requestList%>;
    	
    	/* const lossOfPayMap = new Map();
    	const result = [];

    	requestsList.forEach((request) => {
    	    if (request.lossOfPay != "null") {
    	        if (!lossOfPayMap.has(request.lossOfPay)) {
    	            lossOfPayMap.set(request.lossOfPay, []);
    	        }
    	        lossOfPayMap.get(request.lossOfPay).push(request);
    	    }
    	});
    	
    	lossOfPayMap.forEach((requests, lossOfPay) => {
    	    const lastRequest = requests[requests.length - 1];
    	    const firstRequest = requests[0];
    	    const totalDays = ((new Date(lastRequest.endDate) - new Date(firstRequest.startDate)) / (1000 * 60 * 60 * 24) + 1);
    	    result.push({ endDate: lastRequest.endDate, totalDays, lossOfPay });
    	});
    	    	
    	result.forEach((r) => {
    		const index = requestsList.indexOf(requestsList.find((e) => e.lossOfPay === r.lossOfPay));
    		requestsList[index].leaveType = "Loss of Pay";
    		requestsList[index].endDate = r.endDate;
    	}) */
    	    	    	    	
		const tableContent = document.querySelector(".table-content");
   		
  		if (requestsList.length == 0) noRecord(tableContent);
  		    	
  		else {
  			
	    	const view = document.querySelectorAll( ".view");
		    const xmarkContainer = document.getElementById("xmark_container");
		    const editBtn = document.getElementById("edit_btn");
		    const editableFields = document.querySelectorAll(".editable_fields");
		    const nonEditableFields = document.querySelectorAll(".non_editable_fields");
		    const saveBtn = document.getElementById( "save_btn");
		    const selectTagContainer = document.querySelector(".select_tag_container");
		    const dropdownIcon = document.querySelector(".dropdown_icon");
		
		    const requestIdField = document.getElementById("request_id_field");
	    	const nameField = document.getElementById("name_field");
	    	const emailField = document.getElementById("email_field");
	   		const leaveField = document.getElementById("leave_field");
	   		const reasonField = document.getElementById("reason_field");
	   		const startDate = document.getElementById("start_date");
	   		const endDate = document.getElementById("end_date");
	   		const appliedDate = document.getElementById("applied_date");
	   		const selectedStatus = document.getElementById("selectedStatus");
	   		const totalDaysField = document.getElementById("total_days");
	   		const commentField = document.getElementById("comment_field");
	   		const statusField = document.querySelector(".select_tag");
	   		
	   		const oldStatus = document.querySelector(".old_status");
	   		const employeeId = document.querySelector(".hidden_employee_id");
	   		const leaveId = document.querySelector(".hidden_leave_id");
	   		const days = document.querySelector(".hidden_days");
	   		
	   		const search = document.querySelector(".search_bar");
						
		   	// To open overlay container
		   	
		   	let request;
		   	
	   		tableContent.addEventListener('click', (event) => {
    			if (event.target.classList.contains('view_btn')) {
	   		        const id = event.target.getAttribute("data-id"); 
	   		        
	   		        request = requestsList.find((e) => e.requestId == id);

	   		        document.getElementById("overlay_container").style.display = "flex"; 
	   		        document.getElementById("body").style.overflow = "hidden"; 
	   		     	nameField.value = request.employeeName;
	   		        emailField.value = request.employeeEmail; 
	   		        leaveField.value = request.leaveType; 
	   		     	reasonField.value = request.reason; 
	   		        if (reasonField.value == "")
	   		        	reasonField.setAttribute("placeholder", "No reason");

	   		     	startDate.value = request.startDate; 
	   		        endDate.value = request.endDate; 
	   		        const dateParts = request.createdAt.split(' ');
	   		        appliedDate.value = dateParts[0]; 
	   		     	statusField.innerHTML = request.leaveStatus 
	   		        const date1 = new Date(request.startDate);
	   		        const date2 = new Date(request.endDate); 
	   		        const differenceInMilliseconds = date2 - date1; 
	   		        const differenceInDays = (differenceInMilliseconds / (1000 * 60 * 60 * 24)) + 1; 
	   		        let startDate1 = new Date(request.startDate); 
	   		        let currentDate = new Date(); 
	   		        startDate1.setHours(0, 0, 0, 0); 
	   		        currentDate.setHours(0,0, 0, 0); 
	   		        if (startDate1 < currentDate || request.leaveStatus == "Cancelled") { editBtn.style.display = "none"; }

	   		     	commentField.value = request.comments; 
	   		        if (commentField.value == "null") commentField.value = ""; 
	   		        if (commentField.value == "") commentField.setAttribute("placeholder", "Add comment")

	   		        totalDaysField.value = differenceInDays;
	   		     	requestIdField.value = request.requestId; 
	   		        oldStatus.value = request.leaveStatus; 
	   		        employeeId.value = request.employeeId;
	   		        leaveId.value = request.leaveId; 
	   		        days.value = differenceInDays;

	   		        if (fileName == "request?action=employeerequests") {

	   		            document.querySelector(".employee_hidden_container").style.display = "none"; 
	   		        	editBtn.style.display = "none"; 
	   		            if (commentField.value == "")
	   		            	commentField.setAttribute("placeholder", "No comments");
	   		            
	   		            if (startDate1 >= currentDate && request.leaveStatus != "Cancelled") {
	   		                document.getElementById("delete_btn").style.display = "block";
	   		                document.getElementById("cancel_path").setAttribute("href", "request?action=cancel&id="
	   		                    + request.requestId + "&leaveId=" + request.leaveId + "&days=" +
	   		                    differenceInDays + "&status=" + request.leaveStatus);
	   		            }
	   		            else {
	   		                document.getElementById("delete_btn").style.display = "none";
	   		                document.getElementById("cancel_path").setAttribute("href", "");
	   		            }
	   		        }
	   		    }
	   		});

	   		// To close overlay container

	   		xmarkContainer.addEventListener("click", () => {
	   		    document.getElementById("overlay_container").style.display = "none"; 
	   		    document.getElementById("body").style.overflow = "auto";
	   		 	saveBtn.style.display = "none"; 
	   		 	editBtn.style.display = "block"; 
	   		 	editableFields.forEach((e) => {
	   		            e.setAttribute("readonly", "readonly");
	   		        })
	   		    nonEditableFields.forEach((e) => { e.removeAttribute("id"); })
	   		    oldStatus.value = ""; 
	   		    employeeId.value = ""; 
	   		    leaveId.value = "";
	   		    days.value = ""; 
	   		 	selectTagContainer.removeAttribute("onclick");
	   		 	dropdownIcon.style.display = "none"; 
	   		 	commentField.value = "";
	   		 	reasonField.value = "";
   		 		totalDaysField.value = "";
	   		}) 
	   		
	   		// Remove readonly while clicking
	   		
   		    editBtn.addEventListener("click", () => {
   		    	editableFields.forEach((e) => {
	   		        e.removeAttribute("readonly");
	   		    });
   		    	nonEditableFields.forEach((e) => {
	   		        e.setAttribute("id", "nonEditableFields");
	   		    });

	   		    selectedStatus.value = statusField.innerHTML;
	   		 	selectTagContainer.setAttribute("onclick", "toggleStatusSelectContainer()");
	   		 	dropdownIcon.style.display = "block"; 
	   		 	editBtn.style.display = "none"; 
	   			saveBtn.style.display = "block";
	   		})
		   	
   			saveBtn.addEventListener("click", (e) => {
	   		    e.preventDefault();

	   		    const comment = commentField.value.trim(); 
	   		    const commentPattern = /^[A-Za-z0-9\s\-:;.]*$/; 
	   		    
	   		    if (request.leaveStatus === selectedStatus.value && request.comments === comment) {
	   		    	location.reload();
	   		    	return;
	   		    }

	   		    if (!commentPattern.test(comment)) {
   		            alert("Only alphanumeric characters and spaces are allowed");
   		         	commentField.value = ""; 
   		         	commentField.focus(); 
   		            return;
   		        }
	   		    
	   		    document.querySelector(".form").submit();
	   		}) 
  		
			// Search 
			
			function createRow(i, request) {
				
				const row = document.createElement('div');
			  	row.classList.add('table-row');
	
			  	const data1 = document.createElement('div');
			  	data1.textContent = i;
			  	data1.classList.add('table-data');
	
			  	const data2 = document.createElement('div');
			  	data2.classList.add('table-data');
			  	data2.textContent = request.employeeName;
	
			  	const data3 = document.createElement('div');
			  	data3.classList.add('table-data');
			  	data3.textContent = request.leaveType;
			  				  	
			  	const data4 = document.createElement('div');
			  	data4.classList.add('table-data');
			  	data4.textContent = (request.createdAt).split(' ')[0];
			  	
			  	const data5 = document.createElement('div');
			  	data5.classList.add('table-data');
			  	data5.textContent = request.leaveStatus;
	
			  	const data6 = document.createElement('div');
			  	data6.classList.add('table-data');
			  	const viewButton = document.createElement('button');
			  	viewButton.classList.add('view_btn');
			  	viewButton.setAttribute('data-id', request.requestId);
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
		        requestsList.sort((a,b) => {
		        	  return b.requestId - a.requestId;
		        	})
		        	
	        	requestsList.forEach((request) => {
			        createRow(i, request);
			        i++;
			    });
			}
			
			let searchedRequests = [];
			
			search.addEventListener("focus",() => {
				scroll(150);
			})
			
			search.addEventListener("input", () => {
				
				const value = search.value.toLowerCase().trim();
				
				searchedRequests = requestsList.filter((request) => {
				    const employeeName = request.employeeName.toLowerCase();
				    const leaveType = request.leaveType.toLowerCase();
				    const createdAt = request.createdAt.toLowerCase();
				    const leaveStatus = request.leaveStatus.toLowerCase();
				    const searchValue = value.toLowerCase();
				
				    return employeeName.includes(searchValue) || leaveType.includes(searchValue) || createdAt.includes(searchValue) || leaveStatus.includes(searchValue);
				});
	
				tableContent.innerHTML = "";
				
				if (searchedRequests.length != 0) {
					let i = 1;
					searchedRequests.forEach((request) => {
					  createRow(i, request);
					  i++;
					});
				}
				
				else noRecord(tableContent)
					
				scroll(150);
			})
			
			// Sort
			
			const appLeave = document.querySelector("#app_leave");
			const penLeave = document.querySelector("#pen_leave");
			const rejLeave = document.querySelector("#rej_leave");
			const canLeave = document.querySelector("#can_leave");
			
			function sortByStatus(status, tableContent, requestsList, resultList) {
				
				resultList = requestsList.filter((e) => e.leaveStatus == status);
				tableContent.innerHTML = '';
				
				if (resultList.length === 0) {
					noRecord(tableContent)
					return;
				}
				
			    let i = 1;
			    resultList.forEach((request) => {
			        createRow(i, request);
			        i++;
			    });
				
			}
			
			let resultList = [];
			
			appLeave.addEventListener('change', () => {
			    if (appLeave.checked)
			    	sortByStatus('Accepted', tableContent, requestsList, resultList);
			    else
			        defaultOrder(tableContent, requestsList);
			    scroll(150);
			});
			
			penLeave.addEventListener('change', () => {
			    if (penLeave.checked)
			    	sortByStatus('Pending', tableContent, requestsList, resultList);
			    else
			        defaultOrder(tableContent, requestsList);
			    scroll(150);
			});
			
			rejLeave.addEventListener('change', () => {
			    if (rejLeave.checked)
			    	sortByStatus('Rejected', tableContent, requestsList, resultList);
			    else
			        defaultOrder(tableContent, requestsList);
			    scroll(150);
			});
			
			canLeave.addEventListener('change', () => {
			    if (canLeave.checked)
			    	sortByStatus('Cancelled', tableContent, requestsList, resultList);
			    else
			        defaultOrder(tableContent, requestsList);
			    scroll(150);
			});

  		}

	</script>
		
</body>
</html>