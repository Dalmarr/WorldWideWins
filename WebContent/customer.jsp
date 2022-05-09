<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<% 

	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
getConnection();
String sql = "SELECT * FROM customer WHERE userId = '"+userName+"'";
out.println("<table align=\"center\" border=\"1\"><tr><th>CustomerId</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone Number</th><th>Address<th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>UserId</th>");
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery(sql);
while(rst.next()){
	out.println("<tr><td>"+rst.getString(1)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(3)
	+"</td><td>"+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>"+rst.getString(6)+"</td><td>"+rst.getString(7)+"</td><td>"+rst.getString(8)+"</td><td>"+rst.getString(9)+"</td><td>"+rst.getString(10)+"</td><td>"+rst.getString(11)+"</td>");
}



// Make sure to close connection
closeConnection();
%>

</body>
</html>

