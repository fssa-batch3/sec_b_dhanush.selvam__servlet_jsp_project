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
	breadcrumbs_title = "Role List";
	breadcrumbs_path = "Dashboard > Role Module";
}

// Leave page
if (fileName == "leave") {
	createFormTitle = "New Leave";
	createFormField1 = "Leave Name";
	createFormField2 = "Leave ID";
	tableTitle = "Leave List";
	columnTitle1 = "Leave"
	columnTitle2 = "Leave Id"
	breadcrumbs_title = "Leave List";
	breadcrumbs_path = "Dashboard > Leave Module";
}

// Create Employee page
if (fileName == "employee/new") {
	breadcrumbs_title = "Employee Portal";
	breadcrumbs_path = "Dashboard > Create Employee"
}

// Manage Employee page
if (fileName == "employee") {
	breadcrumbs_title = "Employees List"
	breadcrumbs_path = "Dashboard > Manage Employee"
}

// Apply leave page
if (fileName == "request/new") {
	breadcrumbs_title = "Leave Application";
	breadcrumbs_path = "Dashboard > Apply Leave"
}

// All Leave page
if (fileName == "request") {
	breadcrumbs_title = "All Request List"
	breadcrumbs_path = "Dashboard > Request List"
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

