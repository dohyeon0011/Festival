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
	    	 <form method="post" action="UserDeleteAction.jsp">
	    		<div class="memberModify">
	    			<button type="submit" onclick="return confirm('정말 회원 탈퇴를 진행하시겠습니까?')" class="w-btn w-btn-brown"><span>회원 탈퇴</span></button>
			    	<!-- <button type="submit" onclick="return confirm('정말 회원 탈퇴를 진행하시겠습니까?')" title="Button border lightblue" class="button btnBorder btnLightBlue">회원 탈퇴</button> -->
				</div>
			</form>
			<form method="post" action="UserUpdate.jsp">
				<span class="memberID">아이디 : <%= userVO.getUserID() %></span>
		    	<div class="profile_img"></div><span  class="id"></span>
		    	<span class="birth">생년월일 : 2000.01.05</span>
		    	<span class="email">이메일 : <%= userVO.getUserEmail() %></span>
		    	<span class="name">이름 : <%= userVO.getUserName() %> </span>
				<div class="memberModify">
					<button type="submit" class="w-btn w-btn-indigo"><span>회원정보 수정</span></button>
				    <!-- <button type="submit" title="Button border blue/green" class="button btnBorder btnBlueGreen">회원정보 수정</button> -->
				</div>
			</form>
	    </div>
	    <!-- 
		<span class="list">찜한 목록</span>
		<div class="festival1_img"></div>
	    <div class="icon_1"></div>
	    <span class="festival1_name"> 가평 에덴 벚꽃축제</span>
	    	<div class=festival1_info>
	    	<span class="festival_day">일시 : 2023.04.01(토) ~ 2023.06.18(일)</span>
	    	<span class="festival_location">개최장소 : 경기 용인시 한국민속촌</span>
	    	<span class="festival_phone">담당자 번호 : 031-288-0000</span>
	    </div>
	    <div class="festival2_img"></div>
	    <div class="icon_2"></div>
	    <span class="festival2_name"> 서울랜드 불빛축제 루나파크</span>
	    <div class=festival2_info>
	    	<span class="festival_day">일시 : 2023.01.01(일) ~ 2023.12.31(일)</span>
	    	<span class="festival_location">개최장소 : 서울랜드</span>
	    	<span class="festival_phone">담당자 번호 : 02-509-6000</span>
	    </div>
	  
	    <div class="festival3_img"></div>
	    <div class="icon_3"></div>
	    <span class="festival3_name"> 대구치맥페스티벌</span>
	    <div class=festival3_info>
	    	<span class="festival_day">일시 : 2023.08.30(수) ~ 2023.09.03(일)</span>
	    	<span class="festival_location">개최장소 : 두류공원 일원</span>
	    	<span class="festival_phone">담장자 번호 : 053-248-9998</span>
	    </div>
	
	
	    <div class="festival4_img"></div>
	    <div class="icon_4"></div>
	    <span class="festival4_name"> 서울국제도서전</span>
	    <div class=festival4_info>
	   		<span class="festival_day">일시 : 2023.06.14(수) ~ 2023.06.18(일)</span>
	   		<span class="festival_location">개최장소 : 코엑스</span>
	   		<span class="festival_phone">담당자 번호 : 02-733-8402</span>
	   	</div>
	   		
	    <div class="festival5_img"></div>
	    <div class="icon_5"></div>
	    <span class="festival5_name"> 서초뮤직앤아트페스티벌</span>
	    <div class=festival5_info>
	    	<span class="festival_day">일시 : 2023.06.16(금) ~ 2023.06.17(토)</span>
	    	<span class="festival_location">개최장소 : 서울고속버스터미널 광장</span>
	    	<span class="festival_phone">담당자 번호 : 02-3477-2858</span>
	    </div>
	  
	    <div class="festival6_img"></div>
	    <div class="icon_6"></div>
	    <span  class="festival6_name"> 허브아일랜드 라벤더축제</span>
	    <div class=festival6_info>
	    	<span class="festival_day">일시 : 2023.04.22(토) ~ 2023.07.01(토)</span>
	    	<span class="festival_location">개최장소 : 허브아일랜드</span>
	    	<span class="festival_phone">담당자 번호 : 031-535-6494</span>
	    </div>
	</div>
	 -->
</body>
</html>