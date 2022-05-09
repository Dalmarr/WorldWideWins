
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="jdbc.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
getConnection();
Object userName = session.getAttribute("authenticatedUser");
int prodId = Integer.parseInt(request.getParameter("productId"));
String custName = userName.toString();
String custReview = request.getParameter("review");
 


			String sql_1 = "INSERT INTO review (customerName, productId, reviewComment, reviewDate)VALUES("
			+ " ?, ?, ? , CURRENT_TIMESTAMP)";
			
			PreparedStatement pstmt2 = con.prepareStatement(sql_1, Statement.RETURN_GENERATED_KEYS);
			pstmt2.setString(1, custName);
			pstmt2.setInt(2, prodId);
			pstmt2.setString(3, custReview);
			pstmt2.executeUpdate();
			
			

closeConnection();
%>
</body>

</html>
<jsp:forward page="product.jsp" />