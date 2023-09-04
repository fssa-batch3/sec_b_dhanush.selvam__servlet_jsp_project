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
import in.fssa.leavepulse.model.Request;
import in.fssa.leavepulse.service.RequestService;

/**
 * Servlet implementation class ListAllRequestServlet
 */
@WebServlet("/requests")
public class ListAllRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			List<Request> requestList = new RequestService().getAllRequest();
			request.setAttribute("requests", requestList);
			
			RequestDispatcher rd = request.getRequestDispatcher("/list_all_requests.jsp");
			rd.forward(request, response);
			
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
	}
	
}
