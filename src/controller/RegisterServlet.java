package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user_id") != null) {
			response.sendRedirect("home");
		} else {
			request.setAttribute("page", "register");
			request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String first_name = request.getParameter("first_name").trim();
		String last_name = request.getParameter("last_name").trim();
		String email = request.getParameter("email").trim();
		String password = request.getParameter("password").trim();
		String cpassword = request.getParameter("cpassword").trim();
		
		boolean status = true;
		request.removeAttribute("fmsg");
		request.removeAttribute("lmsg");
		request.removeAttribute("emsg");
		request.removeAttribute("pmsg");
		request.removeAttribute("cpmsg");
		request.removeAttribute("rmsg");
		
		if (first_name.equals("")) {
			request.setAttribute("fmsg", "First name is required ");
			status = false;
		}
		if(last_name.equals("")) {
			request.setAttribute("lmsg", "Last name is required ");
			status = false;
		}
		if(email.equals("")) {
			request.setAttribute("emsg", "Email is required ");
			status = false;
		}
		if(password.equals("")) {
			request.setAttribute("pmsg", "Password is required ");
			status = false;
		}
		if(cpassword.equals("")) {
			request.setAttribute("cpmsg", "Password is required ");
			status = false;
		} else if(!password.equals(cpassword)) {
			request.setAttribute("cpmsg", "Password is not matched ");
			status = false;
			
		}
		
		if(!status) {
			request.setAttribute("page", "register");
			request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
		} else {
			UserDAO userDAO = new UserDAO();
			User user = new User();
			user.setPassword(password);
			user.setFirst_name(first_name);
			user.setEmail(email);
			user.setLast_name(last_name);
			String result = userDAO.register(user);
			request.setAttribute("rmsg", result);
			request.setAttribute("page", "register");
			request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);

		}
		
		
	}

}
