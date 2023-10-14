<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<title>축제모아 - 전체 축제 정보</title>
<link href="css/SearchForm.css" type="text/css" rel="stylesheet">
<!-- Google fonts(기본 폰트, 구글 폰트 라이브러리 제공) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<%
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
	 <!-- 페이지네이션 버튼 -->
	<div class="pagination">
		<%
        // 페이지당 축제 수를 설정합니다.
        int festivalsPerPage = 10;

        // 현재 페이지 번호를 파라미터로부터 읽어옵니다. 파라미터가 없을 경우 1페이지로 설정합니다.
        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;

        // 현재 페이지에 표시할 축제 정보의 시작과 끝 인덱스를 계산합니다.
        int startRow = (currentPage - 1) * festivalsPerPage;
        int endRow = currentPage * festivalsPerPage;
        %>
		<!--페이지 버튼 -->
		<div class="container">
			<%
            // 이전 페이지로 이동하는 링크를 생성합니다.
            if (currentPage > 1) {
            %>
            <a class="pageButton pageBtnFirst" href="FestivalList.jsp?page=<%= 1 %>">처음으로</a>
			<a class="pageButton pageBtnBefore" href="FestivalList.jsp?page=<%= currentPage - 1 %>">이전</a>
			<%
            }
            %>
			<!-- 다음 페이지로 이동하는 링크를 생성합니다. -->
			<a class="pageButton pageBtnAfter" href="FestivalList.jsp?page=<%= currentPage + 1 %>">다음</a>
		</div>
	</div> 
	<!-- 전체 축제 정보 표시 -->
	<div class="all-festivals">
		<h2>전체 축제 정보</h2>
		</br><hr></br>
		<%
		    String dbType = "com.mysql.cj.jdbc.Driver";
		    String dbUrl = "jdbc:mysql://localhost:3306/festival?useUnicode=true&serverTimezone=Asia/Seoul";
		    String dbId = "festival";
		    String dbPw = "ehgus12";
		    Connection con = null;
		    PreparedStatement pstmtAll = null;
		    ResultSet resultSetAll = null;

	    try {
	        Class.forName(dbType);
	        con = DriverManager.getConnection(dbUrl, dbId, dbPw);
	
	        // 현재 페이지에 표시할 축제를 가져오는 SQL 쿼리
	        String sqlAll = "SELECT * FROM festival.festival_info LIMIT ?, ?";
	        pstmtAll = con.prepareStatement(sqlAll);
	        pstmtAll.setInt(1, startRow);
	        pstmtAll.setInt(2, festivalsPerPage);
	        resultSetAll = pstmtAll.executeQuery();
	
	        // 축제 정보가 있는지 확인하는 플래그 변수
	        boolean hasResults = false;

	        // 현재 페이지에 표시할 축제 정보를 표시합니다.
	        while (resultSetAll.next()) {
	            // 축제 정보를 표시합니다.
	            String festivalTitle = resultSetAll.getString("festival_title");
	            String festivalRegion = resultSetAll.getString("festival_region");
	            String organizationName = resultSetAll.getString("festival_organization_name");
	            String festivalPeriod = resultSetAll.getString("festival_period");
	            String holdRegion = resultSetAll.getString("hold_region");
	            String visitor = resultSetAll.getString("visitor");
	            String managerName = resultSetAll.getString("manager_name");
	            String managerPhone = resultSetAll.getString("manager_phone");
	            String category = resultSetAll.getString("category");
	            String season = resultSetAll.getString("season");
	            String festivalUrl = resultSetAll.getString("festivalUrl");
	            
	            out.println("<div class='result-item'>");
	            out.println("<h3>" + festivalTitle + "</h3>");
	            out.println("<p>지역: " + festivalRegion + "</p>");
	            out.println("<p>주최: " + organizationName + "</p>");
	            out.println("<p>기간: " + festivalPeriod + "</p>");
	            out.println("<p>개최지: " + holdRegion + "</p>");
	            out.println("<p>방문객 수: " + visitor + "명" + "</p>");
	            out.println("<p>담당자: " + managerName + "</p>");
	            out.println("<p>담당자 연락처: " + managerPhone + "</p>");
	            out.println("<p>카테고리: " + category + "</p>");
	            out.println("<p>계절: " + season + "</p>");
	            out.println("<img src='" + festivalUrl + "' alt='축제 이미지'>");
	            out.println("</br><hr></br>");
	            out.println("</div>");
	
	            // 축제 정보가 있음을 표시
	            hasResults = true;
	        }

	        // 축제 정보가 없는 경우 "축제가 없습니다." 메시지를 표시합니다.
	        if (!hasResults) {
	            out.println("<p>축제가 없습니다.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 리소스 정리 (Connection, PreparedStatement, ResultSet)
        if (resultSetAll != null) resultSetAll.close();
        if (pstmtAll != null) pstmtAll.close();
        if (con != null) con.close();
    }
    %>
	</div>
	<!-- footer 시작 -->
	<div class="copyright">
		<div class="w_val">
			<div class="copyright_text">
				우)26412 서울특별시 중랑구 용마산로 90길 28, TEL 02.490.7300 <br />
				대표자 : 이도현, 임동준, 박찬근	대표번호 : 054)289-7999 / 7800 | 팩스 054)274-6830 
				<span>Copyright 2023	ⓒ축제모아. All Rights Reserved.</span>
			</div>

			<select class="bottom_select" name="" id="" class="fl"
				onchange="if(options[selectedIndex].value) window.open(options[selectedIndex].value,'')">
				<option value="#">문화시설 바로가기</option>
				<option value="https://www.odii.kr/smarttour_web/webguide/main">오디(Odii)</option>
				<option value="https://korean.visitkorea.or.kr/main/main.do">대한민국-구석구석</option>
				<option value="http://www.arte.or.kr">한국문화예술교육진흥원</option>
				<option value="https://knto.or.kr/index">한국관광공사</option>
				<option value="http://www.gokams.or.kr">예술경영지원센터</option>
				<option value="http://www.mcst.go.kr">문화체육관광부</option>
				<option value="http://www.arko.or.kr">한국문화예술위원회</option>
				<option value="https://api.visitkorea.or.kr/#/">ToruAPI</option>
			</select>
		</div>
	</div>
	<!-- footer 끝 -->
</body>
</html>