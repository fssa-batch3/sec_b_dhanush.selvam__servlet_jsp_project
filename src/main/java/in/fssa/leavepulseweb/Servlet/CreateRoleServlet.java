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
import in.fssa.leavepulse.model.Role;
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class CreateRole
 */
@WebServlet("/role/create")
public class CreateRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException  {
		
		RoleService roleService = new RoleService();
		Role role = new Role();
		role.setRoleName(request.getParameter("role_name"));
		
		PrintWriter out = response.getWriter();
		
			try {
				roleService.createRole(role);
				response.sendRedirect(request.getContextPath() + "/roles");
				
			} catch (ServiceException e) {
				e.printStackTrace();
				out.println(e.getMessage());
			} catch (ValidationException e) {
				e.printStackTrace();
				out.println(e.getMessage());
			}
		
	}

}
