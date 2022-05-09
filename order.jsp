<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Cool COSC Grocery Order Processing</title>
</head>
<body>

<% 
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
// Get customer id
String custId = request.getParameter("customerId");
String custPass = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
Boolean validated=false;
// Determine if valid customer id was entered

if (custId == null ||(custId.length()==0) || custPass == null ||(custPass.length()==0)){
		out.println("<H1>Invalid customer id or password. Go back to the previous page and try again.</H1>");
}

// Determine if there are products in the shopping cart

else if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
}
else{
// If either are not true, display an error message

// Make connection
		String uid = "ysalyani";
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ysalyani"; 		
		String pw = "32514151";
		Connection con=null;
		try{
		con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery("SELECT customerId, password FROM customer");
			
		while (rst.next()){
			if(Integer.toString(rst.getInt(1)).equals(custId) && rst.getString(2).equals(custPass)){
				validated = true;
			}
		}
		if (!validated){
			out.println("<H1>Incorrect ID or password. Go back to the previous page and try again.</H1>");
		}
		else{
			out.println("<H1>Order Placed.</H1>");
			validated=false;

			
		
// Save order information to database
			String sql_1 = "INSERT INTO ordersummary (customerId, orderDate)VALUES("
			+Integer.parseInt(custId)+", CURRENT_TIMESTAMP)";
			
			PreparedStatement pstmt = con.prepareStatement(sql_1, Statement.RETURN_GENERATED_KEYS);
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);

		
			
			
			
			double total=0;
			

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
out.println("<h1>Your Order Summary</h1>");
out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
out.println("<th>Price</th><th>Subtotal</th></tr>");

//Traverse Shopping Cart
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
	        String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();
			
			total+=pr*qty;
			
	    	String sql2 = "INSERT INTO orderproduct VALUES (?,?,?,?)";
			PreparedStatement pstmt2 = con.prepareStatement(sql2);		
			pstmt2.setInt(1,orderId);
	    	pstmt2.setInt(2,Integer.parseInt(productId));
	    	pstmt2.setInt(3,qty);
	    	pstmt2.setDouble(4,pr);

		int rowcount = pstmt2.executeUpdate();
		
		
		//showorder
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	String sql3= "UPDATE ordersummary SET totalAmount = "+total+"WHERE orderId="+orderId;
	Statement stmt2=con.createStatement();
	int rowcount = stmt.executeUpdate(sql3);


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/
	
// Clear cart if order placed successfully
	productList.clear();

out.println("<h2>Your order reference number is: "+orderId+"</h2>");
out.println("<h1>Thank you for shopping with Cool COSC Grocery!</h1>");
out.println("<h2><a href=\"index.jsp\">Return to shopping</a></h2>");
		}
		}
		catch (SQLException ex) { out.println(ex); }
		finally 
		{ if (con !=null)
			try
		{con.close();}
		catch (SQLException ex) { out.println(ex); }

		}
}
%>
</BODY>
</HTML>

