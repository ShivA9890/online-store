<%@ page import="com.project.gadget.onlinegadgetstore.model.*"%>
<%@ page import="com.project.gadget.onlinegadgetstore.utility.*"%>
<%@ page import="com.project.gadget.onlinegadgetstore.dao.*"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<%
String userType = (String) session.getAttribute("user-login");
Admin admin = null;
Users user = null;
if (userType != null && userType.equals("admin")) {
	admin = (Admin) session.getAttribute("active-user");
}

else if (userType != null && userType.equals("user")) {
	user = (Users) session.getAttribute("active-user");
}

ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
CategoryDao categoryDao = context.getBean(CategoryDao.class);
CartDao cartDao = context.getBean(CartDao.class);
ProductDao productDao = context.getBean(ProductDao.class);
UsersDao userDao = context.getBean(UsersDao.class);
OrdersDao orderDao = context.getBean(OrdersDao.class);
%>

<nav class="navbar navbar-expand-lg navbar-dark custom-bg">

	<div class="container-fluid">
		<img src="/resources/images/mainlogo.png" width="35" height="35"
			class="d-inline-block align-top" alt=""> <a
			class="navbar-brand" href="login"><h3 class="text-color">
				<i>S-STORE</i>
			</h3></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">


				<%
				if (userType != null && userType.equals("admin")) {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="admindashboard"><b class="text-color">Admin Page</b> <span
						class="sr-only">(current)</span></a></li>
				<%
				}
				%>
				<li class="nav-item active dropdown text-color"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <b class="text-color"> Categories</b>
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="category?categoryId=0">All</a>
						<%
						for (Category c : categoryDao.findAll()) {
						%>
						<a class="dropdown-item" href="category?categoryId=<%=c.getId()%>"><%=c.getName()%></a>
						<%
						}
						%>

					</div></li>

				<li class="nav-item active text-color ml-1" data-toggle="modal"
					data-target=".aboutusmodal">
					<div class="nav-link">
						<b class="text-color">About us</b>
					</div>
				</li>

				<li class="nav-item active text-color ml-1" data-toggle="modal"
					data-target=".contactusmodal">
					<div class="nav-link">
						<b class="text-color">Contact us</b>
					</div>
				</li>

			</ul>

			<form class="form-inline my-1 my-lg-0" action="searchproduct">
				<input class="form-control mr-sm-3" type="text"
					placeholder="Search Product" aria-label="Search" size="30"
					name="productname">
				<button type="submit" class="btn btn-light text-color">
					<b>Search</b>
				</button>
			</form>


			<%
			if (userType != null) {
			%>
			<ul class="navbar-nav ml-auto">

				<%
				if (userType.equals("user")) {
				%>
				<li class="nav-item active" data-toggle="modal"
					data-target="#showmycartmodal">
					<div class="nav-link text-color">
						<img src="resources/images/cart.png" style="width: 23px;"
							alt="img">
					</div>
				</li>

				<li class="nav-item active text-color"><a class="nav-link"
					href="myorder"><b class="text-color">My Orders</b></a></li>


				<li class="nav-item active">
					<div class="nav-link" data-toggle="modal"
						data-target=".forgetpasswordmodal">
						<b class="text-color">Forget password</b>
					</div>
				</li>

				<%
				}
				%>


				<li class="nav-item active text-color" data-toggle="modal"
					data-target=".logout-modal"><a class="nav-link" href="#"><b
						class="text-color">Logout</b></a></li>


			</ul>
			<%
			}

			else {
			%>

			<ul class="navbar-nav ml-auto text-color">
				<li class="nav-item active text-color"><a class="nav-link"
					href="adminlogin"><b class="text-color">Admin Login</b></a></li>

				<li class="nav-item text-color active"><a class="nav-link"
					href="userlogin"><b class="text-color">User Login</b></a></li>
			</ul>

			<%
			}
			%>

		</div>
	</div>
</nav>

<!-- show my cart modal -->

