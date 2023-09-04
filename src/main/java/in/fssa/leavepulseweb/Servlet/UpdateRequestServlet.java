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
import in.fssa.leavepulse.model.Request;
import in.fssa.leavepulse.model.Request.LeaveStatus;
import in.fssa.leavepulse.service.RequestService;

/**
 * Servlet implementation class UpdateRequestServlet
 */
@WebServlet("/request/update")
public class UpdateRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		RequestService requestService = new RequestService();
		Request requests = new Request();
		
		String leaveStatusString = request.getParameter("leave_status");
		LeaveStatus leaveStatus = LeaveStatus.Pending;

		switch (leaveStatusString) {
		    case "Accepted":
		        leaveStatus = LeaveStatus.Accepted;
		        break;
		    case "Rejected":
		        leaveStatus = LeaveStatus.Rejected;
		        break;
		}
		
		requests.setLeaveStatus(leaveStatus);
		requests.setComments(request.getParameter("comments"));
		requests.setModifiedBy(Integer.parseInt(request.getParameter("manager_id")));
		
		PrintWriter out = response.getWriter();
		
		
		try {
			requestService.updateRequest(id, requests);
			response.sendRedirect(request.getContextPath() + "/requests");

		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.print(e.getMessage());
		}
	}

}
