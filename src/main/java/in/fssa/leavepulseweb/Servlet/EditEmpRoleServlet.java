package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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
 * Servlet implementation class EditEmpRoleServlet
 */
@WebServlet("/empRole/edit")
public class EditEmpRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			EmployeeRole empRole = new EmployeeRoleService().findEmpRoleByEmpRoleId(Integer.parseInt(request.getParameter("id")));
			String role = new RoleService().findRoleByRoleId(empRole.getRoleId()).getRoleName();
			request.setAttribute("empRoles", empRole);
			request.setAttribute("role_name", role);
			
			RequestDispatcher rd = request.getRequestDispatcher("/update_emp_role.jsp");
			rd.forward(request, response);
			
		} catch (NumberFormatException | ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}

}
