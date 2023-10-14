<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <jsp:useBean id="user" class="user.UserVO" scope="page" />
<jsp:setProperty name="user" property="*" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>축제모아 회원수정</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해 주세요.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		}
		
		/*
		if (user.getUserPwd() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		*/
		
		if(request.getParameter("userPwd") == null || request.getParameter("userEmail") == null) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.update(userID, request.getParameter("userPwd"), request.getParameter("userEmail"));
			/* int result = userDAO.update(user); */
			
			if (result == -1) {	// 데이터베이스 오류가 날 때
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원정보 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원정보 수정에 성공했습니다.')");
				script.println("location.href='MyPage.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>