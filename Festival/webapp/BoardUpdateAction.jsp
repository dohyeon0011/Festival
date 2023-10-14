<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- boardWrite의 클래스 가져옴 -->
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<!-- 자바 클래스 사용 -->
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
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

		else {
			// boardUpdate.jsp에서 글 제목과 내용에 적은 name명으로 넘어오는 값을 매개변수로서 받아옴
			if (request.getParameter("boardTitle") == null || request.getParameter("boardContent") == null
				|| request.getParameter("boardTitle").equals("") || request.getParameter("boardContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다. 다시 시도해 주세요.')");
				script.println("history.back()");
				script.println("</script>");
		} else {
			board.BoardDAO boardDAO = new board.BoardDAO(); // 인스턴스생성
			int result = boardDAO.update(boardVO.getBoardNo(), request.getParameter("boardTitle"), request.getParameter("boardContent"));
			
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
				script.println("alert('작성하신 게시글이 수정되었습니다.')");
				script.println("location.href = 'Board.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>