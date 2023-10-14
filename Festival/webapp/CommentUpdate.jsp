<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="comment.CommentVO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
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
		
		int commentID = 0;
		if(request.getParameter("commentID")!=null) {
			commentID=Integer.parseInt(request.getParameter("commentID"));
		}
		
		CommentVO comment = new CommentDAO().getComment(commentID);
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

	<table>
		<thead>
			<tr>
				<th colspan="4">후기게시판</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>글 제목</td>
				<td class="boardView title"><%= boardVO.getBoardTitle() %></td>
			</tr>
			<tr>
				<td class="boardView writer">작성자</td>
				<td><%= boardVO.getUserID( )%>
			</tr>
			<tr>
				<td class="boardView createDate">작성일자</td>
				<td><%= boardVO.getCreateDate() %></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><%= boardVO.getBoardCount() + 1 %></td>
			</tr>
			<tr>
				<td>추천수</td>
				<td><%= boardVO.getLikeCount()%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td class="boardView content"><%=boardVO.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
			</tr>
		</tbody>
	</table>

	<a class="pageButton boardList" href="board.jsp">목록</a>
	<a onclick="return confirm('해당 글을 추천하시겠습니까?')" href="BoardLikeAction.jsp?boardNo=<%=boardNo %>" class="boardRecommend ">추천👍</a>
	<%
		if (userID != null && userID.equals(boardVO.getUserID())) {
	%>
			<a class="pageButton pageBtnDelete" onclick="return confirm('정말로 삭제하시겠습니까?')" href="BoardDeleteAction.jsp?boardNo=<%= boardNo %>">삭제</a>
			<a class="pageButton pageBtnUpdate" href="BoardUpdate.jsp?boardNo=<%= boardNo%>">수정</a>
	<%
		}
	%>
	<br><br><br><br><br><br><br>
	<form method="post" action="CommentUpdateAction.jsp?boardNo=<%=boardNo%>&commentID=<%=commentID%>">
		<table>	
			<tbody>
				<tr>
					<td class="comment commentTitle">댓글 수정</td>
				</tr>
					<table>
						<tbody>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="댓글 쓰기" name="commentContent" maxlength="300"
									value=<%=comment.getCommentContent()%>></td>
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
		</table>
	</form>
</body>
</html>