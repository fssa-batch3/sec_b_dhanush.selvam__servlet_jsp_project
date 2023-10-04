package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.dto.LeaveBalanceDTO;
import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.service.LeaveBalanceService;

/**
 * Servlet implementation class LeaveBalanceServlet
 */
@WebServlet("/leavebalance")
public class LeaveBalanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int employeeid = (int) request.getSession().getAttribute("LOGGEDUSER");
		List<LeaveBalanceDTO> availableLeaves = null;
		
		try {
			
			availableLeaves = new LeaveBalanceService().findAllLeaveBalanceByEmployeeId(employeeid);
			request.setAttribute("availableLeaves", availableLeaves);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/available_leaves.jsp");
			dispatcher.forward(request, response);
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}

}
