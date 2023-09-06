package in.fssa.leavepulseweb.Servlet;

import java.io.IOException; 
import java.io.PrintWriter;
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

		PrintWriter out = response.getWriter();
			
		try {
			
			int employee_id = employeeService.login(email, password);
			
			List<EmployeeRole> empRoleList = new ArrayList<>();
			empRoleList = new EmployeeRoleService().getAllEmpRole();
			
			List<Integer> managerList = new ArrayList<>();
			for (EmployeeRole id : empRoleList) {
				managerList.add(id.getManagerId());
			}
			
			String user_type = "";
			if (employee_id == 1) user_type = "admin";
			else if (managerList.contains(employee_id)) user_type = "manager";
			else user_type = "employee";
			
			HttpSession session = request.getSession();
			session.setAttribute("LOGGEDUSER", employee_id);	
			session.setAttribute("LOGGEDUSERTYPE", user_type);
			response.sendRedirect(request.getContextPath()+"/profile");
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.println(e.getMessage());
		}
			
	}

}
