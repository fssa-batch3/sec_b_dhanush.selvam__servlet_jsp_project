package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
			
			// Create Employee Page

			if ("new".equals(action)) {
				
				rolesList = new RoleService().getAllRole();
				int lastEmployeeId = employeeService.getTableLastEmployeeId();
				request.setAttribute("rolesList", rolesList);
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
				rolesList = new RoleService().getAllRole();
				request.setAttribute("employeesList", employeeList);
				request.setAttribute("rolesList", rolesList);
				

				RequestDispatcher rd = request.getRequestDispatcher("/list_all_employees.jsp");
				rd.forward(request, response);

			}

			else {

				int managerId = (int) request.getSession().getAttribute("LOGGEDUSER");
				employeeList = employeeService.getAllEmployeeWithRoleByManagerId(managerId);
				rolesList = new RoleService().getAllRole();
				request.setAttribute("employeesList", employeeList);
				request.setAttribute("rolesList", rolesList);

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
		List<Role> rolesList = null;

		// Update EmpRole

		if ("updaterole".equals(action)) {
			
			int managerId = (int) request.getSession().getAttribute("LOGGEDUSER");
			List<EmployeeDTO> employeesList = null;
			String role = null;
			int id = 0;
			
			try {

				employeesList = employeeService.getAllEmployeeWithRoleByManagerId(managerId);
				rolesList = new RoleService().getAllRole();
				
				id = Integer.parseInt(request.getParameter("employee_id"));
				EmployeeRoleService empRoleService = new EmployeeRoleService();
				EmployeeRole empRole = new EmployeeRole();
				empRole.setManagerId(Integer.parseInt(request.getParameter("manager_id")));
				
				role = request.getParameter("role");

				int roleId = new RoleService().findRoleByRoleName(role).getRoleId();
				empRole.setRoleId(roleId);
				empRoleService.updateEmpRole(id, empRole);
				response.sendRedirect(request.getContextPath() + "/employee");
			
			} catch (ServiceException | ValidationException e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", e.getMessage());
				request.setAttribute("employeesList", employeesList);
				request.setAttribute("rolesList", rolesList);
				request.setAttribute("employeeId", id);
				request.setAttribute("role", role);
				request.getRequestDispatcher("/list_all_employees.jsp").forward(request, response);

			}
			
		}

		// Update Employee

		else if ("update".equals(action)) {
			
			EmployeeDTO loginEmployee = null;
			
			try {

				int id = Integer.parseInt(request.getParameter("employee_id"));
				employee.setFirstName(request.getParameter("first_name"));
				employee.setLastName(request.getParameter("last_name"));
				employee.setEmail(request.getParameter("email"));
				employee.setPhoneNo(Long.parseLong(request.getParameter("phone_no")));
				employee.setAddress(request.getParameter("address"));
				
				loginEmployee = new EmployeeService().findEmployeeWithRole(id);
				request.setAttribute("loginEmployee", employee);

				employeeService.updateEmployee(id, employee);
				response.sendRedirect(request.getContextPath() + "/profile");
				
			} catch (ServiceException | ValidationException e) {
				e.printStackTrace();
				request.setAttribute("loginEmployee", loginEmployee);
				request.setAttribute("errorMessage", e.getMessage());
				request.setAttribute("employee", employee);
				request.getRequestDispatcher("/profile.jsp").forward(request, response);
			}

		}

		// Create Employee

		else {
			
			int lastEmployeeId = 0;
			String role = null;
			
			try {
				
				rolesList = new RoleService().getAllRole();
				lastEmployeeId = employeeService.getTableLastEmployeeId();

				employee.setFirstName(request.getParameter("first_name"));
				employee.setLastName(request.getParameter("last_name"));
				employee.setEmail(request.getParameter("email"));
				employee.setPhoneNo(Long.parseLong(request.getParameter("phone")));
				employee.setPassword(request.getParameter("password"));
				employee.setAddress(request.getParameter("address"));
				int managerId = Integer.parseInt(request.getParameter("manager_id"));
				
				role = request.getParameter("role");

				String dateString = request.getParameter("joining_date");
		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				employee.setJoiningDate(LocalDate.parse(dateString, formatter));
		            
				int roleId = new RoleService().findRoleByRoleName(role).getRoleId();
				employeeService.createEmployee(employee, managerId, roleId);
				response.sendRedirect(request.getContextPath() + "/employee");
				
			} catch (ServiceException | ValidationException e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", e.getMessage());
				request.setAttribute("employee", employee);
				request.setAttribute("role", role);
				request.setAttribute("managerId", rolesList);
				request.setAttribute("rolesList", rolesList);
				request.setAttribute("lastEmployeeId", lastEmployeeId);
				request.getRequestDispatcher("/create_employee.jsp").forward(request, response);
			}

		}
		
	}

}
