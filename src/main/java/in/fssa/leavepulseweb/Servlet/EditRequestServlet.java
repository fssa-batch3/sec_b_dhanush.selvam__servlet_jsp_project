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
import in.fssa.leavepulse.model.Request;
import in.fssa.leavepulse.service.RequestService;

/**
 * Servlet implementation class EditRequestServlet
 */
@WebServlet("/request/edit")
public class EditRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Request requests = new RequestService().findRequestByRequestId(Integer.parseInt(request.getParameter("id")));
			request.setAttribute("requests", requests);
			
			RequestDispatcher rd = request.getRequestDispatcher("/update_request.jsp");
			rd.forward(request, response);
			
		} catch (NumberFormatException | ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}

}