<div class="modal fade" id="showmycartmodal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header custom-bg text-white text-center">
				<h5 class="modal-title" id="exampleModalLongTitle">MY CART</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<%
			if (user != null) {
				List<Cart> l = cartDao.findByUserId(user.getId());
			%>
			<div class="modal-body">

				<%
				if (l.isEmpty()) {
				%>
				<div class="text-center">
					<h1>CART IS EMPTY!!</h1>
					<hr>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
				<%
				}

				else {
				%>
				<div class="table-responsive">
					<table class="table">
						<thead class="custom-bg text-white">
							<tr>
								<th scope="col">Product Image</th>
								<th scope="col">Product Title</th>
								<th scope="col">Product Brand</th>
								<th scope="col">Product Description</th>
								<th scope="col">Quantity</th>
								<th scope="col">Price</th>
								<th scope="col">Date</th>
								<th scope="col">Action</th>
							</tr>
						</thead>



						<tbody>

							<%
							double totalCartPrice = 0;
							List<Integer> listOfProductId = new ArrayList<>();

							for (Cart c : l) {
								int productId = c.getProductId();
								Optional<Product> optional = productDao.findById(productId);
								Product f = null;
								if (optional.isPresent()) {
									f = optional.get();
								}

								double productPrice = Helper.getProductSellingPrice(f.getPrice(), f.getDiscount());
								double cartPrice = productPrice * c.getQuantity();

								totalCartPrice = totalCartPrice + cartPrice;
								totalCartPrice = totalCartPrice + 100;

								listOfProductId.add(f.getId());
							%>
							<tr class="text-center">
								<td><img
									style="max-height: 100px; max-width: 70px; width: auto;"
									class="img-fluid mx-auto d-block"
									src="resources/productpic/<%=f.getImagePath()%>"
									alt="users_pic"></td>
								<td class="mid-align"><%=f.getName()%></td>
								<td class="mid-align"><%=f.getBrand()%></td>
								<td class="mid-align"><%=f.getDescription()%></td>
								<td class="mid-align"><%=c.getQuantity()%></td>
								<td class="mid-align"><%=Helper.getProductSellingPrice(f.getPrice(), f.getDiscount())%></td>
								<td class="mid-align"><%=c.getDate()%></td>
								<td class="mid-align"><a
									href="deletecart?cartId=<%=c.getId()%>"><button
											type="button" class="btn btn-danger">Remove</button></a></td>
							</tr>
							<%
							}
							%>
						</tbody>


					</table>
				</div>
				<hr>

				<div class="text-right">
					<p style="font-size: 25px;">
						<b>Total Price :&#8377;<%=totalCartPrice%>/-
						</b>
					</p>
				</div>
				<hr>
				<div class="row">
					<form action="checkout" method="post">
						<input type="hidden" name="amount" value="<%=totalCartPrice%>">
						<input type="submit" class="btn custom-bg text-light ml-5"
							value="Checkout">
					</form>
					<button type="button" class="btn btn-secondary ml-5"
						data-dismiss="modal">Close</button>
				</div>

				<%
				}
				%>

			</div>
			<%
			}
			%>
		</div>
	</div>
</div>

<!--  -->

<!-- Logout modal -->

<div class="modal fade logout-modal" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header custom-bg text-white text-center">
				<h5 class="modal-title" id="exampleModalLongTitle">Log Out</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body text-center">
				<h5>Do you want to logout?</h5>

				<div class="text-center">
					<a href="logout"><button type="button"
							class="btn custom-bg text-white">Yes</button></a>
					<button type="button" class="btn btn-secondary ml-5"
						data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- *********** -->

<!-- About us modal -->

