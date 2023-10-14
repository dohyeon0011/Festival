<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>축제모아 - 자유게시판</title>
	<link href="css/boardForm.css" type="text/css" rel="stylesheet">
	
	<!-- Google fonts(기본 폰트, 구글 폰트 라이브러리 제공) -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<%
		String userID = null;
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주시기 바랍니다.')");
			script.println("location.href = 'Login.jsp'");
			script.println("</script>");
		}
		
		int boardNo = 0;
		
		if (request.getParameter("boardNo") != null) {
			boardNo = Integer.parseInt(request.getParameter("boardNo"));
		}
		
		if (boardNo == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'Board.jsp'");
			script.println("</script>");
		}
		
		BoardVO boardVO = new BoardDAO().getBoard(boardNo);
		if (!userID.equals(boardVO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'Board.jsp'");
			script.println("</script>");
		}
	%>
	<div class="header">
		<div class="logo">
			<h1>
				<a href="Main.jsp">축제모아</a>
			</h1>
		</div>
		<div class="categories">
			<ul>
				<li><a href="FestivalList.jsp">축제 목록</a></li>
                <li><a href="Board.jsp">후기게시판</a></li>
			</ul>
		</div>
		<div class="categories">
			<ul>
				<%
					// 로그인한 사람이라면 userID라는 변수에 해당 세션에 있는 아이디가 담기고 그렇지 않으면 null값
					if (session.getAttribute("userID") == null) {
				%>
					<li><a href="Login.jsp">로그인</a></li>
					<li><a href="Login.jsp">마이페이지</a></li>
				<% }
					else {
				%>
					<li><a href="LogoutAction.jsp">로그아웃</a></li>
					<li><a href="MyPage.jsp">마이페이지</a></li>
				<% } %>
			</ul>
		</div>
	</div>
	
	<form method="post" action="BoardUpdateAction.jsp?boardNo=<%= boardNo %>">
		<table>
			<thead>
				<tr>
					<th colspan="2">게시판 글 수정</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" placeholder="글 제목" name="boardTitle" maxlength="50" value="<%= boardVO.getBoardTitle() %>"></td>
				</tr>					
				<tr>
					<td><textarea placeholder="글 내용" name="boardContent" maxlength="2048"> <%= boardVO.getBoardContent() %></textarea></td>
				</tr>
			</tbody>
		</table>
		
		<button type="submit" class="btn btn--blue">
			<span class="btn__txt">수정하기</span>
			<i class="btn__bg" aria-hidden="true"></i>
			<i class="btn__bg" aria-hidden="true"></i>
			<i class="btn__bg" aria-hidden="true"></i>
			<i class="btn__bg" aria-hidden="true"></i>
		</button>
	</form>
</body>
</html>