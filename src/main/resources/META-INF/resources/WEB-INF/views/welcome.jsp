<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Welcome to the Store</title>
<style>
body{
	 background-image:url('resources/images/background.png');
	
}
h1{
	text-align:center;
	font-weight:bold;
	height:50px;
	color:white;
	background
	
	}
	
.paragraph{

	margin-top: 20px;
	color:white;
	
}

.button:hover{
	background-color: #2980b9;
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

.container{

text-align: center;
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%,-50%)


}
</style>

</head>

<body>
<div class="container">
    <h1 style="color: yellow"><b><i><strong>WELCOME TO THE STORE</strong></i></b></h1>
    <p class="paragraph"  >Welcome to <b>S-Store World</b>, your ultimate online destination for all things electronics!<br>

At S-Store, we're passionate about technology and dedicated to bringing you the latest and greatest electronic devices from around the globe. Our extensive range of products includes everything from smartphones, laptops, and tablets to gaming consoles, televisions, and home appliances.
We understand that in the rapidly evolving world of technology, staying up-to-date can be challenging. That's why our team of tech enthusiasts works tirelessly to curate a selection of products that not only meets but exceeds our customer's expectations. We strive to provide detailed product information, honest reviews, and a seamless shopping experience to help you make informed decisions.
<br>
But we're more than just a store. We're a community of tech lovers who share a passion for the latest gadgets and innovations. We regularly update our blog with news, reviews, and tips to help you stay ahead of the curve.
So, whether you're a tech guru looking for the latest gadget, a student in need of a new laptop, or a gamer waiting for the next big thing, we've got you covered.
<br>
Join us on our journey as we continue to bring the future of technology to your doorstep. Welcome to ShivamElectronicsWorld, where quality meets innovation.</p>
    <button class="button" onclick="window.location.href = 'login';">Get Started</button>
</div>

</body>
</html>