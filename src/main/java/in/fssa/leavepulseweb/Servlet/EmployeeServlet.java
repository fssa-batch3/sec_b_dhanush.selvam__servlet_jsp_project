package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.dto.EmployeeDTO;
import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Employee;
import in.fssa.leavepulse.model.EmployeeRole;
import in.fssa.leavepulse.model.Role;
import in.fssa.leavepulse.service.EmployeeRoleService;
import in.fssa.leavepulse.service.EmployeeService;
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class ListAllEmployeeServlet
 */
@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		EmployeeService employeeService = new EmployeeService();
		List<Role> rolesList = null;
		List<EmployeeDTO> employeeList = null;

		try {
			
			rolesList = new RoleService().getAllRole();
			request.setAttribute("rolesList", rolesList);
			
			// Create Employee Page

			if ("new".equals(action)) {

				
				int lastEmployeeId = employeeService.getTableLastEmployeeId();
				request.setAttribute("lastEmployeeId", lastEmployeeId);

				RequestDispatcher rd = request.getRequestDispatcher("/create_employee.jsp");
				rd.forward(request, response);

			}

			// Delete Employee

			else if ("delete".equals(action)) {

				int id = Integer.parseInt(request.getParameter("id"));
				employeeService.deleteEmployee(id);
				response.sendRedirect(request.getContextPath() + "/employee");

			}

			// Employees List Page

			else if ("allemployees".equals(action)) {

				employeeList = employeeService.getAllEmployeeWithRole();
				request.setAttribute("employeesList", employeeList);

				RequestDispatcher rd = request.getRequestDispatcher("/list_all_employees.jsp");
				rd.forward(request, response);

			}

			else {

				int managerId = (int) request.getSession().getAttribute("LOGGEDUSER");
				employeeList = employeeService.getAllEmployeeWithRoleByManagerId(managerId);
				request.setAttribute("employeesList", employeeList);

				RequestDispatcher rd = request.getRequestDispatcher("/list_all_employees.jsp");
				rd.forward(request, response);

			}

		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		EmployeeService employeeService = new EmployeeService();
		Employee employee = new Employee();

		PrintWriter out = response.getWriter();

		try {

			// Update EmpRole

			if ("updaterole".equals(action)) {

				int id = Integer.parseInt(request.getParameter("employee_id"));
				EmployeeRoleService empRoleService = new EmployeeRoleService();
				EmployeeRole empRole = new EmployeeRole();
				empRole.setManagerId(Integer.parseInt(request.getParameter("manager_id")));

				int roleId = new RoleService().findRoleByRoleName(request.getParameter("role")).getRoleId();
				empRole.setRoleId(roleId);
				empRoleService.updateEmpRole(id, empRole);
				response.sendRedirect(request.getContextPath() + "/employee");

			}

			// Update Employee

			else if ("update".equals(action)) {

				int id = Integer.parseInt(request.getParameter("employee_id"));
				employee.setFirst_name(request.getParameter("first_name"));
				employee.setLast_name(request.getParameter("last_name"));
				employee.setEmail(request.getParameter("email"));
				employee.setPhone_no(Long.parseLong(request.getParameter("phone_no")));
				employee.setPassword(request.getParameter("password"));
				employee.setAddress(request.getParameter("address"));

				employeeService.updateEmployee(id, employee);
				response.sendRedirect(request.getContextPath() + "/profile");

			}

			// Create Employee

			else {

				employee.setFirst_name(request.getParameter("first_name"));
				employee.setLast_name(request.getParameter("last_name"));
				employee.setEmail(request.getParameter("email"));
				employee.setPhone_no(Long.parseLong(request.getParameter("phone")));
				employee.setPassword(request.getParameter("password"));
				employee.setAddress(request.getParameter("address"));
				int managerId = Integer.parseInt(request.getParameter("manager_id"));

				int roleId = new RoleService().findRoleByRoleName(request.getParameter("role")).getRoleId();
				employeeService.createEmployee(employee, managerId, roleId);
				response.sendRedirect(request.getContextPath() + "/employee");

			}

		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.print(e.getMessage());
		}

	}

}
