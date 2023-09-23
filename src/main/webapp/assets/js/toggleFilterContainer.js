let isFilterDropdownOpen = false;

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

// Get all the filter containers
const filterContainers = document.querySelectorAll(".filter_field_container");

// Add click event listeners to each filter container
filterContainers.forEach(container => {
    const pTag = container.querySelector(".field_name_container p");
    const checkbox = container.querySelector(".checkbox");

    pTag.addEventListener("click", (event) => {
        // Prevent the checkbox from toggling when clicking on the <p> tag
        event.preventDefault();

        // Toggle the checkbox's checked state
        checkbox.checked = !checkbox.checked;
    });
});