<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page- Online Electronics Ordering</title>
<%@ include file="./components/common_cs_js.jsp"%>
<style>
body{
	 background-image:url('resources/images/adminbackground.png');
	
}
.button{
	  margin-top:20px;
	  padding:10px 20px;
	  background-color:#3498db;
	  border-radius: 5px;
	  cursor: pointer;
	  border: none;
	  color: #fff;
}

.button-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 20; 
}

</style>
</head>
<body>
<%String userType1 = (String) session.getAttribute("user-login");
if (userType1 != null && userType1.equals("admin")){
	
%>
	<%@ include file="./components/navbar.jsp"%>
	
	<%
	List<Category> li = new ArrayList<>();
	li = categoryDao.findAll();
	List<Users> listOfAllUsers = new ArrayList<>();
	listOfAllUsers = userDao.findAll();
	%>
	
	<div class="container admin mt-2">
		<%@ include file="./components/message.jsp"%>
		<div class="row mt-4">
			<div class="col-md-4">
				<div class="card hover" data-toggle="modal"
					data-target="#show-users-modal" style="background-color: #f0f0f0; border-radius: 50%;">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 80px" class="img-fluid rounded-circle"
								src="resources/images/user.png" alt="users_pic">
						</div>
						<h1><%=userDao.count()%></h1>
						<h2 style="color: #B8860B;" ><i>Users</i></h2>
					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card hover" data-toggle="modal"
					data-target="#show-category-modal" style="background-color: #f0f0f0; border-radius: 50%;">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 80px" class="img-fluid rounded-circle"
								src="resources/images/category.jpg" alt="users_pic">
						</div>
						<h1><%=categoryDao.count()%></h1>
						<h2 style="color: #B8860B"><i>Total Category</i></h2>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card hover" data-toggle="modal"
					data-target="#show-product-modal" style="background-color: #f0f0f0; border-radius: 50%;">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 80px" class="img-fluid rounded-circle"
								src="resources/images/productlogo.jpg" alt="users_pic">
						</div>
						<h1><%=productDao.count()%></h1>
						<h2 style="color: #B8860B"><i>Total Products</i></h2>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col-md-4">
				<div class="card hover" data-toggle="modal"
					data-target="#total-order-modal" style="background-color: #f0f0f0; border-radius: 50%;">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 80px" class="img-fluid rounded-circle"
								src="resources/images/orderslogo.jpg" alt="users_pic">
						</div>
						<h1 class="text-lowercase text-muted"><%=orderDao.countNotExists("Delivered") %></h1>
						<h2 style="color: #B8860B"><i>Total Orders</i></h2>
					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card hover" data-toggle="modal"
					data-target="#add-category-modal" style="background-color: #f0f0f0; border-radius: 50%;">
					<div class="card-body text-center">
						<div class="container md-5">
							<img style="max-width: 95px" class="img-fluid rounded-circle"
								src="resources/images/addcategory.jpg" alt="users_pic">
						</div>
						<p style="color: orange" style="font-size: 22px">click
							to add category</p>
						<h2 style="color: #B8860B"><i>Add Category</i></h2>
					</div>
				</div>
			</div>
			
				<div class="col-md-4">
				<div class="card hover" data-toggle="modal"
					data-target="#add-product-modal" style="background-color: #f0f0f0; border-radius: 50%;">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 95px" class="img-fluid rounded-circle"
								src="resources/images/addproduct.png" alt="users_pic">
						</div>
						<p style="color: orange" style="font-size: 22px">click
							to add New Product</p>
						<h2 style="color: #B8860B"><i>Add Product</i></h2>
					</div>
				</div>
			</div>

		</div>

	</div>
	<div class="button-container">
			 <button class="button " onclick="window.location.href = 'login';">Back</button>
		
	</div>		
			
			<!-- show users modal -->

	<div class="modal fade" id="show-users-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white text-center">
					<h5 class="modal-title text-color" id="exampleModalLongTitle">Total
						Users</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="table-responsive">
						<table class="table">
							<thead class="custom-bg text-white">
								<tr class="text-color">
									<th scope="col">User Id</th>
									<th scope="col">First Name</th>
									<th scope="col">Last Name</th>
									<th scope="col">Email Id</th>
									<th scope="col">Mobile</th>
									<th scope="col">Address</th>
								</tr>
							</thead>
							<tbody>

								<%
								for (Users u : listOfAllUsers) {
								%>
								<tr>
									<th scope="row" class="mid-align"><%=u.getId()%></th>
									<td class="mid-align"><%=u.getFirstname()%></td>
									<td class="mid-align"><%=u.getLastname()%></td>
									<td class="mid-align"><%=u.getEmailid()%></td>
									<td class="mid-align"><%=u.getMobileno()%></td>
									<td class="mid-align"><%=u.getCity() + " " + u.getPincode()%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- end of show users modal -->
	
		<!-- add category modal -->

	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title text-color" id="exampleModalLongTitle">Fill
						category details.</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="addcategory" method="post">
						<div class="form-group">
							<input type="text" class="form-control" name="name"
								placeholder="Enter Category Title here" required>
						</div>

						<div class="form-group">
							<textarea style="height: 250px" class="form-control"
								name="description" placeholder="Enter Category Description here"
								required></textarea>
						</div>

						<div class="container text-center">
							<button class="btn custom-bg text-color">Add Category</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- end add category modal -->
	
	<!-- show category modal -->

	<div class="modal fade" id="show-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white text-center">
					<h5 class="modal-title text-color" id="exampleModalLongTitle">Total
						Category</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="table-responsive">
						<table class="table">
							<thead class="custom-bg text-white">
								<tr class="text-color">
									<th scope="col">Category Id</th>
									<th scope="col">Category Name</th>
									<th scope="col">Category Description</th>
									<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>

								<%
								for (Category c : categoryDao.findAll()) {
								%>
								<tr>
									<td class="mid-align"><%=c.getId()%></td>
									<td class="mid-align"><%=c.getName()%></td>
									<td class="mid-align"><%=c.getDescription()%></td>
									<td class="mid-align"><a
										href="deletecategory?categoryId=<%=c.getId()%>"><input
											type="submit" class="btn btn-danger" value="Delete"></a></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ********************* -->

	<!-- show Product modal -->
	
		<!-- add product modal -->

	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title text-color" id="exampleModalLongTitle">Add Product
						details.</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="addproduct" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<input type="text" class="form-control" name="name"
								placeholder="Enter Product Title here" required>
						</div>
						
						<div class="form-group">
							<input type="text" class="form-control" name="brand"
								placeholder="Enter Product Brand here" required>
						</div>

						<div class="form-group">
							<textarea style="height: 150px" class="form-control"
								name="description" placeholder="Enter Product Description here"
								required></textarea>
						</div>

						<div class="form-group">
							<input type="number" class="form-control" name="price"
								placeholder="Enter Product Price here" required>
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="discount"
								placeholder="Enter Product Discount in (%)" required>
						</div>

						<div class="form-group">
							<select name="categoryId" class="form-control">
								<option value="">Select Category</option>
								<%
								for (Category category : li) {
								%>
								<option value="<%=category.getId()%>"><%=category.getName()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="form-group">
							<label>Select Product Picture</label><br> <input type="file"
								class="form-control" name="image" required>
						</div>

						<div class="container text-center">
							<button class="btn custom-bg text-color">Add Product</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- end add product modal -->
	<!-- total order modal -->

	<div class="modal fade bd-example-modal-lg" id="total-order-modal"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-size" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white text-center">
					<h5 class="modal-title text-color" id="exampleModalLongTitle">TOTAL
						ORDERS</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">

					<%
					List<Orders> lor = orderDao.findAll();
					if (lor == null) {
					%>
					<div class="text-center">
						<h1>NO ORDERS MADE BY ANYONE !!</h1>
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
								<tr class="text-center text-color">
									<th scope="col">Order Id</th>
									<th scope="col">User Id</th>
									<th scope="col">User Name</th>
									<th scope="col">User Email</th>
									<th scope="col">User Phone</th>
									<th scope="col">Product Image</th>
									<th scope="col">Product Title</th>
									<th scope="col">Qty</th>
									<th scope="col">Price</th>
									<th scope="col">Order date</th>
									<th scope="col">Delivery date</th>
									<th scope="col">Delivery Status</th>
									<th scope="col">Action</th>
								</tr>
							</thead>



							<tbody>

								<%
								for (Orders o : lor) {

									Optional<Product> of = productDao.findById(o.getProductId());
									Product p = null;

									if (of.isPresent()) {
										p = of.get();
									}

									Optional<Users> ou = userDao.findById(o.getUserId());
									Users u = null;

									if (of.isPresent()) {
										u = ou.get();
									}
									if(!o.getDeliveryStatus().equalsIgnoreCase("delivered")){
								%>
								<tr class="text-center">
									<td class="mid-align"><%=o.getOrderId()%></td>
									<td class="mid-align"><%=u.getId()%></td>
									<td class="mid-align"><%=u.getFirstname()%></td>
									<td class="mid-align"><%=u.getEmailid()%></td>
									<td class="mid-align"><%=u.getMobileno()%></td>
									<td><img
										style="max-height: 100px; max-width: 70px; width: auto;"
										class="img-fluid mx-auto d-block"
										src="resources/productpic/<%=p.getImagePath()%>"
										alt="users_pic"></td>
									<td class="mid-align"><%=p.getName()%></td>
									<td class="mid-align"><%=o.getQuantity()%></td>
									<td class="mid-align"><%=(new Helper().getProductSellingPrice(p.getPrice(), p.getDiscount())) * o.getQuantity()%></td>
									<td class="mid-align"><%=o.getOrderDate()%></td>
									<td class="mid-align"><%=o.getDeliveryDate()%></td>
									<td class="mid-align"><%=o.getDeliveryStatus()%></td>
									<td class="mid-align">
										<form action="updatedeliverydate">

											<input type="hidden" name="orderId" value=<%=o.getOrderId()%>>

											<div class="form-group mx-sm-3 mb-2">
												<input type="date" class="form-control" name="deliveryDate"
													placeholder="Delivery Date" size="85" required>
											</div>
											<div class="form-group mx-sm-3 mb-2">
												<select name="deliverystatus" class="form-control">
													<option value="Pending">Pending</option>
													<option value="Delivered">Delivered</option>
													<option value="On the Way">On the Way</option>
												</select>
											</div>
											<button type="submit" class="btn custom-bg text-white mb-2">Set</button>
										</form>
									</td>
								</tr>
								<%
								}
								}
								%>
							</tbody>


						</table>
					</div>
					<hr>

					<div class="text-center">
						<button type="button" class="btn btn-secondary ml-5"
							data-dismiss="modal">Close</button>
					</div>
					<%
					}
					%>

				</div>
			</div>
		</div>
	</div>

	<!--  -->
	<!-- show Product modal -->

	<div class="modal fade" id="show-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white text-center">
					<h5 class="modal-title text-color" id="exampleModalLongTitle">Total Product</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="table-responsive">
						<table class="table">
							<thead class="custom-bg text-white">
								<tr class="text-color">
									<th scope="col">Product Name</th>
									<th scope="col">Product Image</th>
									<th scope="col">Product Brand</th>
									<th scope="col">Product Description</th>
									<th scope="col">Product Category</th>
									<th scope="col">Product Price</th>
									<th scope="col">Product Discount</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<Product> lp = productDao.findAll();
								%>

								<%
								for (Product p : lp) {
								%>
								<tr>
									<td class="mid-align"><%=p.getName()%></td>
									<td class="mid-align"><img style="max-width: 70px"
										class="img-fluid"
										src="resources/productpic/<%=p.getImagePath()%>"
										alt="users_pic"></td>
									<td class="mid-align"><%=p.getBrand()%></td>
									<td class="mid-align"><%=p.getDescription()%></td>

									<%
									Category cat = null;
									Optional<Category> optional = categoryDao.findById(p.getCategoryId());
									if (optional.isPresent()) {
										cat = optional.get();
									}
									%>

									<td class="mid-align"><%=cat.getName()%></td>
									<td class="mid-align"><%=p.getPrice()%></td>
									<td class="mid-align"><%=p.getDiscount()%></td>

								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ********************* -->

	<!-- total order modal -->
	<%
}
else{
	 response.sendRedirect("adminlogin");
}
	%>		
</body>
</html>