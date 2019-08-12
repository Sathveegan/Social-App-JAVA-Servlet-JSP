<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>login | Social</title>
<link rel="shortcut icon" href="image/logo.png">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache, no-store">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<style>
body {
	margin: 0;
	color: #6a6f8c;
	background: #919499;
	font: 600 16px/18px 'Open Sans', sans-serif;
}

*, :after, :before {
	box-sizing: border-box
}

.clearfix:after, .clearfix:before {
	content: '';
	display: table
}

.clearfix:after {
	clear: both;
	display: block
}

a {
	color: inherit;
	text-decoration: none
}

.login-wrap {
	width: 100%;
	margin: auto;
	max-width: 525px;
	margin-top: 5px;
	margin-bottom: 5px;
	min-height: 610px;
	position: relative;
	background:
		url(https://raw.githubusercontent.com/khadkamhn/day-01-login-form/master/img/bg.jpg)
		no-repeat center;
	box-shadow: 0 12px 15px 0 rgba(0, 0, 0, .24), 0 17px 50px 0
		rgba(0, 0, 0, .19);
}

.login-html {
	width: 100%;
	height: 100%;
	position: absolute;
	padding: 90px 70px 50px 70px;
	background: rgba(40, 57, 101, .9);
}

.login-html .sign-in-htm, .login-html .sign-up-htm {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	position: absolute;
	transform: rotateY(180deg);
	backface-visibility: hidden;
	transition: all .4s linear;
}

.login-html .sign-in, .login-html .sign-up, .login-form .group .check {
	display: none;
}

.login-html .tab, .login-form .group .label, .login-form .group .button
	{
	text-transform: uppercase;
	outline: none;
	cursor: pointer;
}

.login-html .tab {
	font-size: 22px;
	margin-right: 15px;
	padding-bottom: 5px;
	margin: 0 15px 10px 0;
	display: inline-block;
	border-bottom: 2px solid transparent;
}

.login-html .sign-in:checked+.tab, .login-html .sign-up:checked+.tab {
	color: #fff;
	border-color: #1161ee;
}

.login-form {
	min-height: 345px;
	position: relative;
	perspective: 1000px;
	transform-style: preserve-3d;
}

.login-form .group {
	margin-bottom: 15px;
}

.login-form .group .label, .login-form .group .input, .login-form .group .button
	{
	width: 100%;
	color: #fff;
	display: block;
	outline: none;
}

.login-form .group .input, .login-form .group .button {
	border: none;
	padding: 15px 20px;
	border-radius: 25px;
	background: rgba(255, 255, 255, .1);
}

.login-form .group input[data-type="password"] {
	text-security: circle;
	-webkit-text-security: circle;
}

.login-form .group .label {
	color: #aaa;
	font-size: 12px;
}

.login-form .group .button {
	background: #1161ee;
}

.login-form .group label .icon {
	width: 15px;
	height: 15px;
	border-radius: 2px;
	position: relative;
	display: inline-block;
	background: rgba(255, 255, 255, .1);
}

.login-form .group label .icon:before, .login-form .group label .icon:after
	{
	content: '';
	width: 10px;
	height: 2px;
	background: #fff;
	position: absolute;
	transition: all .2s ease-in-out 0s;
}

.login-form .group label .icon:before {
	left: 3px;
	width: 5px;
	bottom: 6px;
	transform: scale(0) rotate(0);
}

.login-form .group label .icon:after {
	top: 6px;
	right: 0;
	transform: scale(0) rotate(0);
}

.login-form .group .check:checked+label {
	color: #fff;
}

.login-form .group .check:checked+label .icon {
	background: #1161ee;
}

.login-form .group .check:checked+label .icon:before {
	transform: scale(1) rotate(45deg);
}

.login-form .group .check:checked+label .icon:after {
	transform: scale(1) rotate(-45deg);
}

.login-html .sign-in:checked+.tab+.sign-up+.tab+.login-form .sign-in-htm
	{
	transform: rotate(0);
}

.login-html .sign-up:checked+.tab+.login-form .sign-up-htm {
	transform: rotate(0);
}

.hr {
	height: 2px;
	margin: 60px 0 50px 0;
	background: rgba(255, 255, 255, .2);
}

.foot-lnk {
	text-align: center;
}
</style>
<title>Login</title>
</head>

<body>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" 
						<%
							if(request.getAttribute("page") != null){
								if(request.getAttribute("page").equals("login")){
									%>checked<%
								}
							} else{
								%>checked<%
							}
						%> ><label
				for="tab-1" class="tab">Sign In</label> <input id="tab-2"
				type="radio" name="tab" class="sign-up" <%
							if(request.getAttribute("page") != null){
								if(request.getAttribute("page").equals("register")){
									%>checked<%
								}
							}
						%>><label for="tab-2"
				class="tab">Sign Up</label>
			<div class="login-form">
				<div class="sign-in-htm">
					<form method="post" action="${pageContext.request.contextPath}/login">
						<div class="group">
							<label for="user" class="label">Email</label> <input id="email"
								name="email" type="text" class="input">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input
								type="password" id="password" name="password" class="input"
								data-type="password">
						</div>
						<div class="group">
							<input id="check" type="checkbox" class="check" checked>
							<label for="check"><span class="icon"></span> Keep me
								Signed in</label>
						</div>
						<div class="group">
							<input type="submit" class="button" value="Sign In">
						</div>
						<%
							if(request.getAttribute("msg") != null){
								%>
								<p><%=request.getAttribute("msg")%><p>
								<%
							}
						%>
						<div class="hr"></div>
						
					</form>
				</div>
				<div class="sign-up-htm">
					<form method="post" action="${pageContext.request.contextPath}/register">
						<div class="group">
							<label for="user" class="label">First Name <%
								if(request.getAttribute("fmsg") != null){
									%>
									<span style="float:right;"><%=request.getAttribute("fmsg")%></span>
									<%
								}
							%></label>
							<input id="first_name" name="first_name" type="text" class="input">
							
						</div>
						<div class="group">
							<label for="user" class="label">Last Name<%
								if(request.getAttribute("lmsg") != null){
									%>
									<span style="float:right;"><%=request.getAttribute("lmsg")%></span>
									<%
								}
							%>
							</label> 
							<input id="last_name" name="last_name" type="text" class="input">
							
						</div>
						<div class="group">
							<label for="pass" class="label">Email
							<%
							if(request.getAttribute("emsg") != null){
									%>
									<span style="float:right;"><%=request.getAttribute("emsg")%></span>
									<%
								}
							%></label> 
							<input id="email" name="email" type="text" class="input">

						</div>
						<div class="group">
							<label for="pass" class="label">Password
							<%
								if(request.getAttribute("pmsg") != null){
									%>
									<span style="float:right;"><%=request.getAttribute("pmsg")%></span>
									<%
								}
							%></label> 
							<input id="password" name="password" type="password" class="input" data-type="password">
							
						</div>
						<div class="group">
							<label for="pass" class="label">Confirm Password
							<%
								if(request.getAttribute("cpmsg") != null){
									%>
									<span style="float:right;"><%=request.getAttribute("cpmsg")%></span>
									<%
								}
							%>
							</label> 
							<input id="cpassword" name="cpassword" type="password" class="input" data-type="password">
														
						</div>
						<div class="group">
							<input type="submit" class="button" value="Sign Up">
						</div>
							<%
								if(request.getAttribute("rmsg") != null){
									%>
									<p><%=request.getAttribute("rmsg")%><p>
									<%
								}
							%>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>