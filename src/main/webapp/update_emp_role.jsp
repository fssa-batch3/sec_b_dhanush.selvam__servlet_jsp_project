<%@page import="in.fssa.leavepulse.model.EmployeeRole"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Edit Employee-Role </title>
<style>
		
	*{
	  margin: 0;
	  padding: 0;
	  outline: none;
	  box-sizing: border-box;
	}
	body{
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  min-height: 80vh;
	  padding: 10px;
	  font-family: 'Poppins', sans-serif;
	}
	.container{
	  max-width: 800px;
	  background: #fff;
	  width: 500px;
	  padding: 25px 40px 10px 40px;
	  box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
	}
	.container .text{
	  text-align: center;
	  font-size: 41px;
	  font-weight: 600;
	}
	
	.container form .form-row{
	  display: flex;
	  margin: 32px 0;
	}
	form .form-row .input-data{
	  width: 100%;
	  height: 40px;
	  margin: 0 20px;
	  position: relative;
	}
	.input-data input {
	  display: block;
	  width: 100%;
	  height: 100%;
	  border: none;
	  font-size: 17px;
	  border-bottom: 2px solid rgba(0,0,0, 0.12);
	}
	.input-data input:focus ~ label, .textarea textarea:focus ~ label,
	.input-data input:valid ~ label, .textarea textarea:valid ~ label{
	  transform: translateY(-20px);
	  font-size: 14px;
	  color: #3498db;
	}
	.input-data label{
	  position: absolute;
	  pointer-events: none;
	  bottom: 10px;
	  font-size: 16px;
	  transition: all 0.3s ease;
	}
	
	.submit-btn .input-data{
	  overflow: hidden;
	  height: 45px!important;
	  width: 25%!important;
	}
	.submit-btn .input-data .inner{
	  height: 100%;
	  width: 300%;
	  position: absolute;
	  left: -100%;
	  background: -webkit-linear-gradient(right, #56d8e4, #9f01ea, #56d8e4, #9f01ea);
	  transition: all 0.4s;
	}
	.submit-btn .input-data:hover .inner{
	  left: 0;
	}
	.submit-btn .input-data input{
	  background: none;
	  border: none;
	  color: #fff;
	  font-size: 17px;
	  font-weight: 500;
	  text-transform: uppercase;
	  letter-spacing: 1px;
	  cursor: pointer;
	  position: relative;
	  z-index: 2;
	}
	
	.input-data select {
    display: block;
    width: 100%;
    height: 100%;
    border: none;
    font-size: 17px;
    border-bottom: 2px solid rgba(0, 0, 0, 0.12);
    appearance: none; /* Removes the default arrow in some browsers */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%233498db'%3E%3Cpath d='M7 10l5 5 5-5H7z'/%3E%3C/svg%3E"); /* Custom arrow icon */
    background-repeat: no-repeat;
    background-position: right center;
	}
	
	.input-data select:focus ~ label,
	.input-data select:valid ~ label {
	    transform: translateY(-20px);
	    font-size: 14px;
	    color: #3498db;
	}
	
	@media (max-width: 700px) {
	  .container .text{
	    font-size: 30px;
	  }
	  .container form{
	    padding: 10px 0 0 0;
	  }
	  .container form .form-row{
	    display: block;
	  }
	  form .form-row .input-data{
	    margin: 35px 0!important;
	  }
	  .submit-btn .input-data{
	    width: 40%!important;
	  }
	}
	
	.input-data select {
    display: block;
    width: 100%;
    height: 100%;
    border: none;
    font-size: 17px;
    border-bottom: 2px solid rgba(0, 0, 0, 0.12);
    appearance: none; /* Removes the default arrow in some browsers */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%233498db'%3E%3Cpath d='M7 10l5 5 5-5H7z'/%3E%3C/svg%3E"); /* Custom arrow icon */
    background-repeat: no-repeat;
    background-position: right center;
	}
	
	.input-data select:focus ~ label,
	.input-data select:valid ~ label {
	    transform: translateY(-20px);
	    font-size: 14px;
	    color: #3498db;
	}
	
	.readonly-label {
		transform: translateY(-20px);
	    font-size: 14px;
	    color: #3498db;
	}
	
</style>
</head>
<body>

	<% EmployeeRole empRole = new EmployeeRole(); %>
	<% empRole = (EmployeeRole)request.getAttribute("empRoles"); %>
	<% String role_name = (String)request.getAttribute("role_name"); %>

	<div class="container">
	
      <div class="text"> Edit Employee-Role </div>
      
      <form action="update?id=<%= empRole.getEmpRoleId() %>" method="post">
      
         <div class="form-row">
            <div class="input-data">
               <input type="text" name="employee_id" value = "<%= empRole.getEmployeeId() %>" readonly>
               <div class="underline"></div>
               <label class="readonly-label" for="employee_id">Employee ID</label>
            </div>
         </div>
         
         <div class="form-row">
            <div class="input-data">
               <input type="text" name="manager_id" value = "<%= empRole.getManagerId() %>" required>
               <div class="underline"></div>
               <label for="manager_id">Manager ID</label>
            </div>
         </div>
         
         <div class="form-row">
            <div class="input-data">
				<select name="role">
				    <option value="CEO" <%= "CEO".equals(role_name) ? "selected" : "" %>>CEO</option>
				    <option value="CPO" <%= "CPO".equals(role_name) ? "selected" : "" %>>CPO</option>
				    <option value="Manager" <%= "Manager".equals(role_name) ? "selected" : "" %>>Manager</option>
				    <option value="Developer" <%= "Developer".equals(role_name) ? "selected" : "" %>>Developer</option>
				    <option value="Tester" <%= "Tester".equals(role_name) ? "selected" : "" %>>Tester</option>
				</select>
				
				<label for="role">Role</label>
            </div>
         </div>
         
         <div class="form-row submit-btn">
            <div class="input-data">
               <div class="inner"></div>
               <input type="submit" value="submit">
            </div>
         </div>
         
      </form>
	      
   	</div>

</body>
</html>