<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Lottery Ticket</title>
</head>
<script>
function update(name, price, desc)
{
	if (parseInt(price))
	window.location="addprod.jsp?name="+name+"&price="+price+"&desc="+desc;
   	else
	alert("Invalid entry. Price must be a number.")
}

</script>
<body>
<form name=newLotto method=get 
action=>
<%
String name = request.getParameter("name");
String price = request.getParameter("price");
String desc = request.getParameter("desc");
if (name!=null &&!name.equals("")){
double pr = Double.parseDouble(price);
getConnection();
String sql="INSERT INTO product (productName,productPrice,productDesc) VALUES (?,?,?)";
PreparedStatement pst = con.prepareStatement(sql);
pst.setString(1,name);
pst.setDouble(2,pr);
pst.setString(3,desc);
pst.executeUpdate();
out.println("<h1 align=center> Successfully added new lotto ticket!<h1>");
closeConnection();
}
%>
<h3>Ticket Name</h3>
<input type="text" maxlength="40" name="name" size="50">

<h3>Ticket Price</h3>
<input type="text" maxlength="8" name="price" size="50">

<h3>Ticket Description</h3>
<input type="text" maxlength="1000" name="description" size="50">

<input type="button" onclick=update(newLotto.name.value,newLotto.price.value,newLotto.description.value) value="Add Product">
</form>
</body>
</html>