<!DOCTYPE html>
<html>
<head>

        <title>World Wide Wins Main Page</title>
        
</head>
<body>
<h1 align="center">Welcome to World Wide Wins</h1>
        <p align="center"><i> "Someone's gotta be a winner!"</i></p>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>
<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
if (session.getAttribute("authenticatedUser") != null){
	out.println("<h2 align=\"center\">Signed in as: "+session.getAttribute("authenticatedUser")+" </h2>");
}

%>

<table align="center"><tr><td><img src="img/main.png"></td></tr></table>
</body>
</head>


