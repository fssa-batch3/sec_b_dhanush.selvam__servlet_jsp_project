let isFilterDropdownOpen = false;

function stopPropagation(event) {
        event.stopPropagation();
}

function toggleFilterContainer() {
	
    const filterDropDownContainer = document.querySelector(".filter_dropdown_container");
    isFilterDropdownOpen = !isFilterDropdownOpen;
    filterDropDownContainer.style.display = isFilterDropdownOpen ? "block" : "none";
    
}

document.body.addEventListener("click", function (event) {
    const filterDropDownContainer = document.querySelector(".filter_dropdown_container");
    const filterButtonContainer = document.querySelector(".filter_container");
    if (!filterButtonContainer.contains(event.target) && isFilterDropdownOpen) {
        filterDropDownContainer.style.display = "none";
        isFilterDropdownOpen = false;
    }
});
