<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- boardWrite의 클래스 가져옴 -->
<%@ page import="board.BoardDAO"%>
<!-- 자바 클래스 사용 -->
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.BoardVO" scope="page" />
<jsp:setProperty name="board" property="boardTitle" />
<jsp:setProperty name="board" property="boardContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// 로그인이 안된 회원들은 페이지에 접속 할 수 없도록
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해 주세요.')");
			script.println("location.href = 'Login.jsp'");
			script.println("</script>");
		}

		else {
			if (board.getBoardTitle() == null || board.getBoardContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");

		} else {
			board.BoardDAO boardDAO = new board.BoardDAO(); // 인스턴스생성
			int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent(), 0, 0);
			
			if (result == -1) { // 아이디가 기본키기. 중복되면 오류.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}

			// 글쓰기성공
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'Board.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>