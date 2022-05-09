<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.File"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Scanner"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="servlet.LoadData" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
LoadData restore= new LoadData();
restore.loadData();
%>

</body>
</html>
<jsp:forward page="admin.jsp" />