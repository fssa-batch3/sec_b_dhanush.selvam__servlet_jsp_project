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
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class DeleteRoleServlet
 */
@WebServlet("/role/delete")
public class DeleteRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		RoleService roleService = new RoleService();
		
		PrintWriter out = response.getWriter();
		
		try {
			roleService.deleteRole(id);
			out.print("Role deleted successfully");
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
		
	}

}
