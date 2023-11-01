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
				
					<h2 class="breadcrumbs" id="action_title"> Add Leave Type </h2>
					<form action="leave" class="form leave_form" method="post">
						<div class="fields_container">
							<div class="field_container leave_field_container">
								<label for="name_field"> Leave Type </label> 
								<input class="leave_fields" tabindex=1 id="name_field" name="leave_name" autocomplete="off" type="text">
							</div>
							<div class="field_container leave_field_container">
								<label for="days_field"> No.of.Days </label> 
								<input class="leave_fields" tabindex=2 id="days_field" type="text" autocomplete="off" name="leave_days">
							</div>
							<div class="field_container leave_field_container">
								<label> Leave Id </label> 
								<input class="leave_fields" id="id_field" type="text" name="leave_id" autocomplete="off" readonly>
							</div>
						</div>
						<div class="submit_btn_container">
							<button class="submit_btn" tabindex=3> Submit </button>
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
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="min_days" onclick="handleCheckboxClick('min_days')">
							<div class="field_name_container">
								<label class="filter_label" for="min_days"> Minimum Days </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="max_days" onclick="handleCheckboxClick('max_days')">
							<div class="field_name_container">
								<label class="filter_label" for="max_days"> Maximum Days </label>
							</div>
						</div>
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item">Leave Type</div>
							<div class="header__item">No.of.Days</div>
							<div class="header__item">Leave Id</div>
							<div class="header__item">Edit</div>
							<div class="header__item">Delete</div>
						</div>
						<div class="table-content">
							<% int i = 1; %>
							<% for (Leave leave : leavesList) { %>
							<div class="table-row">
								<div class="table-data"> <%= i %> </div>
								<div class="table-data"> <%=leave.getLeaveType()%> </div>
								<div class="table-data"> <%=leave.getLeaveDays() %> </div>
								<div class="table-data"> <%=leave.getLeaveId()%> </div>
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
	
		const leavesList = <%= leavesList %>;
		
		const tableContent = document.querySelector(".table-content");

  		if (leavesList.length == 0) noRecord(tableContent);

		else {
			
			const nameField = document.getElementById("name_field");
			const idField = document.getElementById("id_field");
			const daysField = document.getElementById("days_field");
			const editBtn = document.querySelectorAll(".edit_btn");
			
			const errorMessage = "<%= errorMessage %>";
			const invalidLeaveDays = "<%= invalidLeaveDays %>";
			const invalidLeaveId = "<%= invalidLeaveId %>";
			
			const popUpContainer = document.querySelector(".pop_up_container");
			const okayBtn = document.querySelector(".okay_btn");
			
			const search = document.querySelector(".search_bar");
					
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
			
			const actionTitle = document.getElementById("action_title");
								
			// Edit function
			
			let leave;
			
			tableContent.addEventListener('click', (event) => {
	    		if (event.target.classList.contains('edit_btn')) {
					const id = event.target.getAttribute("data-id");
					isEditClicked = true;
					if (idField.value !== id){
						actionTitle.innerText = "Edit Leave Type"
						duplicateLeavesList = leavesList;
						idField.value = id;
						leave = leavesList.find((e) => e.leaveId == id);
						nameField.value = leave.leaveType;
						daysField.value = leave.leaveDays;
						nameField.focus();
					}				
			        else {
						actionTitle.innerText = "Add Leave Type"
			        	idField.value = "";
			        	nameField.value = "";
			        	daysField.value = "";
			        	isEditClicked = false;
			        }
					scroll(0);						
				}
			});	
			
			// Generate Id
			
			nameField.addEventListener("input", function () {
				const value = nameField.value.trim();
				if (value.length > 2 && !isEditClicked) {
					idField.value = <%= lastLeaveId + 1 %>;
				}
				else if (value.length == 0 && !isEditClicked) idField.value = "";
			})
						
			document.querySelector(".submit_btn").addEventListener("click",(e) => {
					
		        e.preventDefault();
		
			    const name = nameField.value.trim();
			    const charPattern = /^[A-Za-z\s]*$/;
			    const countPattern = /^[A-Za-z\s]{3,24}$/;
			    
			    const days = daysField.value.trim();
			    const numPattern = /^[0-9]+$/;
			    
			    if (leave != null)
				    if (leave.leaveType === name && leave.leaveDays == days) {
				    	location.reload();
				    	return;
				    }
			    
			    if (name == "") {
			    	alert("Leave Type cannot be empty");
			    	nameField.value = "";
			    	nameField.focus();
			    	return;
			    }
			    
			    if (!charPattern.test(name)) {
			        alert("Only letters are allowed in the Leave type field. Please remove any numbers or special characters.");
			        nameField.value = "";
			        nameField.focus();
			        if(isEditClicked == false && days == "")
			        	idField.value = "";
			        return;
			    }
			    
			    if (!countPattern.test(name)) {
			    	alert("Leave type should contain a minimum of 3 letters and a maximum of 24 letters.");
			        nameField.focus();
			        if(isEditClicked == false)
			    		idField.value = "";
			        return;
			    }
			    
			    if (days == "") {
			    	alert("Days cannot be empty");
			    	daysField.value = "";
			    	daysField.focus();
			    	return;
			    }
			    
			    if (days < 1 || days > 31) {
			    	alert("Days cannot be less than 1 and greater than 30");
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
			
			// Search 
					
			 function createRow(i, leave) {
				
				const row = document.createElement('div');
			  	row.classList.add('table-row');
	
			  	const data1 = document.createElement('div');
			  	data1.textContent = i;
			  	data1.classList.add('table-data');
	
			  	const data2 = document.createElement('div');
			  	data2.classList.add('table-data');
			  	data2.textContent = leave.leaveType;
			  	
			  	const data3 = document.createElement('div');
			  	data3.classList.add('table-data');
			  	data3.textContent = leave.leaveDays;
	
			  	const data4 = document.createElement('div');
			  	data4.classList.add('table-data');
			  	data4.textContent = leave.leaveId;
	
			  	const data5 = document.createElement('div');
			  	data5.classList.add('table-data');
			  	const editButton = document.createElement('button');
			  	editButton.classList.add('edit_btn');
			  	editButton.setAttribute('data-id', leave.leaveId);
			  	editButton.textContent = 'Edit';
			  	data5.appendChild(editButton);
	
			  	const data6 = document.createElement('div');
			  	data6.classList.add('table-data');
			  	const deleteButton = document.createElement('button');
			  	deleteButton.classList.add('delete_btn');
			  	const deleteLink = document.createElement('a');
			  	deleteLink.href = "leave?action=delete&id=" + leave.leaveId;
			  	deleteButton.textContent = 'Delete';
			  	deleteLink.appendChild(deleteButton);
			  	data6.appendChild(deleteLink);
	
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
		        leavesList.sort((a,b) => {
		        	  return a.leaveId - b.leaveId;
		        	})
		        leavesList.forEach((leave) => {
		            createRow(i, leave);
		            i++;
		        });
			}
			
			let searchedLeaves = [];
			
			search.addEventListener("focus",() => {
				scroll(405);
			})
			
			search.addEventListener("input", () => {
				
				const value = search.value.toLowerCase().trim();
				
				searchedLeaves = leavesList.filter((leave) => {
				    const leaveType = leave.leaveType.toLowerCase();
				    const leaveDays = leave.leaveDays.toString().toLowerCase();
				    const leaveId = leave.leaveId.toString().toLowerCase();
				    const searchValue = value.toLowerCase();
				
				    return leaveType.includes(searchValue) || leaveDays.includes(searchValue) || leaveId.includes(searchValue);
				});
	
				tableContent.innerHTML = "";
				
				if (searchedLeaves.length != 0) {
					let i = 1;
					searchedLeaves.forEach((leave) => {
					  createRow(i, leave);
					  i++;
					});
				}
				
				else noRecord(tableContent)
					
				scroll(405);
			})
			
			// Sort
			
			const ascOrder = document.querySelector("#asc_order");
			const descOrder = document.querySelector("#desc_order");
			const minDays = document.querySelector("#min_days");
			const maxDays = document.querySelector("#max_days");
			
			function sortByLeaveType(sortOrder, tableContent, leavesList) {
				
			    leavesList.sort((a, b) => {
			        const nameA = a.leaveType.toLowerCase();
			        const nameB = b.leaveType.toLowerCase();
			        const comparison = sortOrder === 'asc' ? 1 : -1;
			        return nameA.localeCompare(nameB) * comparison;
			    });
			
			    tableContent.innerHTML = '';
			    let i = 1;
			    leavesList.forEach((leave) => {
			        createRow(i, leave);
			        i++;
			    });
			    
			}
			
			ascOrder.addEventListener('change', () => {
			    if (ascOrder.checked)
			    	sortByLeaveType('asc', tableContent, leavesList);
			    else
			        defaultOrder(tableContent, leavesList);
			    scroll(405);
			});
			
			descOrder.addEventListener('change', () => {
			    if (descOrder.checked)
			    	sortByLeaveType('desc', tableContent, leavesList);
			    else
			        defaultOrder(tableContent, leavesList);
			    scroll(405);
			});
			
			function sortByLeaveDays(sortOrder, tableContent, leavesList) {
				
				if (sortOrder == 'asc') {
				    leavesList.sort((a, b) => a.leaveDays - b.leaveDays);
				}
				else {
				    leavesList.sort((a, b) => b.leaveDays - a.leaveDays);
				}
			
			    tableContent.innerHTML = '';
			    let i = 1;
			    leavesList.forEach((leave) => {
			        createRow(i, leave);
			        i++;
			    });
			    
			}
			
			minDays.addEventListener('change', () => {
			    if (minDays.checked)
			    	sortByLeaveDays('asc', tableContent, leavesList);
			    else
			        defaultOrder(tableContent, leavesList);
			    scroll(405);
			});
			
			maxDays.addEventListener('change', () => {
			    if (maxDays.checked)
			    	sortByLeaveDays('desc', tableContent, leavesList);
			    else
			        defaultOrder(tableContent, leavesList);
			    scroll(405);
			});
			
		}
	
	</script>

</body>
</html>