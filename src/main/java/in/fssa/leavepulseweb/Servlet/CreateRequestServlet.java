package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Request;
import in.fssa.leavepulse.service.LeaveService;
import in.fssa.leavepulse.service.RequestService;

/**
 * Servlet implementation class CreateRequestServlet
 */
@WebServlet("/request/create")
public class CreateRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestService requestService = new RequestService();
		Request requests = new Request();
		requests.setCreatedBy(Integer.parseInt(request.getParameter("employee_id")));
		requests.setManagerId(Integer.parseInt(request.getParameter("manager_id")));
		requests.setReason(request.getParameter("reason"));
		
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start_date = LocalDate.parse(startDate, inputFormatter);
        LocalDate end_date = LocalDate.parse(endDate, inputFormatter);
        
		requests.setStartDate(start_date);
		requests.setEndDate(end_date);
		
		PrintWriter out = response.getWriter();
		
		try {
			int leaveId = new LeaveService().findLeaveByLeaveName(request.getParameter("leave")).getLeaveId();
			requests.setLeaveId(leaveId);
			requestService.createRequest(requests);
			response.sendRedirect(request.getContextPath() + "/requests");
			
		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
			out.print(e.getMessage());
		}
		
	}

}