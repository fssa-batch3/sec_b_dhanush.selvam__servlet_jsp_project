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
import in.fssa.leavepulse.model.Leave;
import in.fssa.leavepulse.service.LeaveService;

/**
 * Servlet implementation class UpdateLeaveServlet
 */
@WebServlet("/leave/update")
public class UpdateLeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		LeaveService leaveService = new LeaveService();
		Leave leave = new Leave();
		leave.setLeaveType(request.getParameter("leave_type"));
		
		PrintWriter out = response.getWriter();
		
		try {
			leaveService.updateLeave(id, leave);
			response.sendRedirect(request.getContextPath() + "/leaves");
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.println(e.getMessage());
		}
		
	}

}
