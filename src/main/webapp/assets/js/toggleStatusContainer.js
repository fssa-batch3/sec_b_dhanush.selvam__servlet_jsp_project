let isStatusContainerDropdownOpen = false;

function toggleStatusSelectContainer() {
	const statusContainer = document.querySelector(".status_type_container");
	const selectTagButton = document.querySelector(".select_tag");
	isStatusContainerDropdownOpen = !isStatusContainerDropdownOpen;

	if (isStatusContainerDropdownOpen) {
		statusContainer.style.display = "block";
		selectTagButton.style.outline = "1.5px solid #2d7474";
	} else {
		statusContainer.style.display = "none";
		selectTagButton.style.outline = "none";
	}
}

function selectStatus(status) {
	const selectTagButton = document.querySelector(".select_tag");
	selectTagButton.textContent = status;
	document.getElementById("selectedStatus").value = status;
	toggleStatusSelectContainer();
}

document.body.addEventListener("click", function(event) {
	const statusContainer = document.querySelector(".status_type_container");
	const selectTagButton = document.querySelector(".select_tag");
	if (!selectTagButton.contains(event.target) && isStatusContainerDropdownOpen) {
		statusContainer.style.display = "none";
		selectTagButton.style.outline = "none";
		isStatusContainerDropdownOpen = false;
	}
})
