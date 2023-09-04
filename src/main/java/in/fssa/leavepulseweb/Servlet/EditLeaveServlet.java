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
import in.fssa.leavepulse.model.Leave;
import in.fssa.leavepulse.service.LeaveService;

/**
 * Servlet implementation class EditLeaveServlet
 */
@WebServlet("/leave/edit")
public class EditLeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			Leave leave = new LeaveService().findLeaveByLeaveId(Integer.parseInt(request.getParameter("id")));
			request.setAttribute("leaves", leave);
			
			RequestDispatcher rd = request.getRequestDispatcher("/update_leave.jsp");
			rd.forward(request, response);
			
		} catch (NumberFormatException | ServiceException | ValidationException e) {
			e.printStackTrace();
		}
		
	}

}
