<%@ page import="dao.UserDAO"%>
<header>
	<div class="fixed-top d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm ">
		<h3 class="my-0 mr-md-auto font-weight-normal">Social</h3>
		<nav class="my-2 my-md-0 mr-md-3">
			<a class="p-2 text-dark" href="${pageContext.request.contextPath}/home">Home</a> <a class="p-2 text-dark"
				href="${pageContext.request.contextPath}/profile">Profile</a> <a class="p-2 text-dark"
				href="${pageContext.request.contextPath}/message">Message</a> 
		</nav>
		<div style="width: 110px; text-align: center;">
			<img style="border-radius: 100%; height: 60px; width: 60px;"
				src="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getImage() %>" />
		</div>
		<div>
			<div class="row">
				<p style="text-align: center; width: 100%; margin-bottom: 2px;"><%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getFirst_name() + " " + new UserDAO().getUserById((int) session.getAttribute("user_id")).getLast_name() %></p>
				<a style="width: 100%;" class="btn btn-outline-primary"
					href="${pageContext.request.contextPath}/logout">logout</a>
			</div>
		</div>

	</div>
</header>