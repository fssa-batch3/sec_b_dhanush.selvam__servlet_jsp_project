package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.dto.RequestDTO;
import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.service.RequestService;

/**
 * Servlet implementation class LeaveHistoryServlet
 */
@WebServlet("/leaveHistory")
public class LeaveHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<RequestDTO> requestList = new ArrayList<>();

		try {

			int loggedUserId = (int) request.getSession().getAttribute("LOGGEDUSER");
			requestList = new RequestService().getAllRequestWithEmployeeByEmployeeId(loggedUserId);
		
			request.setAttribute("requests", requestList);

			RequestDispatcher rd = request.getRequestDispatcher("/employee_requests.jsp");
			rd.forward(request, response);

		} catch (ServiceException e) {
			e.printStackTrace();
		}

	}

}
