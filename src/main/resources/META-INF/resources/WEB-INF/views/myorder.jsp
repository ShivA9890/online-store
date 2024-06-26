<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.Date"%>
<%@ page import ="java.util.*"%>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@ page import ="java.text.DateFormat"%>
<%@ page import ="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Orders</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body style="background-color:#f5fefd;">
<%@ include file="./components/navbar.jsp"%>
<div class="container-fluid">
  <div class="row mt-4">
       <form class="form-inline ml-5" action="searchorderbyid">
          <div class="form-group">
            <label for="inputPassword2" class="text-color"><h4>Search By Order Id</h4></label>
            <input type="text" class="form-control ml-3" id="inputPassword2" name="orderid" placeholder="Enter Order Id..">
          </div>
          <button type="submit" class="btn text-color custom-bg ml-2">Search</button>
       </form>
 
       <a href="searchorderbydate?orderdate=<%=LocalDate.now()%>&userid=<%=user.getId()%>" class="ml-2"><button class="btn text-color custom-bg ml-2">Get Todays Order</button></a>
  </div>
  <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-color">
    <tr>
      <th scope="col">Order Id</th>
      <th scope="col">User Id</th>
      <th scope="col">User Name</th>
      <th scope="col">User Email</th>
      <th scope="col">User Phone</th>
      <th scope="col">Product Image</th>
      <th scope="col">Product Title</th>
      <th scope="col">Product Brand</th>    
      <th scope="col">Qty</th>
      <th scope="col">Price</th>
      <th scope="col">Order date</th>
      <th scope="col">Delivery date</th>
      <th scope="col">Delivery Status</th>
    </tr>
  </thead>
  
   <%
      List<Orders> listOfOrders = new ArrayList<>();
   
      listOfOrders = (List<Orders>)request.getAttribute("orders");
       
      if(listOfOrders != null ) {
          for(Orders o : listOfOrders) {
                 
           	  
           	  Optional<Product> of = productDao.findById(o.getProductId());
                 Product p = null;
                 
                 if(of.isPresent()) {
               	  p = of.get();
                 }
           	  
                 Optional<Users> ou = userDao.findById(o.getUserId());
                 Users u = null;
                 
                 if(of.isPresent()) {
               	  u = ou.get();
                 }
           	  
      %>
  <tbody>
    <tr class="text-center">
      <td class="mid-align"><%=o.getOrderId() %></td>
      <td class="mid-align"><%=u.getId() %></td>
      <td class="mid-align"><%=u.getFirstname() %></td>
      <td class="mid-align"><%=u.getEmailid() %></td>
      <td class="mid-align"><%=u.getMobileno() %></td>
      <td><img style="max-height:100px;max-width:70px;width:auto;" class="img-fluid mx-auto d-block" src="resources/productpic/<%=p.getImagePath() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p.getName() %></td>
      <td class="mid-align"><%=p.getBrand() %></td>
      <td class="mid-align"><%=o.getQuantity() %></td>
      <td class="mid-align"><%= (new Helper().getProductSellingPrice(p.getPrice(), p.getDiscount())) * o.getQuantity() %></td>
      <td class="mid-align"><%=o.getOrderDate() %></td>
      <td class="mid-align"><%=o.getDeliveryDate() %></td>
      <td class="mid-align"><%=o.getDeliveryStatus() %></td>
    </tr>
  </tbody>
    <%
          }
      }
    %>
</table>
   </div>
</div>

</body>
</html>