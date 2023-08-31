package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Employee;
import in.fssa.leavepulse.service.EmployeeService;
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class CreateEmployeeServlet
 */
@WebServlet("/CreateEmployeeServlet")
public class CreateEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		EmployeeService employeeService = new EmployeeService();
		Employee employee = new Employee();
		employee.setFirst_name(request.getParameter("first_name"));
		employee.setLast_name(request.getParameter("last_name"));
		employee.setEmail(request.getParameter("email"));
		employee.setPhone_no(Long.parseLong(request.getParameter("phone")));
		employee.setPassword(request.getParameter("password"));
		employee.setAddress(request.getParameter("address"));
		int managerId = Integer.parseInt(request.getParameter("manager_id"));
		
		PrintWriter out = response.getWriter();
		
		try {
			int roleId = new RoleService().findRoleByRoleName(request.getParameter("role")).getRoleId();
			employeeService.createEmployee(employee, roleId, managerId);
			response.sendRedirect(request.getContextPath() + "/employees");
		
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.print(e.getMessage());
		}

	}

}
