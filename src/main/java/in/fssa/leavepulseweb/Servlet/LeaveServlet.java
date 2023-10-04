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
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Leave;
import in.fssa.leavepulse.service.LeaveService;

/**
 * Servlet implementation class LeaveServlet
 */
@WebServlet("/leave")
public class LeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getParameter("action");
		LeaveService leaveService = new LeaveService();
		
		if ("delete".equals(action)) {
			        
	        int id = Integer.parseInt(request.getParameter("id"));
	
	        try {
	        	leaveService.deleteLeave(id);
	            response.sendRedirect(request.getContextPath() + "/leave");
	        } catch (ServiceException | ValidationException e) {
	            e.printStackTrace();
	            response.getWriter().println(e.getMessage());
	        }
	    } 
		
		else {

			try {
	
				List<Leave> leavesList = leaveService.getAllLeave();
				int lastLeaveId = leaveService.getTableLastLeaveId();
				
				request.setAttribute("leavesList", leavesList);
				request.setAttribute("lastLeaveId", lastLeaveId);
	
				RequestDispatcher rd = request.getRequestDispatcher("/leave.jsp");
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

		LeaveService leaveService = new LeaveService();
		Leave leave = new Leave();
		
		String leaveName = request.getParameter("leave_name");
		int leaveId = Integer.parseInt(request.getParameter("leave_id"));
		int leaveDays = Integer.parseInt(request.getParameter("leave_days"));
		
		List<Leave> leavesList = null;
		int lastLeaveId = 0;
		
		try {
			
			leavesList = leaveService.getAllLeave();
			lastLeaveId = leaveService.getTableLastLeaveId();
			
			leave.setLeaveType(leaveName);
			leave.setLeaveDays(leaveDays);
			if (leaveService.findLeaveByLeaveId(leaveId) == null) leaveService.createLeave(leave);
			else leaveService.updateLeave(leaveId, leave);
			response.sendRedirect(request.getContextPath() + "/leave");

		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			request.setAttribute("leavesList", leavesList);
            request.setAttribute("lastLeaveId", lastLeaveId);
			request.setAttribute("errorMessage", e.getMessage());
			request.setAttribute("leaveDays", leaveDays);
			request.setAttribute("leaveId", leaveId);
			request.getRequestDispatcher("/leave.jsp").forward(request, response);
		}

	}

}
