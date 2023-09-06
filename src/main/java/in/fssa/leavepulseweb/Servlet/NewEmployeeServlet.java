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

import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.model.Role;
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class NewEmployeeServlet
 */
@WebServlet("/employee/new")
public class NewEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Role> roleList = new ArrayList<>();
		
		try {
			
			roleList = new RoleService().getAllRole();
			request.setAttribute("roleList", roleList);
			
			RequestDispatcher rd = request.getRequestDispatcher("/create_employee.jsp");
			rd.forward(request, response);
			
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
	}

}
