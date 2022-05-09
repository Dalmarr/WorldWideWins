<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<FORM method="get"
	action="resetData.jsp">


<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%



NumberFormat currFormat = NumberFormat.getCurrencyInstance();
//Connection con = null;
try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)

		{
			throw new SQLException("ClassNotFoundException: " +e);
		}
	
		Connection con = DriverManager.getConnection(url, uid, pw);
	

			Statement stmt = con.createStatement();
			

// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT orderDate, totalAmount FROM ordersummary ORDER BY orderDate ASC";
ResultSet rst = stmt.executeQuery(sql);
out.println("<table border=\"1\"><tr><th>Order Date</th><th>Total Amount</th></tr>");
while(rst.next()) {
	out.println("<tr><td>"+rst.getDate(1)+"</td><td>"+
	rst.getBigDecimal(2)+"</td></tr>");
	
}
out.println("</table>");





%>
</FORM>
<h3><a href="addprod.jsp" style="text-decoration:none">Add Product</a></h3>

</body>
</html>

