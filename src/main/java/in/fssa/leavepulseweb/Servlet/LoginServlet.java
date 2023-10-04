package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Employee;
import in.fssa.leavepulse.model.EmployeeRole;
import in.fssa.leavepulse.service.EmployeeRoleService;
import in.fssa.leavepulse.service.EmployeeService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		EmployeeService employeeService = new EmployeeService();

		String email = request.getParameter("email");
		String password = request.getParameter("password");
					
		try {
			
			int employeeId = employeeService.login(email, password);
			Employee employee = employeeService.findEmployeeByEmployeeId(employeeId);
			String employeeName = employee.getFirstName() + " " + employee.getLastName();
			
			List<EmployeeRole> empRoleList = new ArrayList<>();
			empRoleList = new EmployeeRoleService().getAllEmpRole();
			
			List<Integer> managerList = new ArrayList<>();
			for (EmployeeRole id : empRoleList) {
				managerList.add(id.getManagerId());
			}
			
			String userType = "";
			if (employeeId == 1) userType = "admin";
			else if (managerList.contains(employeeId)) userType = "manager";
			else userType = "employee";
			
			HttpSession session = request.getSession();
			session.setAttribute("LOGGEDUSER", employeeId);	
			session.setAttribute("LOGGEDUSERNAME", employeeName);
			session.setAttribute("LOGGEDUSERTYPE", userType);
			response.sendRedirect(request.getContextPath()+"/index");
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", e.getMessage());
			request.setAttribute("email", email);
			request.setAttribute("password", password);
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
			
	}

}
