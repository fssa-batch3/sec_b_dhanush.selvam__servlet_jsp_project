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
 * Servlet implementation class EditEmployeeServlet
 */
@WebServlet("/employee/edit")
public class EditEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Employee employee = new EmployeeService().findEmployeeByEmployeeId(Integer.parseInt(request.getParameter("id")));
			int managerId = new EmployeeRoleService().findEmpRoleByEmployeeId(employee.getEmployee_id()).getManagerId();
			int roleId = new EmployeeRoleService().findEmpRoleByEmployeeId(employee.getEmployee_id()).getRoleId();
			String role = new RoleService().findRoleByRoleId(roleId).getRoleName();
			request.setAttribute("employees", employee);
			request.setAttribute("manager", managerId);
			request.setAttribute("role_name", role);
			
			RequestDispatcher rd = request.getRequestDispatcher("/update_employee.jsp");
			rd.forward(request, response);
			
		} catch (NumberFormatException | ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}
	
}
