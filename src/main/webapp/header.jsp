<header>
    <style>
        /* Your CSS styles here */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
        }

        /* Navbar styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: black; /* Background color */
            padding: 20px;
            width: 100%;
            top: 0;
            z-index: 1;
        }

        .logo a {
            text-decoration: none;
            color: #fff; /* Logo text color */
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links {
            list-style-type: none;
            display: flex;
        }

        .nav-links li {
            margin: 0 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: #fff; /* Link text color */
            font-size: 16px;
            font-weight: 500;
        }

    </style>
    
    <% String loggedUserType = (String) request.getSession().getAttribute("LOGGEDUSERTYPE"); %>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    $(document).ready(function() {
	        let loggedUserType = "<%= loggedUserType %>";
	        if (loggedUserType == "admin") $(".admin-access").hide();
	        else if (loggedUserType == "manager") $(".manager-access").hide();
	        else {
	        	$(".employee-access").hide();
	        	$(".manager-access").hide();
	        }
	    });
	</script>
	
     <nav class="navbar">
        <div class="logo">
            <a href="#">LeavePulse</a>
        </div>
        <ul class="nav-links">
            <li class="manager-access"><a href="roles">Role</a></li>
            <li class="manager-access"><a href="employees">Employee</a></li>
            <li class="manager-access"><a href="leaves">Leave</a></li>
            <li class="employee-access"><a href="requests">Request</a></li>
            <li class="manager-access"><a href="empRoles">Emp-Role</a></li>
            <li class="admin-access"><a href="request/new"> Apply Leave </a></li>
            <li class="admin-access"><a href="leaveHistory"> Leave History </a></li>
            <li><a href="profile">Profile</a></li>
        </ul>
    </nav>

</header>

