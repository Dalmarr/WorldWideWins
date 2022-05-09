<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>

<title>Your Shopping Cart</title>
</head>
<script>
function update(newid, newqty)
{
	if (parseInt(newqty))
	window.location="showcart.jsp?update="+newid+"&newQty="+newqty;
    else
	alert("Invalid entry. Can only update with integers.")
}
</script>
<body>
<form name="form1">

<%
String del = request.getParameter("delete");
String newQ = request.getParameter("newQty");
String update = request.getParameter("update");
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	//delete
	if (del!=null && (!del.equals(""))){
		if(productList.containsKey(del)) {
			productList.remove(del);
		}
	}
	
	
	
	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	int boxnum=0;
	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	boxnum++;
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		else{
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		
		//update
		//if (productList.containsKey(update))
		//{	//product = (ArrayList<Object>) productList.get(update);
		if (update!=null && (!update.equals(""))){
			if (product.get(0).equals(update)){
				product.set(3,newQ);
			}
		}
		//}
		out.print("<td align=\"center\"><input type=\"text\" name=\"newqty"+boxnum+"\" size=\"3\" value="+ product.get(3) +"></td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.println("<td align=\"right\"><a href=\"showcart.jsp?delete="+product.get(0)+"\">Remove Item from Cart</td>");
		out.println("<td align=\"right\">&nbsp;&nbsp;&nbsp;&nbsp;"
		+ "<input type=\"button\" onclick=\"update("+product.get(0)+", form1.newqty"+boxnum+".value)\" value=\"Update Quantity\"></td></tr>");
		total = total +pr*qty;}
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</form>
</body>
</html> 

