<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
	
	<form method="post" action="BoardWriteAction.jsp">
		<table>
			<thead>
				<tr>
					<th colspan="2">게시판 글쓰기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" placeholder="글 제목" name="boardTitle" maxlength="50"></td>
				</tr>					
				<tr>
					<td><textarea class="content" placeholder="작성할 내용" name="boardContent" maxlength="2048"></textarea></td>
				</tr>
			</tbody>
		</table>
		
		<button type="submit" class="btn btn--blue">
			<span class="btn__txt">글쓰기</span>
			<i class="btn__bg" aria-hidden="true"></i>
			<i class="btn__bg" aria-hidden="true"></i>
			<i class="btn__bg" aria-hidden="true"></i>
			<i class="btn__bg" aria-hidden="true"></i>
		</button>
	</form>
</body>
</html>