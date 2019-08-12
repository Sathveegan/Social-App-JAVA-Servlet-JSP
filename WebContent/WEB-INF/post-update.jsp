<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Post"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="dao.PostDAO"%>
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
	    margin-left: 10px;
	    margin-right: 10px;
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
				<div class="col-md-12">
					<form action="profile" method="post">
					  <input type="hidden" name="type" value="update_post">
					  <input type="hidden" name="post_id" value="<%= request.getParameter("post-update") %>">
					  <div class="form-group">
					    <label for="post" style="color: #ffffff">Update Post</label>
					    <textarea name="post" class="form-control" id="post" rows="4">
					    	<%= new PostDAO().getPost(Integer.parseInt(request.getParameter("post-update"))).getBody() %>
					    </textarea>
					  </div>
					  <button type="submit" class="btn btn-primary">Update Post</button>
					</form>
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