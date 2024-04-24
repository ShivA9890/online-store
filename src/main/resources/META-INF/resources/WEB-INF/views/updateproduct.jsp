<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Product</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body style="background-color:#fffefc">
<%@ include file="./components/navbar.jsp"%>
<%
   Product product = (Product)request.getAttribute("product"); 
%>
<div class="container-fluid">
  <div class="row mt-2">
       <div class="col-md-4 offset-md-4 admin" >
            <div class="card">
                <%@ include file="./components/message.jsp"%>
                <div class="card-body px-5">
                    <h3 class="text-center my-3">Update Product</h3>
            <form action="updateproduct" method="post" enctype="multipart/form-data">
            <div class="form-group">
            <label>Product Id</label>
							<input type="text" class="form-control" name="id"
								placeholder="Enter Product Id" value="<%=product.getId() %>" readonly required>
						</div>
						<div class="form-group">
						<label>Product Title</label>
							<input type="text" class="form-control" name="name"
								placeholder="Enter Product Title here" value="<%=product.getName() %>" required>
						</div>
						
						<label>Product Brand</label>
							<input type="text" class="form-control" name="brand"
								placeholder="Enter Product Title here" value="<%=product.getBrand() %>" required>
						</div>

						<div class="form-group">
						<label>Product Description</label>
							<textarea style="height: 150px" class="form-control"
								name="description" placeholder="Enter Product Description here"
								required><%=product.getDescription() %></textarea>
						</div>

						<div class="form-group">
						<label>Product Price</label>
							<input type="number" class="form-control" name="price" value="<%=product.getPrice()%>"
								placeholder="Enter Product Price here" required>
						</div>

						<div class="form-group">
						<label>Product Discount</label>
							<input type="text" class="form-control" name="discount" value="<%=product.getDiscount() %>"
								placeholder="Enter Product Discount in (%)" required>
						</div>

						<div class="form-group">
							<select name="categoryId" class="form-control">
								<option value="">Select Category</option>
								<%
								for (Category category : categoryDao.findAll()) {
								%>
								<option value="<%=category.getId()%>"><%=category.getName()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="form-group">
							<label>Select Product Pic</label><br> <input type="file"
								class="form-control" name="image" value="<%=product.getImagePath() %>">
						</div>

						<div class="container text-center">
							<button class="btn custom-bg text-white">Update Product</button>
						<a href="./login">	<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button></a>
						</div>
					</form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>