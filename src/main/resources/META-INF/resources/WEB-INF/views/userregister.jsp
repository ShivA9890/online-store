<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Register</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body style="background-image:url('resources/images/adminbackgroundregister.jpg');">
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
						<h3 class="text-center my-3">Register User</h3>
						<form action="userregister" method="post">

							<div class="form-group">
								<label for="name">First Name</label> <input type="text"
									class="form-control" id="firstname"
									aria-describedby="emailHelp" name="firstname"
									placeholder="Enter first name.." required>
							</div>

							<div class="form-group">
								<label for="name">Last Name</label> <input type="text"
									class="form-control" id="lastname" aria-describedby="emailHelp"
									name="lastname" placeholder="Enter last name.." required>
							</div>

							<div class="form-group">
								<label for="email">Email</label> <input type="email"
									class="form-control" id="emailid" aria-describedby="emailHelp"
									name="emailid" placeholder="Enter email id.." required>
									<span id="emailMessage" style="color: red"></span>
									<span id="emailMessage1" style="color: red"></span>
							</div>


							<div class="form-group">
								<label for="email">Mobile</label> <input type="number"
									class="form-control" id="mobileno" aria-describedby="emailHelp"
									name="mobileno" placeholder="Enter mobile no.." required>
									<span id="mobileMessage" style="color: red"></span>
							</div>


							<div class="form-group">
								<label for="name">City</label> <input type="text"
									class="form-control" id="city" aria-describedby="emailHelp"
									name="city" placeholder="Enter city.." required>
							</div>

							<div class="form-group">
								<label for="email">Pin code</label> <input type="number"
									class="form-control" id="pincode" aria-describedby="emailHelp"
									name="pincode" placeholder="Enter pincode.." required>
							</div>


							<div class="form-group">
								<label for="password">Password</label> <input type="password"
									class="form-control" id="password" aria-describedby="emailHelp"
									name="password" placeholder="Enter password.." required>
								<small id="passwordHelpInline" class="text-muted"> Must
									contain [A-Z,a-z,0-9 and @#*] in password and length must be minimum 8 </small><br>
									<span id="passwordMessagered" style="color: red" ></span>
									<span id="passwordMessagegreen" style="color: green" ></span>
							</div>

							<div class="container text-center">
								<button class="btn custom-bg text-color">
									<b>Register</b>
								</button>
							</div>
							<hr>
							<div>
								<a href="userlogin"><h6 class="text-center my-4">login
										back</h6></a>
							</div>

						</form>
					</div>
				</div>


			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#emailid').on('blur', function() {
				var email = $(this).val();
				$.ajax({
					url : '/validateuseremail',
					type : 'POST',
					data : email,
					contentType : 'text/plain',
					success : function(response) {
						$('#emailMessage').text('');
						if (response === "Exists") {
							$('#emailMessage').text('Email already exists');
							$('#emailid').val('');
						} else {
							$('#emailMessage').text('');
						}
					}
				});
			});
		});
		
		$(document).ready(function() {
			$('#mobileno').on('blur', function() {
				var email = $(this).val();
				$.ajax({
					url : '/validatemobile',
					type : 'POST',
					data : email,
					contentType : 'text/plain',
					success : function(response) {
						$('#mobileMessage').text('');
						if (response === "notvalid") {
							$('#mobileMessage').text('Number is invalid');
							$('#mobileno').val('');
						} else {
							$('#mobileMessage').text('');
						}
					}
				});
			});
		});
		
		$(document).ready(function() {
			$('#emailid').on('blur', function() {
				var email = $(this).val();
				$.ajax({
					url : '/validateemail',
					type : 'POST',
					data : email,
					contentType : 'text/plain',
					success : function(response) {
						$('#emailMessage1').text('');
						if (response === "notcorrect") {
							$('#emailMessage1').text('Invalid Email Format');
							$('#emailid').val('');
						} else {
							$('#emailMessage1').text('');
						}
					}
				});
			});
		});
		
		$(document).ready(function() {
			$('#password').on('blur', function() {
				var email = $(this).val();
				$.ajax({
					url : '/validatepassword',
					type : 'POST',
					data : email,
					contentType : 'text/plain',
					success : function(response) {
						$('#passwordMessage1').text('');
						$('#passwordMessage2').text('');
						if (response === "weak") {
							$('#passwordMessagered').text('Not Strong Password');
							$('#password').val('');
						} else {
							$('#passwordMessagegreen').text('Strong Password');
						}
					}
				});
			});
		});
	</script>
</body>
</html>