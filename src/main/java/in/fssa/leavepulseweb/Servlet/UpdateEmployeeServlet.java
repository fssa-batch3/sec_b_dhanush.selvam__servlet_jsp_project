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

/**
 * Servlet implementation class UpdateEmployeeServlet
 */
@WebServlet("/employee/update")
public class UpdateEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		EmployeeService employeeService = new EmployeeService();
		Employee employee = new Employee();
		employee.setFirst_name(request.getParameter("first_name"));
		employee.setLast_name(request.getParameter("last_name"));
		employee.setEmail(request.getParameter("email"));
		employee.setPhone_no(Long.parseLong(request.getParameter("phone")));
		employee.setPassword(request.getParameter("password"));
		employee.setAddress(request.getParameter("address"));

		PrintWriter out = response.getWriter();
		
		try {
			employeeService.updateEmployee(id, employee);
			response.sendRedirect(request.getContextPath() + "/profile");
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.println(e.getMessage());
		} 
		
	}

}
