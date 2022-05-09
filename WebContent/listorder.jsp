<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Cool COSC Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
	
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
		String uid = "ysalyani";
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ysalyani"; 		
		String pw = "32514151";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		Connection con=null;
		try{
		con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();
	
		ResultSet rst = stmt.executeQuery("SELECT o.orderId, o.orderDate, o.customerId, c.firstName, c.lastName, o.totalAmount FROM ordersummary AS o, customer AS c WHERE o.customerId = c.customerId");  
		//out.println("<script>alert(\"INITIAL QUERY SUCCESSFUL\")</script>");
		out.println("<table border=\"1\"><tr><th>Order Id</th><th>Order Date</th>"
		+ "<th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
		while (rst.next()){
			out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getDate(2)+"</td><td>"+rst.getInt(3)
			+"</td><td>"+rst.getString(4)+" "+rst.getString(5)+"</td><td>"+currFormat.format(rst.getBigDecimal(6)));
			
			out.println("<tr align=\"right\"><td colspan=\"5\"><table border=\"1\">"
					+"<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
	
			String SQL = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1,rst.getInt(1));
			ResultSet rst2 = pstmt.executeQuery(); 
			while (rst2.next()){
				out.println("<tr><td>"+rst2.getInt(1)+"</td><td>"+rst2.getInt(2)+"</td><td>"+currFormat.format(rst2.getBigDecimal(3))
				+"</td>");
			}
			out.println("</table></td></tr>");

		}
		
	}
	catch (SQLException ex) { out.println(ex); }
	finally 
	{ if (con !=null)
		try
	{con.close();}
	catch (SQLException ex) { out.println(ex); }

	}
		 

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

