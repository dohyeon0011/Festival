<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>	
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
		if (session.getAttribute("userID") != null) {//주어진 userID에 연결된 속성값을 얻어낸다.
			userID = (String) session.getAttribute("userID");
		}
		if (request.getParameter("searchField") == "0" || request.getParameter("searchText") == null
			|| request.getParameter("searchField").equals("0") || request.getParameter("searchText").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		// 현재 페이지가 몇번째 페이지 인가
		int pageNumber = 1;	// 기본적으로 1페이지
		if (request.getParameter("pageNumber") != null)
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<%
					}
					else {
				%>
				<li><a href="LogoutAction.jsp">로그아웃</a></li>
				<li><a href="MyPage.jsp">마이페이지</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>

	<form method="post" name="search" action="BoardSearch.jsp">
		<table class="pull-right">
			<tr>
				<td><select class="form-control" name="searchField">
						<option value="0">선택</option>
						<option value="bbsTitle">제목</option>
						<option value="userID">작성자</option>
				</select></td>
				<td><input type="text" class="form-control"
					placeholder="검색어 입력" name="searchText" maxlength="100"></td>
				<td><button type="submit" class="pageButton boardSearch">검색</button></td>
			</tr>
		</table>
	</form>

	<form action="write.jsp" method="post">
		<table>
			<thead>
				<tr>
					<th>글번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>작성 날짜</th>
					<th>조회수</th>
					<th>추천수👍</th>
				</tr>
			</thead>
			<tbody>
				<%
					BoardDAO boardDAO = new BoardDAO();
					ArrayList<BoardVO> list = boardDAO.getSearch(request.getParameter("searchField"), 
							request.getParameter("searchText"));
					if (list.size() == 0) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('검색결과가 없습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getBoardNo()%></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><a class="boardTitle check" href="BoardView.jsp?boardNo=<%=list.get(i).getBoardNo()%>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
					.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
					<td><%= list.get(i).getCreateDate() %></td>
					<td><%= list.get(i).getBoardCount() %></td>
					<td><%= list.get(i).getLikeCount()%></td>
					</tr>
					<%
						}
					%>
			</tbody>
		</table>
		
		<a class="pageButton boardList" href="Board.jsp">목록</a>
		<div class=container style="text-align: center">
				<%
					if (pageNumber != 1) {	// 이전페이지로
				%>
				<a class="pageButton pageBtn" href="Board.jsp?pageNumber=<%=pageNumber - 1%>">이전</a>
				<%
					}
				%>
				<%
					int n = (int) (boardDAO.getCount() / 10 + 1);
					for (int i = 1; i <= n; i++) {
				%>
				<a class="paging" href="Board.jsp?pageNumber=<%=i%>"><%=i%>
				</a>
				<%
					}
				%>
				<%
					if (boardDAO.nextPage(pageNumber + 1)) {	//다음페이지가 존재하는가
				%>
				<a class="pageButton pageBtn" href="Board.jsp?pageNumber=<%=pageNumber + 1%>">다음</a>
				<%
					}
				%>
		</div>
			
		<%-- <%
			if (pageNumber != 1) {
		%>				
				<a class="pageButton pageBtn" href="Board.jsp?pageNumber=<%= pageNumber - 1 %>">이전</a>
		<% }
		
			if (boardDAO.nextPage(pageNumber + 1)) {
		%>
				<a class ="pageButton pageBtn" href="Board.jsp?pageNumber=<%= pageNumber + 1 %>">다음</a>
		<%
		}
		%> --%>
						
		<%
			if (session.getAttribute("userID") != null) {
		%>
				<button type="submit" class="btn btn--blue">
					<span class="btn__txt">글쓰기</span>
					<i class="btn__bg" aria-hidden="true"></i>
					<i class="btn__bg" aria-hidden="true"></i>
					<i class="btn__bg" aria-hidden="true"></i>
					<i class="btn__bg" aria-hidden="true"></i>
				</button>
		<%		
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 후 이용해 주세요.')");
				script.println("location.href = 'Login.jsp'");
				script.println("</script>");
			}
		%>
	</form>
</body>
</html>