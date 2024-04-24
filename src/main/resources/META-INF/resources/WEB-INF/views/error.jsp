<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Error</title>
<style>
       /* Style for container */
       .container {
           text-align: center;
           margin-top: 20%;
       }
       /* Style for button */
       .button {
           background-color: #007bff; /* Blue color */
           border: none;
           color: white;
           padding: 15px 32px;
           text-align: center;
           text-decoration: none;
           display: inline-block;
           font-size: 16px;
           margin: 4px 2px;
           cursor: pointer;
           border-radius: 8px;
       }
</style>
</head>
<body>

<div class="container">

<%
	
    String status=(String)request.getAttribute("errorMessage");
	Integer statuscode = (Integer)request.getAttribute("error");
	if(status != null){
%>
	<h2><%=status %></h2>
	<h3>Sorry For Innconvience</h3>
<%
	}
	else if(statuscode == 500){
		
%>
	<h1><%=statuscode %></h1>
	<h2>Some Internal Server Error Occurred </h2>
	<p>Please contact support for assistance.</p>

<%
	}
else{	
%>

<h1>OOPS !</h1>
<h1><%=statuscode %></h1>
<h2>PAGE NOT FOUND</h2>
<p>Please Check the URL</p>
<%
}
%>
<!-- Button to go to home page -->
<button class="button" onclick="window.location.href = '../login';">Go to Home Page</button>
</div>
</body>
</html>
