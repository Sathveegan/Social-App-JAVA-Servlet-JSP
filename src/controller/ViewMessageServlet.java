package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MessageDAO;
import model.Message;

/**
 * Servlet implementation class ViewMessage
 */
@WebServlet("/ViewMessage")
public class ViewMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewMessageServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login");
			return;
		}
		
		MessageDAO messageDAO = new MessageDAO();
		if(request.getParameter("delete") != null) {
			try {
				messageDAO.deleteMessage(Integer.parseInt(request.getParameter("delete")));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int to_userID = -99;
		ArrayList<Message> messages = new ArrayList<>();
		try {
			to_userID = Integer.parseInt(request.getParameter("id"));
			messages = messageDAO.getMessage((int) session.getAttribute("user_id"), to_userID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("to_user", to_userID);
		request.setAttribute("messages", messages);
		request.getRequestDispatcher("WEB-INF/view-message.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login");
			return;
		}
		
		String message = request.getParameter("message");
		String to_user = request.getParameter("to_user");
		
		if (!message.trim().equals("") && !to_user.trim().equals("")) {
			try {
			MessageDAO messageDAO = new MessageDAO();
			messageDAO.insertMessage(Integer.parseInt(session.getAttribute("user_id").toString()), Integer.parseInt(to_user), message);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("view-message?id=" + to_user);
	}

}
