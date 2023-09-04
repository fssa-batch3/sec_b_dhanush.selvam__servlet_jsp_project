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
import in.fssa.leavepulse.model.EmployeeRole;
import in.fssa.leavepulse.service.EmployeeRoleService;
import in.fssa.leavepulse.service.RoleService;

/**
 * Servlet implementation class UpdateEmpRoleServlet
 */
@WebServlet("/empRole/update")
public class UpdateEmpRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		EmployeeRoleService empRoleService = new EmployeeRoleService();
		EmployeeRole empRole = new EmployeeRole();
		empRole.setManagerId(Integer.parseInt(request.getParameter("manager_id")));
		
		PrintWriter out = response.getWriter();
		
		try {
			int roleId = new RoleService().findRoleByRoleName(request.getParameter("role")).getRoleId();
			empRole.setRoleId(roleId);
			empRoleService.updateEmpRole(id, empRole);
			response.sendRedirect(request.getContextPath() + "/empRoles");
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.print(e.getMessage());
		}
		
	}

}
