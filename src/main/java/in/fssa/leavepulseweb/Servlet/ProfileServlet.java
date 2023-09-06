package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Employee;
import in.fssa.leavepulse.service.EmployeeRoleService;
import in.fssa.leavepulse.service.EmployeeService;
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int loggedUserId = (int) request.getSession().getAttribute("LOGGEDUSER");
			
		try {
			
			Employee employeeDetails = new EmployeeService().findEmployeeByEmployeeId(loggedUserId);
			int managerId = new EmployeeRoleService().findEmpRoleByEmployeeId(employeeDetails.getEmployee_id()).getManagerId();
			int roleId = new EmployeeRoleService().findEmpRoleByEmployeeId(employeeDetails.getEmployee_id()).getRoleId();
			String role = new RoleService().findRoleByRoleId(roleId).getRoleName();
			request.setAttribute("EMPLOYEEDETAILS", employeeDetails);
			request.setAttribute("manager", managerId);
			request.setAttribute("role_name", role);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
			dispatcher.forward(request, response);
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}

}
