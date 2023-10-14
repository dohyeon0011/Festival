<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.CommentVO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null) {
			userID=(String)session.getAttribute("userID");
		}
		
		if(userID == null) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		}
		
		int boardNo = 0;
		if(request.getParameter("boardNo") != null) {
			boardNo = Integer.parseInt(request.getParameter("boardNo"));
		}
		
		int commentID = 0;
		if(request.getParameter("commentID") != null) {
			commentID = Integer.parseInt(request.getParameter("commentID"));
		}
			
		if(commentID == 0) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='Board.jsp'");
			script.println("</script>");
		}
		
		CommentVO commentVO = new CommentDAO().getComment(commentID);
		if(!userID.equals(commentVO.getUserID())) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='Board.jsp'");
			script.println("</script>");
		} else {
			if(request.getParameter("commentContent")==null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					CommentDAO commentDAO=new CommentDAO();//하나의 인스턴스
					int result = commentDAO.update(boardNo, commentID, request.getParameter("commentContent"));
					if(result == -1) {	// 데이터 베이스 오류가 날 때
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("alert('댓글 수정에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("location.href= \'BoardView.jsp?boardNo=" + boardNo + "\'");
						script.println("</script>");
					}
			}
		}
	%>
</body>
</html>