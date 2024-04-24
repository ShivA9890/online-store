<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Login</title>
<%@ include file="./components/common_cs_js.jsp"%>
<style>
body{
	 background-image:url('resources/images/backgroundlogin.jpg');
	
}
</style>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4 admin">
				<div class="card">
					<%@ include file="./components/message.jsp"%>
					<div class="card-body px-5">
						<img src="resources/images/userlogo.png"
							class="rounded mx-auto d-block" alt="img" height="90px"
							width="90px">
						<h3 class="text-center my-3">User Login</h3>
						<form action="userlogin" method="post">
							<div class="form-group">
								<label for="email">User name</label> <input type="text"
									class="form-control" id="username" aria-describedby="emailHelp"
									name="emailid" placeholder="Enter email id.." required>
							</div>

							<div class="form-group">
								<label for="password">Password</label> <input type="password"
									class="form-control" id="password" aria-describedby="emailHelp"
									name="password" placeholder="Enter password.." required>
								<small id="passwordHelpInline" class="text-muted"> Must
									be 8-20 characters long. </small>
							</div>

							<div class="container text-center">
								<button class="btn custom-bg text-color">
									<b>Login</b>
								</button>
							
							</div>		
							<hr>
							<div>
								<a href="userregister"><h6 class="text-center my-4">don't
										have Account</h6></a>
							 <a href="#" data-toggle="modal" data-target=".forgetpasswordmodal">
        <h6 class="text-center my-4">Forget Password</h6>
    </a>										<a href="login"><h6 class="text-center my-4">Back</h6></a>
										
							</div>
						</form>
					</div>
				</div>


			</div>
		</div>
	</div>
	

</body>
</html>