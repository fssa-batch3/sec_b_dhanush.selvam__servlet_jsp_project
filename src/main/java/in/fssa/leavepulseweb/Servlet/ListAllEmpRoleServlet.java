package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.model.EmployeeRole;
import in.fssa.leavepulse.service.EmployeeRoleService;

/**
 * Servlet implementation class ListAllEmpRoleServlet
 */
@WebServlet("/empRoles")
public class ListAllEmpRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			List<EmployeeRole> empRoleList = new EmployeeRoleService().getAllEmpRole();
			request.setAttribute("empRolesList", empRoleList);
			
			RequestDispatcher rd = request.getRequestDispatcher("/list_all_emp_roles.jsp");
			rd.forward(request, response);
			
		} catch (ServiceException e) {
			e.printStackTrace();
		}

	}
}
