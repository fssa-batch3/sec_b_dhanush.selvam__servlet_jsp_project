package in.fssa.leavepulseweb.Servlet;

import java.io.IOException; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.dto.EmployeeDTO;
import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.service.EmployeeService;

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
		
		int employeeid = (int) request.getSession().getAttribute("LOGGEDUSER");
		EmployeeDTO employee = null;
		
		try {
			
			employee = new EmployeeService().findEmployeeWithRole(employeeid);
			request.setAttribute("EMPLOYEEDETAILS", employee);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
			dispatcher.forward(request, response);
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}

}
