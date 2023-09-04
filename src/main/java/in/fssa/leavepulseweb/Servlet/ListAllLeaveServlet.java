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
import in.fssa.leavepulse.model.Leave;
import in.fssa.leavepulse.service.LeaveService;

/**
 * Servlet implementation class ListAllLeaveServlet
 */
@WebServlet("/leaves")
public class ListAllLeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			List<Leave> leaveList = new LeaveService().getAllLeave();
			request.setAttribute("leavesList", leaveList);
			
			RequestDispatcher rd = request.getRequestDispatcher("/list_all_leaves.jsp");
			rd.forward(request, response);
			
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
	}

}