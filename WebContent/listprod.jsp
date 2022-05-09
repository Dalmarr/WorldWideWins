<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>World Wide Wins</title>
</head>
<body>
<%@ include file="header.jsp" %>


<h1>Search for the products you want to buy:</h1>

<form  method="get" action="listprod.jsp">
<input  type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
// Make the connection
		String uid = "ysalyani";
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ysalyani"; 		
		String pw = "32514151";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		Connection con=null;
		try{
		con = DriverManager.getConnection(url, uid, pw);
		
		//Get Best Sellers
		String bestSQL= "SELECT TOP 5 productId, SUM(quantity) as sumQ FROM orderproduct "+
						"GROUP BY productId ORDER BY sumQ DESC";
		PreparedStatement bestPst= con.prepareStatement(bestSQL);
		ResultSet bestRst=bestPst.executeQuery();
		bestRst.next();
		int bestSell1= bestRst.getInt(1);
		bestRst.next();
		int bestSell2= bestRst.getInt(1);
		bestRst.next();
		int bestSell3= bestRst.getInt(1);
		
		
		String sql= "SELECT productName, productId, productPrice FROM product ";
	 	boolean hasName = name != null && !name.equals("");
		PreparedStatement pst= null;
		ResultSet rst=null;
		if (!hasName){
			pst= con.prepareStatement(sql);
			rst =pst.executeQuery();
			out.println("<h2 align=center>All Products</h2>");
		}
		else if (hasName){
			out.println("<h2 align=center>Products containing '"+name+"' </h2>");
			name="%"+name+"%";
			sql+="WHERE productName LIKE ?";
			pst= con.prepareStatement(sql);
			pst.setString(1,name);
			rst =pst.executeQuery();
		}
		out.println("<table align=center><tr><th></th><th> Product Name</th><th></th><th>Price</th>");
		// Print out the ResultSet

		while (rst.next()){
			out.print("<tr><td><a href=\"addcart.jsp?id="+rst.getInt(2)+"&amp;name="+rst.getString(1)+"&amp;price="+rst.getBigDecimal(3)+"\">Add to Cart</a>"
					+"</td><td><a href=\"product.jsp?id="+rst.getInt(2)+"\">"+rst.getString(1)+"</a></td><td>");
			if (rst.getInt(2)==bestSell1||rst.getInt(2)==bestSell2||rst.getInt(2)==bestSell3){
				out.print(" *BEST SELLER* ");
			}
			
			out.println("</td><td>"+currFormat.format(rst.getBigDecimal(3))+"</td></tr>");

			
		}
		out.println("</table>");
// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
		}
		catch (SQLException ex) { out.println(ex); }
		finally 
		{ if (con !=null)
			try
		{con.close();}
		catch (SQLException ex) { out.println(ex); }

		}
%>

</body>
</html>