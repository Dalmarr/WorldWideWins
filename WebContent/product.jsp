<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>World Wide Wins - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body> 

<form name = leaveReview>

<script>
function getReview(review)
{
	window.location="addreview.jsp?review="+review+"&productId="+productId;
   	
}

</script>
<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

getConnection();
String sql = "SELECT  productName, productId, productPrice, productImageURL, productImage, productDesc FROM Product WHERE productId = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1,productId);
ResultSet rst= pstmt.executeQuery();
rst.next();

out.println("<h2>"+rst.getString(1)+"</h2>");
// TODO: If there is a productImageURL, display using IMG tag
		
if (rst.getString(4)!=null){
out.println(" <img src=\""+rst.getString(4)+"\" width=\"300\" height=\"300\"'>");} 
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
if (rst.getString(5)!=null){
out.println(" <img src=\"displayImage.jsp?id="+productId+"\">");}
// TODO: Add links to Add to Cart and Continue Shopping
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

out.println("<p> <b>Product ID: </b>"+productId);
out.println("<p> <b>Price: </b>"+currFormat.format(rst.getBigDecimal(3)));
out.println("<p> <b>Jackpot: </b>"+rst.getString(6));
out.println("<h3><a href=\"addcart.jsp?id="+productId+"&amp;name="+rst.getString(1)+"&amp;price="+rst.getBigDecimal(3)+"\">Add to Cart</h3>");

closeConnection();
%>
<h3><a href="listprod.jsp">Continue Shopping</a></h3>

<input type = "text" size=100 maxlength = 1000 name = "review" >
<p></p>
<input type="button" onclick=update(getReview.review.value) value="Submit Review">

</form>
</body>
</html>

