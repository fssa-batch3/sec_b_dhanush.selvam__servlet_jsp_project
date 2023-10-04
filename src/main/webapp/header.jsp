<%@page import="in.fssa.leavepulse.model.Employee"%>
<div>

  <div class="header">

    <div class="logo_container">
      <h2 class = "logo"> <a href = "<%=request.getContextPath()%>/index" class="anchor_logo"> LeavePulse </a> </h2>
    </div>
    
	<% String employeeName = (String) request.getSession().getAttribute("LOGGEDUSERNAME"); %>

    <div class="profile_container" onclick="toggleProfileContainer()">
      <img src="<%=request.getContextPath()%>/assets/images/profile.jpg" class="profile_photo">
      <p class="user_name"> <%= employeeName %> </p>
      <i class="fa-solid fa-caret-down"></i>
      <i class="fa-solid fa-caret-up"></i>
    </div>

  </div>

  <div class="dropdown_container">

	<a href = "<%= request.getContextPath() %>/profile">
		<div class="dropdown_list_container">
	      <div class="icon_container"> <i class="fa-solid fa-user"></i> </div>
	      <div> <p class="dropdown_list"> Profile </p></div>
	    </div>
	</a>
	
	<a href = "<%= request.getContextPath() %>/logout">
	    <div class="dropdown_list_container">
	      <div class="icon_container"> <i class="fa-solid fa-right-from-bracket"></i> </div>
	      <div> <p class="dropdown_list"> Log Out </p></div>
	    </div>
    </a>
    
  </div>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	let isDropdownOpen = false;
	
	function toggleProfileContainer() {
	  const dropdownContainer = document.querySelector(".dropdown_container");
	  const downIcon = document.querySelector(".fa-caret-down");
	  const upIcon = document.querySelector(".fa-caret-up");
	  isDropdownOpen = !isDropdownOpen;
	  dropdownContainer.style.display = isDropdownOpen ? "block" : "none";
	  if (isDropdownOpen){
		  downIcon.style.display = "none";
		  upIcon.style.display = "block";
	  }
	  else {
		  upIcon.style.display = "none";
		  downIcon.style.display = "block";
	  }
	}
	
	document.body.addEventListener("click", function (event) {
	  const dropdownContainer = document.querySelector(".dropdown_container");
	  const profileContainer = document.querySelector(".profile_container");
	  const downIcon = document.querySelector(".fa-caret-down");
	  const upIcon = document.querySelector(".fa-caret-up");
	  if (!profileContainer.contains(event.target) && isDropdownOpen) {
	    dropdownContainer.style.display = "none";
	    upIcon.style.display = "none";
		downIcon.style.display = "block";
	    isDropdownOpen = false;
	  }
	});
	
</script>


