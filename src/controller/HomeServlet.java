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

import dao.PostDAO;
import model.Post;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
        // TODO Auto-generated constructor stub
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
		
		PostDAO postDAO = new PostDAO();
		ArrayList<Post> posts = new ArrayList<>();
		try {
			posts = postDAO.getAllPost();
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("posts", posts);
		
		request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
		
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
		
		String post = request.getParameter("post").trim();
		
		if(!post.equals("")) {
			try {
				PostDAO postDAO = new PostDAO();
				postDAO.insertPost((int) session.getAttribute("user_id"), post);
				response.sendRedirect("home");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
	}

}
