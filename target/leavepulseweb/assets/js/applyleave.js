let isLeaveTypeContainerDropdownOpen = false;

function toggleLeaveSelectContainer() {
    const leaveTypeContainer = document.querySelector(".leave_type_container");
    const selectTagButton = document.querySelector(".select_tag");
    isLeaveTypeContainerDropdownOpen = !isLeaveTypeContainerDropdownOpen;
    
    if (isLeaveTypeContainerDropdownOpen) {
        leaveTypeContainer.style.display = "block";
        selectTagButton.style.outline = "1.5px solid #2d7474";
    } else {
        leaveTypeContainer.style.display = "none";
        selectTagButton.style.outline = "none";
    }
}

function selectLeave(leaveType) {
    const selectTagButton = document.querySelector(".select_tag");
    selectTagButton.textContent = leaveType;
    toggleLeaveSelectContainer();
}

document.body.addEventListener("click", function(event) {
    const leaveTypeContainer = document.querySelector(".leave_type_container");
    const selectTagButton = document.querySelector(".select_tag");
    if (!selectTagButton.contains(event.target) && isLeaveTypeContainerDropdownOpen) {
        leaveTypeContainer.style.display = "none";
        selectTagButton.style.outline = "none";
        isLeaveTypeContainerDropdownOpen = false;
    }
})

