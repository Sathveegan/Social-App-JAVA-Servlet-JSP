<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Post"%>
<%@ page import="dao.UserDAO"%>
<%
	if (session == null || session.getAttribute("user_id") == null) {
		response.sendRedirect("login");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Profile | Social</title>
<link rel="shortcut icon" href="image/logo.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<style type="text/css">
	.my-container {
	    margin-top: 120px;
	}
	
	@media (max-width:800px){
		.my-container {
	    	margin-top: 240px !important;
		}
	}
</style>
</head>
<body class="bg-dark">

	<%@include file="header.jsp" %>

	<main role="main">
		<div class="my-container">
		
			<%
				if(request.getAttribute("pmsg") != null){
					%>
					<div style="margin-left: 5px; margin-right: 5px;" class="alert alert-info" role="alert">
					  <%=request.getAttribute("pmsg")%>
					  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					    <span aria-hidden="true">&times;</span>
					  </button>
					</div>
					<%
				}
			%>
		
			<div class="row">
			<div class="col-md-4 col-sm-12">
				<div class="card" style="margin: 20px;">
				  <img src="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getImage() %>" style="width: 100%;" class="card-img-top">
				  <div class="card-body">
				    <h5 class="card-title">My Profile</h5>
				    <hr>
				    <p class="card-text">First Name: <%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getFirst_name() %></p>
				    <p class="card-text">Last Name: <%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getLast_name() %></p>
				    <p class="card-text">Email: <%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getEmail() %></p>
				    <a href="profile?deactivate=<%= session.getAttribute("user_id") %>" style="float: right; margin-left: 10px;" class="btn btn-danger">Deactivate</a>
				    <a data-toggle="modal" data-target="#profileUpdate" style="float: right; cursor: pointer; color: #ffffff" class="btn btn-primary">Update</a>
				  </div>
				</div>
			</div>
			<div class="col-md-8 col-sm-12">
				<div style="padding: 20px;">
				
					<%
						ArrayList<Post> posts = (ArrayList<Post>) request.getAttribute("posts");
						
						if(posts.size() == 0){
							%><h4 style="text-align: center; color: #ffffff;">No Posts.</h4><%
						}
						
						for(int i=0; i<posts.size(); i++){
							%>
							
							<div class="card mb-3">
							  <div class="card-body">
							  	<div class="row">
							  		<div class="col-2">
								  		<img style="width: 100%; border-radius: 100%;" src="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getImage() %>" />
								  	</div>
								  	<div class="col-10">
									  	<h5 class="card-title">
									  		<h5 class="card-title">me</h5>
									  	</h5>
									    <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(i).getBody() %></h6>
									    <p class="card-text"><%= posts.get(i).getPost_time() %></p>
								  	</div>
								 </div>
								 <div class="row">
									<div class="col-12">
										<a href="${pageContext.request.contextPath}/profile?post-delete=<%= posts.get(i).getPost_id() %>" class="card-link" style="float: right; padding-left: 10px;"><i style="font-size: 25px;color:red;" class="far fa-trash-alt"></i></a>
							  			<a href="${pageContext.request.contextPath}/profile?post-update=<%= posts.get(i).getPost_id() %>" class="card-link" style="float: right;"><i style="font-size: 25px;" class="far fa-edit"></i></a>
							  		</div>							  
							  	 </div>
								</div>
							</div>
					
							<%
						}
					%>

				</div>
			</div>
			</div>
		</div>
	</main>
	
	<!-- Modal -->
	<div class="modal fade bd-example-modal-lg" id="profileUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalCenterTitle">Edit Profile</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row">
	      		<div class="col-md-6">
	      			<h4 style="margin-top: 10px;">Change Profile</h4>
	      			<form method="post" action="profile">
	      			  <input type="hidden" name="type" value="change_profile">
					  <div class="form-group">
					    <label for="first_name">First name</label>
					    <input type="text" class="form-control" name="first_name" id="first_name" required value="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getFirst_name() %>">
					  </div>
					  <div class="form-group">
					    <label for="last_name">Last name</label>
					    <input type="text" class="form-control" id="last_name" name="last_name" required value="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getLast_name() %>">
					  </div>
					  <div class="form-group">
					    <label for="email">Email</label>
					    <input type="email" class="form-control" id="email" name="email" required value="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getEmail() %>">
					  </div>
					  <button type="submit" style="float: right;" class="btn btn-primary">Update Profile</button>
					</form>
	      		</div>
	      		<div class="col-md-6">
	      			<h4 style="margin-top: 10px;">Change Password</h4>
					<form method="post" action="profile">
					  <input type="hidden" name="type" value="change_password">
					  <div class="form-group">
					    <label for="password">Password</label>
					    <input type="password" class="form-control" id="password" name="password" required placeholder="Type your new password">
					  </div>
					  <div class="form-group">
					    <label for="cpassword">Confirm Password</label>
					    <input type="password" class="form-control" id="cpassword" name="cpassword" required placeholder="Type your confirm password">
					  </div>
					  <button type="submit" style="float: right;" class="btn btn-primary">Update Password</button>
					</form>
	      		</div>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.ckeditor.com/4.11.4/standard/ckeditor.js"></script>
	<script>
            CKEDITOR.replace('post');       
    </script>
</body>
</html>