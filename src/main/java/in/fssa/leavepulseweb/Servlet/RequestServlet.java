package in.fssa.leavepulseweb.Servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.fssa.leavepulse.dto.LeaveBalanceDTO;
import in.fssa.leavepulse.dto.RequestDTO;
import in.fssa.leavepulse.exception.ServiceException;
import in.fssa.leavepulse.exception.ValidationException;
import in.fssa.leavepulse.model.Leave;
import in.fssa.leavepulse.model.Request;
import in.fssa.leavepulse.model.Request.LeaveStatus;
import in.fssa.leavepulse.service.EmployeeRoleService;
import in.fssa.leavepulse.service.LeaveBalanceService;
import in.fssa.leavepulse.service.LeaveService;
import in.fssa.leavepulse.service.RequestService;

/**
 * Servlet implementation class RequestServlet
 */
@WebServlet("/request")
public class RequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		RequestService requestService = new RequestService();
		List<RequestDTO> requestList = null;
		List<Leave> leaveList = null;
		List<LeaveBalanceDTO> availableLeaves = null;

		try {

			// Create Request Page

			if ("new".equals(action)) {
				
				int employeeId = (int) request.getSession().getAttribute("LOGGEDUSER");
				leaveList = new LeaveService().getAllLeave();
				availableLeaves = new LeaveBalanceService().findAllLeaveBalanceByEmployeeId(employeeId);
				request.setAttribute("leaveList", leaveList);
				request.setAttribute("availableLeaves", availableLeaves);

				RequestDispatcher rd = request.getRequestDispatcher("/create_request.jsp");
				rd.forward(request, response);

			}

			else if ("allrequests".equals(action)) {

				requestList = requestService.getAllRequestWithEmployee();
				request.setAttribute("requests", requestList);

				RequestDispatcher rd = request.getRequestDispatcher("/list_all_requests.jsp");
				rd.forward(request, response);

			}

			else if ("employeerequests".equals(action)) {

				int employeeId = (int) request.getSession().getAttribute("LOGGEDUSER");
				requestList = requestService.getAllRequestWithEmployeeByEmployeeId(employeeId);
				request.setAttribute("requests", requestList);

				RequestDispatcher rd = request.getRequestDispatcher("/list_all_requests.jsp");
				rd.forward(request, response);

			} 
			
			else if("cancel".equals(action)) {
								
				int id = Integer.parseInt(request.getParameter("id"));
				int employeeId = (Integer) request.getSession().getAttribute("LOGGEDUSER");
				int leaveId = Integer.parseInt(request.getParameter("leaveId"));
				int days = Integer.parseInt(request.getParameter("days"));
				String status = request.getParameter("status");
				
				requestService.cancelRequest(id);
				if (!status.equals("Rejected"))
					new LeaveBalanceService().updateLeaveBalance("cancel", employeeId, leaveId, days);
				response.sendRedirect(request.getContextPath() + "/request?action=employeerequests");
				
			}

			else {

				int employeeId = (int) request.getSession().getAttribute("LOGGEDUSER");
				requestList = requestService.getAllRequestWithEmployeeByManagerId(employeeId);
				request.setAttribute("requests", requestList);

				RequestDispatcher rd = request.getRequestDispatcher("/list_all_requests.jsp");
				rd.forward(request, response);

			}

		} catch (ServiceException | ValidationException e) {
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		RequestService requestService = new RequestService();
		Request requests = new Request();

		int loggedUserId = (int) request.getSession().getAttribute("LOGGEDUSER");
		
		// Update Request

		if ("updaterequest".equals(action)) {

			int id = Integer.parseInt(request.getParameter("request_id"));
			String leaveOldStatusString = request.getParameter("old_status");
			String leaveStatusString = request.getParameter("status");
			LeaveStatus leaveStatus = LeaveStatus.Pending;
			
			int employeeId = Integer.parseInt(request.getParameter("employee_id"));
			int leaveId = Integer.parseInt(request.getParameter("leave_id"));
			int days = Integer.parseInt(request.getParameter("days"));
							
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
			requests.setModifiedBy(loggedUserId);
			
			try {

				requestService.updateRequest(id, requests);
				
				if (leaveStatusString.equals("Rejected") && leaveOldStatusString.equals("Accepted") 
						|| leaveStatusString.equals("Rejected") && leaveOldStatusString.equals("Pending"))
					new LeaveBalanceService().updateLeaveBalance("cancel", employeeId, leaveId, days);
				
				if (leaveStatusString.equals("Accepted") && leaveOldStatusString.equals("Rejected"))
					new LeaveBalanceService().updateLeaveBalance("update", employeeId, leaveId, days);
				
				if (leaveStatusString.equals("Pending") && leaveOldStatusString.equals("Rejected"))
					new LeaveBalanceService().updateLeaveBalance("update", employeeId, leaveId, days);
				
				response.sendRedirect(request.getContextPath() + "/request");
				
			} catch (ServiceException | ValidationException e) {
				e.printStackTrace();
			}

		}
		
		// Create Request

		else {
			
			List<Leave> leaveList = null;
			List<LeaveBalanceDTO> availableLeaves = null;
			String leave = null;

			try {
				
//				String isLossOfPay = request.getParameter("isLossOfPay");
				requests.setCreatedBy(loggedUserId);
				leave = request.getParameter("leave");
				
				DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				LocalDate startDate = LocalDate.parse(request.getParameter("start_date"), inputFormatter);
				LocalDate endDate = LocalDate.parse(request.getParameter("end_date"), inputFormatter);

				requests.setStartDate(startDate);
				requests.setEndDate(endDate);
				requests.setReason(request.getParameter("reason"));
				
				leaveList = new LeaveService().getAllLeave();
				availableLeaves = new LeaveBalanceService().findAllLeaveBalanceByEmployeeId(loggedUserId);
				
				int managerId = new EmployeeRoleService().findEmpRoleByEmployeeId(loggedUserId).getManagerId();
				int leaveId = new LeaveService().findLeaveByLeaveName(leave).getLeaveId();
	
				requests.setManagerId(managerId);
				requests.setLeaveId(leaveId);
				
				requestService.createRequest(requests);
	
//				if(isLossOfPay.equals("no")) requestService.createRequest(requests);
//				else requestService.createRequestWithLossOfPay(requests);
					
				response.sendRedirect(request.getContextPath() + "/request?action=employeerequests");
				
			} catch (ServiceException | ValidationException e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", e.getMessage());
				request.setAttribute("leaveList", leaveList);
				request.setAttribute("availableLeaves", availableLeaves);
				request.setAttribute("requestsData", requests);
				request.setAttribute("leave", leave);
				request.getRequestDispatcher("/create_request.jsp").forward(request, response);
				
			}

		}

	}

}
