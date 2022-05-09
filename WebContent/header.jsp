<H1 align="center"><font face="cursive" color="#3399FF"><a href="index.jsp">World Wide Wins</a></font></H1>      
<p align="center"><i> "Someone's gotta be a winner!"</i></p>
<h3 align="center"> <%
// TODO: Display user name that is logged in (or nothing if not logged in)	
if (session.getAttribute("authenticatedUser") != null){
	out.println("Signed in as: "+session.getAttribute("authenticatedUser")+" <a href=\"logout.jsp\" style=\"text-decoration:none\">[Log out]</a>");
}
else {
	out.println("<a href=\"login.jsp\" style=\"text-decoration:none\">Login</a>");
	out.println("&emsp; <a href=\"signup.jsp\" style=\"text-decoration:none\">Sign Up</a>");}
%> 
<%
//    PROFILE PICTURE
//String uname= session.getAttribute("authenticatedUser").toString();
//getConnection();
//String sqlheader="SELECT profileImg FROM customer WHERE userid="+uname;


%>
&emsp; <a href="customer.jsp" style="text-decoration:none">Customer Info</a>
 &emsp; <a href="showcart.jsp" style="text-decoration:none">Show Cart</a>
 &emsp; <a href="checkout.jsp"style="text-decoration:none">Check Out</a></h3>
<hr>
