let isRoleContainerDropdownOpen = false;

function toggleRoleSelectContainer() {
    const roleContainer = document.querySelector(".role_type_container");
    const selectTagButton = document.querySelector(".select_tag");
    isRoleContainerDropdownOpen = !isRoleContainerDropdownOpen;
    
    if (isRoleContainerDropdownOpen) {
        roleContainer.style.display = "block";
        selectTagButton.style.outline = "1.5px solid #2d7474";
    } else {
        roleContainer.style.display = "none";
        selectTagButton.style.outline = "none";
    }
}

function selectRole(role) {
    const selectTagButton = document.querySelector(".select_tag");
    selectTagButton.textContent = role;
    toggleRoleSelectContainer();
}

document.body.addEventListener("click", function(event) {
    const roleContainer = document.querySelector(".role_type_container");
    const selectTagButton = document.querySelector(".select_tag");
    if (!selectTagButton.contains(event.target) && isRoleContainerDropdownOpen) {
        roleContainer.style.display = "none";
        selectTagButton.style.outline = "none";
        isRoleContainerDropdownOpen = false;
    }
})

