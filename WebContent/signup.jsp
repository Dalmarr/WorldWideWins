<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign-Up</title>
</head>
<script>
function update(fname, lname, email, pnum, adr, city, st, pc, country, uname, pass)
{
	
	if (parseInt(pnum))
	window.location="signup.jsp?fname="+fname+"&lname="+lname+"&email="+email+"&pnum="+pnum+"&adr="+adr+"&city="+city+"&st="+st+"&pc="+pc+"&country="+country+"&uname="+uname+"&pass="+pass;
   	else
	alert("Invalid entry. Phone number must be a number.")
}
function ValidateEmail(mail) 
{
 if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(newcust.email.value))
  {
    return (true)
  }
 else{
    alert("You have entered an invalid email address!")
    return (false)
}
	
}
</script>
<body>
<form name=newcust method=get 
action=>
<%
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String pnum = request.getParameter("pnum");
String adr = request.getParameter("adr");
String city = request.getParameter("city");
String st = request.getParameter("st");
String pc = request.getParameter("pc");
String country = request.getParameter("country");
String uname = request.getParameter("uname");
String pass= request.getParameter("pass");
if (fname!=null &&!fname.equals("")){
getConnection();
String sql="INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
PreparedStatement pst = con.prepareStatement(sql);
pst.setString(1, fname); 
pst.setString(2, lname); 
pst.setString(3, email); 
pst.setString(4, pnum); 
pst.setString(5, adr); 
pst.setString(6, city); 
pst.setString(7, st); 
pst.setString(8, pc); 
pst.setString(9, country); 
pst.setString(10, uname); 
pst.setString(11, pass);
pst.executeUpdate();
out.println("<h1 align=center> Sign up success. You are now ready to play!<h1>");
closeConnection();

}
%>
<h3>First Name</h3>
<input type="text" name="fname" size="50" ">

<h3>Last Name</h3>
<input type="text" name="lname" size="50" ">

<h3>Email</h3>
<input type="text" placeholder="e.g. winner@maxwinners.com" name="email" onchange="ValidateEmail(this.value)" size="50">

<h3>Phone Number</h3>
<input type="text" maxlength="15" placeholder="e.g. 204-371-9349" name="pnum" size="50">

<h3>Address</h3>
<input type="text" name="adr" size="50">

<h3>City</h3>
<input type="text" name="city" size="50">

<h3>State</h3>
<input type="text" name="st" size="50">

<h3>Postal Code</h3>
<input type="text" name="pc" size="50">

<h3>Country</h3>
<input type="text" name="ctry" size="50">

<h3>Username</h3>
<input type="text" name="uname" size="50">

<h3>Password</h3>
<input type="password" name="pass" size="50">


<input type="button" onclick=update(newcust.fname.value,newcust.lname.value,newcust.email.value,newcust.pnum.value,newcust.adr.value,newcust.city.value,newcust.st.value,newcust.pc.value,newcust.ctry.value,newcust.uname.value,newcust.pass.value,) value="Sign Up">
</form>
</body>
</html>