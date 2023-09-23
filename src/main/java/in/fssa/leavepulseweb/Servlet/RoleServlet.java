package in.fssa.leavepulseweb.Servlet;

import java.io.IOException ;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
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
 * Servlet implementation class RoleServlet
 */
@WebServlet("/role")
public class RoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getParameter("action");
        RoleService roleService = new RoleService();

	    if ("delete".equals(action)) {
	        
	        int id = Integer.parseInt(request.getParameter("id"));

	        try {
	            roleService.deleteRole(id);
	            response.sendRedirect(request.getContextPath() + "/role");
	        } catch (ServiceException | ValidationException e) {
	            e.printStackTrace();
	            response.getWriter().println(e.getMessage());
	        }
	    } 
	    
	    else {
	        
	        try {
	            List<Role> rolesList = roleService.getAllRole();
	            int lastRoleId = roleService.getTableLastRoleId();

	            request.setAttribute("rolesList", rolesList);
	            request.setAttribute("lastRoleId", lastRoleId);

	            RequestDispatcher rd = request.getRequestDispatcher("/role.jsp");
	            rd.forward(request, response);
	        } catch (ServiceException e) {
	            e.printStackTrace();
	        }
	    }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		RoleService roleService = new RoleService();
		Role role = new Role();
		
		String role_name = request.getParameter("role_name");
		int role_id = Integer.parseInt(request.getParameter("role_id"));

		PrintWriter out = response.getWriter();
			
		try {
			
			role.setRoleName(role_name);
			if (roleService.findRoleByRoleId(role_id) == null) roleService.createRole(role);
			else roleService.updateRole(role_id, role);
			response.sendRedirect(request.getContextPath() + "/role");

		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.println(e.getMessage());
		}

	}

}
