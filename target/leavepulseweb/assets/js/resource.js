const url = window.location.href;

function getPathAfterLeavePulseWeb(url) {
	const index = url.indexOf("leavepulseweb/");
	return url.substring(index + "leavepulseweb/".length);
}

const fileName = getPathAfterLeavePulseWeb(url);

// Breadcrum section
let breadcrumbs_title = url;
let breadcrumbs_path = fileName;

// Role page
if (fileName == "role") {
	breadcrumbs_title = "Role Module";
	breadcrumbs_path = "Dashboard > Role";
}

// Leave page
if (fileName == "leave") {
	breadcrumbs_title = "Leave Module";
	breadcrumbs_path = "Dashboard > Leave Type";
}

// Create Employee page
if (fileName == "employee?action=new") {
	breadcrumbs_title = "Create Employee";
	breadcrumbs_path = "Dashboard > New Employee"
}

// Team Members page
if (fileName == "employee") {
	breadcrumbs_title = "Team Members"
	breadcrumbs_path = "Dashboard > Manage Employee"
}

// All Employee page
if (fileName == "employee?action=allemployees") {
	breadcrumbs_title = "Employees List"
	breadcrumbs_path = "Dashboard > All Employees"
}

// Apply leave page
if (fileName == "request?action=new") {
	breadcrumbs_title = "Leave Application";
	breadcrumbs_path = "Dashboard > Apply Leave"
}

// All Request page
if (fileName == "request?action=allrequests") {
	breadcrumbs_title = "Requests List"
	breadcrumbs_path = "Dashboard > All Request"
}

// Team Members Request page
if (fileName == "request") {
	breadcrumbs_title = "Team Members Requests List"
	breadcrumbs_path = "Dashboard > Leave Request"
}

// Leave History page
if (fileName == "request?action=employeerequests") {
	breadcrumbs_title = "Requests List"
	breadcrumbs_path = "Dashboard > Leave History"
}

// Profile page
if (fileName == "profile") {
	breadcrumbs_title = "User Profile"
	breadcrumbs_path = "Dashboard > Profile"	
}

// Leave Balance page
if (fileName == "leavebalance") {
	breadcrumbs_title = "Available Leaves List"
	breadcrumbs_path = "Dashboard > Available Leaves"	
}

// Calendar page
if (fileName == "calendar.html") {
	breadcrumbs_title = "Calendar"
	breadcrumbs_path = "Dashboard > Calendar"
}

