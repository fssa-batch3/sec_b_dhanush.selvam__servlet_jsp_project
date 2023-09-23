const url = window.location.href;

function getPathAfterLeavePulseWeb(url) {
	const index = url.indexOf("leavepulseweb/");
	return url.substring(index + "leavepulseweb/".length);
}

const fileName = getPathAfterLeavePulseWeb(url);

// Breadcrum section
let breadcrumbs_title = url;
let breadcrumbs_path = fileName;

// Leave and Role section for table
let createFormTitle = "";
let createFormField1 = "";
let createFormField2 = "";
let tableTitle = "";
let columnTitle1 = "";
let columnTitle2 = "";

// Role page
if (fileName == "role") {
	createFormTitle = "New Role";
	createFormField1 = "Role Name";
	createFormField2 = "Role ID";
	tableTitle = "Role List";
	columnTitle1 = "Role"
	columnTitle2 = "Role Id"
	breadcrumbs_title = "Role Module";
	breadcrumbs_path = "Dashboard > Role";
}

// Leave page
if (fileName == "leave") {
	createFormTitle = "New Leave";
	createFormField1 = "Leave Name";
	createFormField2 = "Leave ID";
	tableTitle = "Leave List";
	columnTitle1 = "Leave"
	columnTitle2 = "Leave Id"
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

// Calendar page
if (fileName == "calendar.html") {
	breadcrumbs_title = "Calendar"
	breadcrumbs_path = "Dashboard > Calendar"
}

