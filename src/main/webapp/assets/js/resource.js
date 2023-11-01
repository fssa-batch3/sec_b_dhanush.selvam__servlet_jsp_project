const url = window.location.href;

function getPathAfterLeavePulseWeb(url) {
	const index = url.indexOf("leavepulseweb/");
	return url.substring(index + "leavepulseweb/".length);
}

const fileName = getPathAfterLeavePulseWeb(url);

// Breadcrum section
let breadcrumbsTitle = url;
let breadcrumbsPath = fileName;

// Role page
if (fileName == "role") {
	breadcrumbsTitle = "Role Module";
	breadcrumbsPath = "Dashboard > Role";
}

// Leave page
if (fileName == "leave") {
	breadcrumbsTitle = "Leave Module";
	breadcrumbsPath = "Dashboard > Leave Type";
}

// Create Employee page
if (fileName == "employee?action=new") {
	breadcrumbsTitle = "Create Employee";
	breadcrumbsPath = "Dashboard > New Employee"
}

// Team Members page
if (fileName == "employee") {
	breadcrumbsTitle = "Team Members"
	breadcrumbsPath = "Dashboard > Manage Employee"
}

// All Employee page
if (fileName == "employee?action=allemployees") {
	breadcrumbsTitle = "Employees List"
	breadcrumbsPath = "Dashboard > All Employees"
}

// Apply leave page
if (fileName == "request?action=new") {
	breadcrumbsTitle = "Leave Application";
	breadcrumbsPath = "Dashboard > Apply Leave"
}

// All Request page
if (fileName == "request?action=allrequests") {
	breadcrumbsTitle = "Requests List"
	breadcrumbsPath = "Dashboard > All Request"
}

// Team Members Request page
if (fileName == "request") {
	breadcrumbsTitle = "Team Members Requests List"
	breadcrumbsPath = "Dashboard > Leave Request"
}

// Leave History page
if (fileName == "request?action=employeerequests") {
	breadcrumbsTitle = "Requests List"
	breadcrumbsPath = "Dashboard > Leave History"
}

// Profile page
if (fileName == "profile") {
	breadcrumbsTitle = "User Profile"
	breadcrumbsPath = "Dashboard > Profile"	
}

// Leave Balance page
if (fileName == "leavebalance") {
	breadcrumbsTitle = "Available Leaves List"
	breadcrumbsPath = "Dashboard > Available Leaves"	
}

// Calendar page
if (fileName == "calendar.html") {
	breadcrumbsTitle = "Calendar"
	breadcrumbsPath = "Dashboard > Calendar"
}

function noRecord(tableContent) {
	const row = document.createElement('div');
    row.classList.add('table-row');
    
    row.innerHTML = `<div class="no-record-row">No Record Found</div>`;
    tableContent.appendChild(row);
}

function scroll(ans) {
	window.scrollTo({
        top: ans,
        behavior: "smooth"
    });
}

// Preventing to select more than a checkbox
			
function handleCheckboxClick(checkboxId) {
    const checkboxes = document.querySelectorAll('.checkbox');		
    checkboxes.forEach((checkbox) => {
        if (checkbox.id !== checkboxId) {
            checkbox.checked = false;
        }
    });
}

function checkEmpty(value, field, message) {
	if (value == "") {
		alert(message + " cannot be empty");
		field.value = "";
		field.focus();
    	return false;
	}
	return true;
}

function checkLength(pattern, value, field, message) {
	if (value.length < 3 || value.length > 24) {
        alert(message + " should contain a minimum of 3 letters and a maximum of 24 letters.");
        field.focus();
        return false;
    } 
	return true;
}

function checkPattern(pattern, value, field, message) {
	if (!pattern.test(value)) {
        alert(message);
        field.value = "";
        field.focus();
        return false;
    } 
	return true;
}

