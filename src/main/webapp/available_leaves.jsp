<%@page import="in.fssa.leavepulse.dto.LeaveBalanceDTO"%>
<%@page import="java.util.List"%>
<%@page import="in.fssa.leavepulse.service.RoleService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Available Leaves Page</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/sidebar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/footer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/table.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Serif:ital,wght@0,400;0,700;1,700&display=swap" rel="stylesheet">

</head>
<body>

	<% List<LeaveBalanceDTO> availableLeaves = (List<LeaveBalanceDTO>) request.getAttribute("availableLeaves"); %>

	<div class="header_section">
		<script src="<%=request.getContextPath()%>/assets/js/resource.js"></script>
		<jsp:include page="/header.jsp" />
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
				<script src="<%=request.getContextPath()%>/assets/js/toggleFilterContainer.js"></script>
				<div class="table_container">
					<div class="table_header_container">
						<div class="table_heading_container">
							<h2>Available Leaves</h2>
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
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="min_days" onclick="handleCheckboxClick('min_days')">
							<div class="field_name_container">
								<label for="min_days"> Minimum leaves </label>
							</div>
						</div>
						<div class="filter_field_container" onclick="stopPropagation(event)">
							<input type="checkbox" class="checkbox" id="max_days" onclick="handleCheckboxClick('max_days')">
							<div class="field_name_container">
								<label for="max_days"> Maximum leaves </label>
							</div>
						</div>
					</div>

					<div class="table">
						<div class="table-header">
							<div class="header__item">S.No</div>
							<div class="header__item">Leave Type</div>
							<div class="header__item">Available days</div>
						</div>
						<div class="table-content">
							<% int i = 1; %>
								<% for (LeaveBalanceDTO leave : availableLeaves) { %>
								<div class="table-row">
									<div class="table-data"> <%= i %> </div>
									<div class="table-data"> <%= leave.getLeaveType() %> </div>
									<div class="table-data"> <%= leave.getAvailableLeaveDays() %> </div>
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
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	
		const availableLeaves = <%= availableLeaves %>;
		
		const tableContent = document.querySelector(".table-content");
		
  		if (availableLeaves.length == 0) noRecord(tableContent);
  		
  		else {
  			
			// Search 
			
			const search = document.querySelector(".search_bar");
			
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
			  	data3.textContent = leave.availableLeaveDays;
	
			  	row.appendChild(data1);
			  	row.appendChild(data2);
			  	row.appendChild(data3);
			  
			  	tableContent.appendChild(row);
			}
			
			const order = [];
			availableLeaves.forEach((e) => {
				order.push(e.availableLeaveDays);
			})
			
			const defaultOrderedLeaves = [];
			for (let i = 0; i < order.length; i++)
				defaultOrderedLeaves.push(availableLeaves.find((e) => e.availableLeaveDays === order[i]));
									
			function defaultOrder() {
				tableContent.innerHTML = "";
		        let i = 1;
		        defaultOrderedLeaves.forEach((leave) => {
		            createRow(i, leave);
		            i++;
		        });
			}
			
			let searchedLeaves = [];
			
			search.addEventListener("focus",() => {
				scroll(150);
			})
			
			search.addEventListener("input", () => {
				
				const value = search.value.toLowerCase().trim();
				
				searchedLeaves = availableLeaves.filter((leave) => {
					const leaveType = leave.leaveType.toLowerCase();
				    const leaveDays = leave.availableLeaveDays.toString().toLowerCase();
				    const searchValue = value.toLowerCase();
				
				    return leaveType.includes(searchValue) || leaveDays.includes(searchValue);
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
				
				scroll(150);
			})
			
			// Sort
			
			const ascOrder = document.querySelector("#asc_order");
			const descOrder = document.querySelector("#desc_order");
			const minDays = document.querySelector("#min_days");
			const maxDays = document.querySelector("#max_days");
			
			function sortByLeaveType(sortOrder, tableContent, leavesList) {
				
				availableLeaves.sort((a, b) => {
			        const nameA = a.leaveType.toLowerCase();
			        const nameB = b.leaveType.toLowerCase();
			        const comparison = sortOrder === 'asc' ? 1 : -1;
			        return nameA.localeCompare(nameB) * comparison;
			    });
			
			    tableContent.innerHTML = '';
			    let i = 1;
			    availableLeaves.forEach((leave) => {
			        createRow(i, leave);
			        i++;
			    });
			    
			}
			
			ascOrder.addEventListener('change', () => {
			    if (ascOrder.checked)
			    	sortByLeaveType('asc', tableContent, availableLeaves);
			    else
			        defaultOrder(tableContent, availableLeaves);
			    scroll(150);
			});
			
			descOrder.addEventListener('change', () => {
			    if (descOrder.checked)
			    	sortByLeaveType('desc', tableContent, availableLeaves);
			    else
			        defaultOrder(tableContent, availableLeaves);
			    scroll(150);
			});
			
			function sortByLeaveDays(sortOrder, tableContent, availableLeaves) {
				
				if (sortOrder == 'asc') {
					availableLeaves.sort((a, b) => a.availableLeaveDays - b.availableLeaveDays);
				}
				else {
					availableLeaves.sort((a, b) => b.availableLeaveDays - a.availableLeaveDays);
				}
			
			    tableContent.innerHTML = '';
			    let i = 1;
			    availableLeaves.forEach((leave) => {
			        createRow(i, leave);
			        i++;
			    });
			    
			}
			
			minDays.addEventListener('change', () => {
			    if (minDays.checked)
			    	sortByLeaveDays('asc', tableContent, availableLeaves);
			    else
			        defaultOrder(tableContent, availableLeaves);
			    scroll(150);
			});
			
			maxDays.addEventListener('change', () => {
			    if (maxDays.checked)
			    	sortByLeaveDays('desc', tableContent, availableLeaves);
			    else
			        defaultOrder(tableContent, availableLeaves);
			    scroll(150);
			});
  			
  		}

	</script>
		
</body>
</html>