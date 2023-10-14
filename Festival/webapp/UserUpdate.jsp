<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>축제모아 - 마이 페이지</title>
    <!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="css/MyPageForm.css" type="text/css" rel="stylesheet">
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
		UserVO userVO = new UserDAO().getUser(userID);
	%>
    <div class="header">
        <div class="logo">
			<a href="Main.jsp">
				<h1>축제모아</h1>
			</a>
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
    
          
	<div class="whiteboard">
		<div class=profile_location>
	    	<div class="profile_container"></div>
	    	<form method="post" action="MyPage.jsp">
	    		<div class="memberModify">
	    			<button type="submit" class="w-btn w-btn-brown"><span>돌아가기</span></button>
			    	<!-- <button type="submit" onclick="return confirm('정말 회원 탈퇴를 진행하시겠습니까?')" title="Button border lightblue" class="button btnBorder btnLightBlue">회원 탈퇴</button> -->
				</div>
			</form>
			<form method="post" action="UserUpdateAction.jsp">
				<span class="memberID">아이디 : <%= userVO.getUserID() %></span>
			    	<div class="profile_img"></div><span class="id"></span>
			   		<span class="last_login">비밀번호 <input type="password" placeholder="＊＊＊＊＊＊＊＊" value="<%= userVO.getUserPassword() %>" name="userPwd" /></span>
			    	<span class="birth">생년월일 : 2000.01.05</span>
			    	<span class="email">이메일 <input type="email" placeholder="xxx@naver.com" value="<%= userVO.getUserEmail() %>" name="userEmail" /></span>
			    	<span class="name">이름 : <%= userVO.getUserName() %> </span>
				<div class="memberModify">
					<button type="submit" onclick="return confirm('회원정보를 정말로 수정하시겠습니까?')" class="w-btn w-btn-indigo"><span>회원정보 수정</span></button>
				    <!-- <button type="submit" title="Button border blue/green" class="button btnBorder btnBlueGreen">회원정보 수정</button> -->
				</div>
			</form>
	    </div>
	</div>
</body>
</html>