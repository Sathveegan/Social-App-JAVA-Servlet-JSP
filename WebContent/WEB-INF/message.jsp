<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.User"%>
<%@ page import="model.Message"%>
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
<title>Message | Social</title>
<link rel="shortcut icon" href="image/logo.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<style>
	.container {
	    margin-top: 120px;
	}
	
	@media (max-width:800px){
		.container {
	    	margin-top: 240px !important;
		}
	}
	
	#newMessageBtn {
		display: block;
		position: fixed;
		bottom: 20px;
		right: 30px;
		z-index: 99;
		font-size: 18px;
		border: none;
		outline: none;
		background-color: #1fa3f4;
		color: white;
		cursor: pointer;
		padding: 15px;
		border-radius: 100%;
		width: 60px;
    	height: 60px;
	}
	
	#newMessageBtn:hover {
		background-color: #0373b7;
	}
</style>
</head>
<body class="bg-dark">

	<%@include file="header.jsp" %>

	<main role="main">

		<div class="container">
		
		<%
			ArrayList<Message> messages = (ArrayList<Message>) request.getAttribute("messages");
			
			if(messages.size() == 0){
				%><h4 style="text-align: center; color: #ffffff;">No Messages.</h4><%
			}
			
			for(int i=0; i<messages.size(); i++){
				if(messages.get(i).getFrom_user().equals(session.getAttribute("user_id").toString())){
					%>
						<div class="card mb-3">
						  <div class="card-body">
						  	<div class="row">
						  		<div class="col-2">
							  		<img style="width: 100%; border-radius: 100%;" src="<%= new UserDAO().getUserById(Integer.parseInt(messages.get(i).getTo_user())).getImage() %>" />
							  	</div>
							  	<div class="col-10" style="cursor: pointer;" onclick="window.location.href='view-message?id=<%= messages.get(i).getTo_user() %>'">
								  	<h5 class="card-title"><%= new UserDAO().getUserById(Integer.parseInt(messages.get(i).getTo_user())).getFirst_name() %></h5>
								    <h6 class="card-subtitle mb-2 text-muted"><%= messages.get(i).getMessage() %></h6>
								    <p class="card-text"><%= messages.get(i).getChat_time() %></p>
							  	</div>
							 </div>
							 <div class="row">
								<div class="col-12">
						  			<a href="${pageContext.request.contextPath}/message?delete=<%=messages.get(i).getTo_user() %>" class="card-link" style="float: right;"><i style="font-size: 25px;color:red;" class="far fa-trash-alt"></i></a>
						  		</div>							  
						  	 </div>
							</div>
						</div>
					<%
				} else {
					%>
					<div class="card mb-3">
					  <div class="card-body">
					  	<div class="row">
					  		<div class="col-2">
						  		<img style="width: 100%; border-radius: 100%;" src="<%= new UserDAO().getUserById(Integer.parseInt(messages.get(i).getFrom_user())).getImage() %>" />
						  	</div>
						  	<div class="col-10" style="cursor: pointer;" onclick="window.location.href='view-message?id=<%= messages.get(i).getTo_user() %>'">
							  	<h5 class="card-title"><%= new UserDAO().getUserById(Integer.parseInt(messages.get(i).getFrom_user())).getFirst_name() %></h5>
							    <h6 class="card-subtitle mb-2 text-muted"><%= messages.get(i).getMessage() %></h6>
							    <p class="card-text"><%= messages.get(i).getChat_time() %></p>
						  	</div>
						</div>
						<div class="row">
							<div class="col-12">
						  		<a href="${pageContext.request.contextPath}/message?delete=<%=messages.get(i).getFrom_user() %>" class="card-link" style="float: right;"><i style="font-size: 25px;color:red;" class="far fa-trash-alt"></i></a>
						  	</div>
						</div>
						</div>
					</div>
					<%
				}
			}
		%>
		
		</div>
		
		<button id="newMessageBtn" data-toggle="modal" data-target="#newChatModal">
			<i class="fas fa-plus"></i>
		</button>
		
		<!-- Modal -->
		<div class="modal fade" id="newChatModal" tabindex="-1" role="dialog"
			aria-labelledby="chatModalTitle" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="chatModalTitle">Friends List</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body"
						style="overflow-y: scroll; max-height: 350px;">
						<%
							ArrayList<User> newUsers = (ArrayList<User>) request.getAttribute("newUsers");
	
							for (int i = 0; i < newUsers.size(); i++) {
							%>
		
							<div style="cursor: pointer;  margin: 5px;" class="card"
								onclick="javascript:window.location='view-message?id=<%=newUsers.get(i).getUser_id()%>';">
								<div class="card-body">
									<%=newUsers.get(i).getFirst_name() + " " + newUsers.get(i).getLast_name()%>
									<i style="float: right;" class="fas fa-paper-plane"></i>
								</div>
							</div>
		
							<%
							}
						%>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		
	</main>
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>