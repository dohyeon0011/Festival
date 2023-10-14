<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>축제모아 - 검색 결과</title>
    <link href="css/SearchForm.css" type="text/css" rel="stylesheet">
    <!-- Google fonts(기본 폰트, 구글 폰트 라이브러리 제공) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
<div class="header">
    <div class="logo">
        <a href="Main.jsp">
            <h1>축제모아</h1>
        </a>
    </div>
    <div class="categories">
        <ul>
            <ul>
                <li><a href="FestivalList.jsp">축제 목록</a></li>
                <li><a href="Board.jsp">후기게시판</a></li>
            </ul>
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
					} else {
				%>
				<li><a href="LogoutAction.jsp">로그아웃</a></li>
				<li><a href="MyPage.jsp">마이페이지</a></li>
				<%
					}
				%>
			</ul>
    </div>
</div>

<!-- 검색 결과 표시 -->
<div class="search-results">
    <h2>검색 결과</h2>
    <p>검색어: <%= request.getParameter("keyword") %></p>
    </br><hr></br>

    <%-- 검색어를 기반으로 데이터베이스에서 축제 정보를 가져오는 부분 --%>
    <%
	    String keyword = request.getParameter("keyword");
	    String dbType = "com.mysql.cj.jdbc.Driver";
	    String dbUrl = "jdbc:mysql://localhost:3306/festival?useUnicode=true&serverTimezone=Asia/Seoul";
	    String dbId = "festival";
	    String dbPw = "ehgus12";
	    Connection con = null;
	    PreparedStatement pstmtAll = null; // 전체 축제 정보를 가져오기 위한 PreparedStatement
	    PreparedStatement pstmtSearch = null; // 검색 결과를 가져오기 위한 PreparedStatement
	    ResultSet resultSetAll = null; // 전체 축제 정보를 저장할 ResultSet
	    ResultSet resultSetSearch = null; // 검색 결과를 저장할 ResultSet

    try {
        Class.forName(dbType);
        con = DriverManager.getConnection(dbUrl, dbId, dbPw);

        // 전체 축제 정보를 가져오는 SQL 쿼리
        String sqlAll = "SELECT * FROM festival_info";
        pstmtAll = con.prepareStatement(sqlAll);
        resultSetAll = pstmtAll.executeQuery();

        // 검색 결과 출력
        boolean hasResults = false;
        while (resultSetAll.next()) {
            // 검색 결과를 표시하는 부분
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
            String festivalUrl = resultSetAll.getString("festivalUrl"); // 축제 이미지 URL 컬럼 추가

            // 검색어와 축제명, 지역, 카테고리, 계절을 비교하여 검색 결과 판별
            if (festivalTitle.contains(keyword) || festivalRegion.contains(keyword) ||
                category.contains(keyword) || season.contains(keyword)) {
                hasResults = true;

                // 결과를 웹 페이지에 출력
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
            }
        }
        // 검색 결과가 없는 경우 처리
        if (!hasResults) {
            out.println("<p>검색 결과가 없습니다. 다른 검색어를 시도해보세요.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 필요한 리소스 정리 (Connection, PreparedStatement, ResultSet)
        if (resultSetAll != null) resultSetAll.close();
        if (resultSetSearch != null) resultSetSearch.close();
        if (pstmtAll != null) pstmtAll.close();
        if (pstmtSearch != null) pstmtSearch.close();
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
