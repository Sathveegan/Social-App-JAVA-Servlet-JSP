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
<title>Home | Social</title>
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
			<div class="row">
			<div class="col-md-4 col-sm-12">
				<div style="padding: 20px;">
					<form action="home" method="post">
					  <div class="form-group">
					    <label for="post" style="color: #ffffff">Create Post</label>
					    <textarea name="post" class="form-control" id="post" rows="3"></textarea>
					  </div>
					  <button type="submit" class="btn btn-primary">Post</button>
					</form>
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
								  		<img style="width: 100%; border-radius: 100%;" src="<%= new UserDAO().getUserById(posts.get(i).getUser_id()).getImage() %>" />
								  	</div>
								  	<div class="col-10">
									  	<h5 class="card-title">
									  		<%
									  			if(posts.get(i).getUser_id() == (int) session.getAttribute("user_id")){
									  				%><h5 class="card-title">me</h5><%
									  			} else{
									  				%>
									  				<h5 class="card-title"> <%= new UserDAO().getUserById(posts.get(i).getUser_id()).getFirst_name() %> </h5>
									  				<%
									  			}
									  				
									  		%>
									  	</h5>
									    <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(i).getBody() %></h6>
									    <p class="card-text"><%= posts.get(i).getPost_time() %></p>
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
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.ckeditor.com/4.11.4/standard/ckeditor.js"></script>
	<script>
            CKEDITOR.replace('post');
    </script>
</body>
</html>