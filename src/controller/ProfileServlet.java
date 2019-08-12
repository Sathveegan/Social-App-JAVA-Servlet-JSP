package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostDAO;
import dao.UserDAO;
import model.Post;
import model.User;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
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
		
		if(request.getParameter("post-delete") != null) {
			try {
				postDAO.deletePost(Integer.parseInt(request.getParameter("post-delete")));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(request.getParameter("post-update") != null) {
			request.setAttribute("post_id", Integer.parseInt(request.getParameter("post-update")));
			request.getRequestDispatcher("WEB-INF/post-update.jsp").forward(request, response);
			return;
		}
		
		if(request.getParameter("deactivate") != null) {
			UserDAO userDAO = new UserDAO();
			try {
				userDAO.deleteUser(Integer.parseInt(request.getParameter("deactivate")));
				response.sendRedirect("logout");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		ArrayList<Post> posts = new ArrayList<>();
		try {
			posts = postDAO.getUserPost((int) session.getAttribute("user_id"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("posts", posts);
		
		request.getRequestDispatcher("WEB-INF/profile.jsp").forward(request, response);
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
		
		String type = request.getParameter("type");
		
		if(type.equals("change_profile")) {
			String first_name = request.getParameter("first_name").trim();
			String last_name = request.getParameter("last_name").trim();
			String email = request.getParameter("email").trim();
			
			if(first_name.equals("") || last_name.equals("") || email.equals("")) {
				request.setAttribute("pmsg", "Type all required fields.");
				doGet(request, response);
			} else {
				UserDAO userDAO = new UserDAO();
				User user = new User();
				user.setUser_id((int) session.getAttribute("user_id"));
				user.setFirst_name(first_name);
				user.setEmail(email);
				user.setLast_name(last_name);
				String result = userDAO.updateProfile(user);
				request.setAttribute("pmsg", result);
				doGet(request, response);
			}
		} else if(type.equals("change_password")) {
			String password = request.getParameter("password").trim();
			String cpassword = request.getParameter("cpassword").trim();
			
			if(password.equals("") || cpassword.equals("")) {
				request.setAttribute("pmsg", "Type all required fields.");
				doGet(request, response);
			} else if(!password.equals(cpassword)) {
				request.setAttribute("pmsg", "New Password and Confirm Password are not match.");
				doGet(request, response);
			}
			else {
				UserDAO userDAO = new UserDAO();
				User user = new User();
				user.setUser_id((int) session.getAttribute("user_id"));
				user.setPassword(password);
				String result = userDAO.updatePassword(user);
				request.setAttribute("pmsg", result);
				doGet(request, response);
			}
		} else if(type.equals("update_post")) {
			String post = request.getParameter("post").trim();
			String post_id = request.getParameter("post_id");
			PostDAO postDAO = new PostDAO();
			
			if(post.equals("")) {
				request.setAttribute("pmsg", "Post message is required.");
				doGet(request, response);
			} else {
				try {
					if(postDAO.getPost(Integer.parseInt(post_id)).getUser_id() != Integer.parseInt(session.getAttribute("user_id").toString())) {
						request.setAttribute("pmsg", "Access denied.");
						doGet(request, response);
					}
					else {
						Post p = new Post();
						p.setPost_id(Integer.parseInt(post_id));
						p.setBody(post);
						String result = postDAO.updatePost(p);
						request.setAttribute("pmsg", result);
						doGet(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("pmsg", "Post Update Failed");
					doGet(request, response);
				}
			}
		}
	}

}
