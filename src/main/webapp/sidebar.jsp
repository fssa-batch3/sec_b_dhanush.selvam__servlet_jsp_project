<% String user_type = (String) request.getSession().getAttribute("LOGGEDUSERTYPE"); %>

<a href="<%=request.getContextPath()%>/index">
	<div class="sidebar_row_container">
		<div class="sidebar_icon_container">
			<i class="fa-solid fa-house"></i>
		</div>
		<div>
			<p class="sidebar_link">Dashboard</p>
		</div>
	</div>
</a>

<a href="<%=request.getContextPath()%>/role" class="manager_restrict_access">
	<div class="sidebar_row_container">
		<div class="sidebar_icon_container">
			<i class="fa-solid fa-address-card"></i>
		</div>
		<div>
			<p class="sidebar_link">Role</p>
		</div>
	</div>
</a>

<a href="<%=request.getContextPath()%>/leave" class="manager_restrict_access">
	<div class="sidebar_row_container">
		<div class="sidebar_icon_container">
			<i class="fa-solid fa-rectangle-list"></i>
		</div>
		<div>
			<p class="sidebar_link">Leave Type</p>
		</div>
	</div>
</a>

<div class="sidebar_row_container employee_restrict_access" onclick='toggleHiddenLinksContainer("emp_hidden_container")'>
	<div class="sidebar_icon_container">
		<i class="fa-solid fa-users-rectangle"></i>
	</div>
	<div class="link_container">
		<p class="sidebar_link">Employees</p>
		<div class="chevron_container">
			<i class="fa-solid fa-chevron-down"></i>
		</div>
	</div>
</div>

<div id="emp_hidden_container">
	<a href="<%=request.getContextPath()%>/employee?action=new">
		<div class="hidden_list_container">
			<div class="sidebar_hidden_icon_container">
				<i class="fa-regular fa-circle-dot"></i>
			</div>
			<div class="link_container">
				<p class="hidden_link">New Employee</p>
			</div>
		</div>
	</a> <a href="<%=request.getContextPath()%>/employee">
		<div class="hidden_list_container">
			<div class="sidebar_hidden_icon_container">
				<i class="fa-regular fa-circle-dot"></i>
			</div>
			<div class="link_container">
				<p class="hidden_link">Manage Employee</p>
			</div>
		</div>
	</a>
</div>

<div class="sidebar_row_container admin_restrict_access" onclick='toggleHiddenLinksContainer("leave_hidden_container")'>
	<div class="sidebar_icon_container">
		<i class="fa-solid fa-calendar-check"></i>
	</div>
	<div class="link_container">
		<p class="sidebar_link">Leave</p>
		<div class="chevron_container">
			<i class="fa-solid fa-chevron-down"></i>
		</div>
	</div>
</div>

<div id="leave_hidden_container">
	<a href="<%=request.getContextPath()%>/request?action=new">
		<div class="hidden_list_container">
			<div class="sidebar_hidden_icon_container">
				<i class="fa-regular fa-circle-dot"></i>
			</div>
			<div class="link_container">
				<p class="hidden_link">Apply Leave</p>
			</div>
		</div>
	</a> 
	<a href="<%=request.getContextPath()%>/request?action=employeerequests">
		<div class="hidden_list_container">
			<div class="sidebar_hidden_icon_container">
				<i class="fa-regular fa-circle-dot"></i>
			</div>
			<div class="link_container">
				<p class="hidden_link">Leave History</p>
			</div>
		</div>
	</a>
</div>

<a href="<%=request.getContextPath()%>/request" class = "employee_restrict_access">
	<div class="sidebar_row_container">
		<div class="sidebar_icon_container">
			<i class="fa-solid fa-paper-plane"></i>
		</div>
		<div>
			<p class="sidebar_link">Leave Request</p>
		</div>
	</div>
</a>

<div class="sidebar_row_container manager_restrict_access employee_restrict_access" onclick='toggleHiddenLinksContainer("all_info_hidden_container")'>
	<div class="sidebar_icon_container">
		<i class="fa-solid fa-database"></i>
	</div>
	<div class="link_container">
		<p class="sidebar_link">All Info</p>
		<div class="chevron_container">
			<i class="fa-solid fa-chevron-down"></i>
		</div>
	</div>
</div>

<div id="all_info_hidden_container">
	<a href="<%=request.getContextPath()%>/employee?action=allemployees">
		<div class="hidden_list_container">
			<div class="sidebar_hidden_icon_container">
				<i class="fa-regular fa-circle-dot"></i>
			</div>
			<div class="link_container">
				<p class="hidden_link">All Employees</p>
			</div>
		</div>
	</a>
	<a href="<%=request.getContextPath()%>/request?action=allrequests">
		<div class="hidden_list_container">
			<div class="sidebar_hidden_icon_container">
				<i class="fa-regular fa-circle-dot"></i>
			</div>
			<div class="link_container">
				<p class="hidden_link">All Leave Requests</p>
			</div>
		</div>
	</a>
</div>
<!--
<a href="#">
	<div class="sidebar_row_container">
		<div class="sidebar_icon_container">
			<i class="fa-solid fa-bell"></i>
		</div>
		<div>
			<p class="sidebar_link">Notification</p>
		</div>
	</div>
</a>

<a href="#">
	<div class="sidebar_row_container">
		<div class="sidebar_icon_container">
			<i class="fa-solid fa-book"></i>
		</div>
		<div>
			<p class="sidebar_link">Visit Us</p>
		</div>
	</div>
</a> -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>	
<script>

	let userType = "<%= user_type %>";
	let admin_restrict_access = document.querySelector(".admin_restrict_access");
	let manager_restrict_access = document.querySelectorAll(".manager_restrict_access");
	let employee_restrict_access = document.querySelectorAll(".employee_restrict_access");
	
	if (userType == "admin") admin_restrict_access.style.display = "none";
	else if (userType == "manager") 
		manager_restrict_access.forEach((e) => {
			e.style.display = "none";
		})
	else {
		manager_restrict_access.forEach((e) => {
			e.style.display = "none";
		})
		employee_restrict_access.forEach((e) => {
			e.style.display = "none";
		})
	}
	
	function toggleHiddenLinksContainer(containerId) {
	    const hiddenContainer = document.getElementById(containerId);
	    hiddenContainer.style.display = hiddenContainer.style.display === "block" ? "none" : "block";
	}
		

	/** function toggleEmployeeHiddenLinksContainer() {
	    const hiddenContainer = document.getElementById("emp_hidden_container");
	    hiddenContainer.style.display = hiddenContainer.style.display === "block" ? "none" : "block";
	}
	
	function toggleLeaveHiddenLinksContainer() {
	    const hiddenContainer = document.getElementById("leave_hidden_container");
	    hiddenContainer.style.display = hiddenContainer.style.display === "block" ? "none" : "block";
	}
	
	function toggleAllInfoHiddenLinksContainer() {
	    const hiddenContainer = document.getElementById("all_info_hidden_container");
	    hiddenContainer.style.display = hiddenContainer.style.display === "block" ? "none" : "block";
	} **/
	
</script>