<div class="modal fade aboutusmodal" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header custom-bg text-white text-center">
				<h5 class="modal-title text-color" id="exampleModalLongTitle">About
					Us</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<p style="font-size: 20px;">
						<b> SM Store is your premier destination for the latest and
							most advanced electronic devices. Founded in 2024, we have
							quickly established ourselves as a trusted source for
							high-quality electronics. <br> <br> Our mission is to
							make cutting-edge technology accessible to everyone. We believe
							that the right device can enhance your life, whether it's a
							smartphone that keeps you connected with your loved ones, a
							laptop that helps you work efficiently, or a gaming console that
							provides entertainment. <br> We offer a wide range of
							products, from the latest smartphones and tablets to laptops,
							gaming consoles, and home appliances. Our selection includes
							products from leading brands known for their innovation and
							quality. We are committed to providing our customers with
							products that offer the best value for their money. <br> At
							ElectroHub, we understand that shopping for electronics can be
							overwhelming due to the multitude of options available. That's
							why our team of experts carefully curates our product selection
							to include only the best and most reliable devices. We strive to
							provide detailed product information and honest reviews to help
							you make informed decisions. <br> Customer satisfaction is
							at the heart of everything we do. We pride ourselves on our
							exceptional customer service. Our friendly and knowledgeable
							staff is always ready to assist you, whether you need help
							choosing a product or require technical support. <br> We are
							more than just a store. We are a community of tech enthusiasts
							who share a passion for the latest gadgets and innovations. We
							regularly update our blog with news, reviews, and tips to help
							you stay up-to-date with the rapidly evolving world of
							technology. Join us on our journey as we continue to bring the
							future of technology to your doorstep. Welcome to ElectroHub,
							where quality meets innovation.

						</b>
					</p>
				</div>
			</div>
			<div class="modal-footer">
				<div class="text-center">
					<button type="button" class="btn custom-bg text-color"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ********** -->

<!-- Contact us modal -->

<div class="modal fade contactusmodal" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header custom-bg text-white text-center">
				<h5 class="modal-title text-color" id="exampleModalLongTitle">Contact
					Us</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container text-center">
					<p style="font-size: 23px;">
						<b>
							<h6>Shivam Muluk</h6> <img src="resources/images/phonee.png"
							style="width: 27px;" alt="img">+91 9890195196 / +91
							9767196197<br> <img src="resources/images/emaill.png"
							style="width: 29px;" alt="img">shivamsmulik@gmail.com
						</b>
					</p>
				</div>
			</div>
			<div class="modal-footer">
				<div class="text-center">
					<button type="button" class="btn custom-bg text-color"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ********** -->

<!-- forget password modal -->

<div class="modal fade forgetpasswordmodal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header custom-bg text-white text-center">
				<h5 class="modal-title" id="exampleModalLongTitle">Forget
					Password</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="forgetpassword" method="post">

					<div class="form-group ">
						<label for="inputPassword4">Email</label> <input type="email"
							class="form-control" id="email" name="emailid">
					</div>
					<div class="form-group ">
						<label for="inputPassword4">Phone</label> <input type="text"
							class="form-control" id="phone" name="mobileno">
					</div>
					<div class="form-group">
						<label for="inputPassword4">New Password</label> <input
							type="password" class="form-control" id="pass" name="pass">
						<small id="passwordHelpInline" class="text-muted"> Must
							contain [A-Z,a-z,0-9 and @#*] in password and length must be
							minimum 8 </small><br> <span id="passwordMessage1"
							style="color: red"></span> <span id="passwordMessage2"
							style="color: green"></span>
					</div>
					<script
						src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
					<script>
						$(document)
								.ready(
										function() {
											$('#pass')
													.on(
															'blur',
															function() {
																var email = $(
																		this)
																		.val();
																$
																		.ajax({
																			url : '/validatepassword',
																			type : 'POST',
																			data : email,
																			contentType : 'text/plain',
																			success : function(
																					response) {
																				$(
																						'#passwordMessage1')
																						.text(
																								'');
																				$(
																						'#passwordMessage2')
																						.text(
																								'');
																				if (response === "weak") {
																					$(
																							'#passwordMessage1')
																							.text(
																									'Not Strong Password');
																					$(
																							'#pass')
																							.val(
																									'');
																				} else {
																					$(
																							'#passwordMessage2')
																							.text(
																									'Strong Password');
																				}
																			}
																		});
															});
										});
					</script>


					<div class="container text-center">

						<input type="submit" class="btn custom-bg text-light"
							value="Change">
						<button type="button" class="btn custom-bg text-light ml-5"
							data-dismiss="modal">Close</button>

					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<!--  -->