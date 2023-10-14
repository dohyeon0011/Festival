<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>축제모아 - 메인 페이지</title>
    <link href="css/MainForm.css" type="text/css" rel="stylesheet">
	<!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width,initial-scale=1">
    <!-- Google fonts(기본 폰트, 구글 폰트 라이브러리 제공) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<!-- 캘린더 JS 시작 -->
	<script type="text/javascript" src="js/Calendar.js"></script>
	<!-- 캘린더 JS 끝 -->
	
	<!--  이미지 슬라이드 CSS, JS 시작 -->
	<link type="text/css" rel="stylesheet" href="css/imgSlide.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
	<!-- 이미지 슬라이드 CSS, JS 끝 -->
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
    <div class="search">
	    <form action="FestivalSearch.jsp" method="GET">
	        <input class = "searchInputBox" type="text" name="keyword" placeholder="검색어를 입력하세요">
	        <button class = "searchBtn" type="submit">검색</button>
		</form>
    </div>
    <div class="popular-searches">
        <ul>
            <li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=대구치맥페스티벌">대구치맥페스티벌</a></li>    			<li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=강릉문화재야행">강릉문화재야행</a></li><br/><br/>
            <li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=전농로 왕벚꽃축제">전농로 왕벚꽃축제</a></li>    				<li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=곡성세계장미축제">곡성세계장미축제</a></li><br/><br/>
            <li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=횡성한우축제">횡성한우축제</a></li>    			<li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=대전 서구힐링 아트페스티벌">대전 서구힐링 아트페스티벌</a></li><br/><br/>
            <li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=황룡강 가을꽃축제">황룡강 가을꽃축제</a></li>    			<li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=100대 피아노">100대 피아노</a></li><br/><br/>
            <li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=부천국제만화축제">부천국제만화축제</a></li>    		<li><a style="color: black" href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=아트피크닉">아트피크닉</a></li><br/><br/>
        </ul>
    </div>
    <div class="four-divisions">
    	<div class="division">
	        <h2><a style="color: black" href="#today">Today</a></h2>
	        <p>오늘의 축제 정보가 궁금하다면!</p>
	    </div>
	    <div class="division">
			<h2><a style="color: black" href="#schedule">캘린더</a></h2>
	        	<p>축제 일정을 확인하세요!</p>
		</div>
		<div class="division">
			<h2 id='Theme'><a style="color: black" href="#theme">테마</a></h2>
				<p>다양한 유형의 축제를 즐기고 싶을 땐?</p>
	   </div>
		<div class="division">
			<h2><a style="color: black" href="#food">먹거리</a></h2>
				<p>눈도 배도 즐거운 축제를 즐기고 싶을 때!</p>
	   </div>
	</div>
	<br/><br/>
	
	<!-- 캘린더 소스 시작 -->
	<div>
	    <table id='schedule' class="Calendar">
	        <thead>
	            <tr>
	                <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
	                <td colspan="5">
	                    <span id="calYear"></span>년
	                    <span id="calMonth"></span>월
	                </td>
	                <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
	            </tr>
	            <tr>
	                <td>일</td>
	                <td>월</td>
	                <td>화</td>
	                <td>수</td>
	                <td>목</td>
	                <td>금</td>
	                <td>토</td>
	            </tr>
	        </thead>
	        <tbody>
	        </tbody>
	    </table>
	</div>
	<br/><br/><br/><br/>
	<!-- 캘린더 끝 -->

	<!-- 슬라이드 시작 -->
	<!-- 클래스명은 변경하면 안 됨 -->
	<h2 id='today' class="swiper-title">지금 즐겨야 하는 축제!</h2>
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=안동국제탈춤페스티벌">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230726_34%2F1690339523104lGTvO_JPEG%2F110_25802330_manual_image_url_1690339523079.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=제주레저힐링축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230816_253%2F1692150892651enMMf_PNG%2F2997622_image2_1.png">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=순천푸드앤아트페스티벌">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230922_149%2F1695371099143p5pM4_JPEG%2F110_24678072_manual_image_url_1695371099123.jpg">
				</a>>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=와일드&로컬푸드축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230913_254%2F169459061038009QhJ_JPEG%2F110_28501903_manual_image_url_1694590610339.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=동읍 무점마을 코스모스축제">
					<img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fimgnews.pstatic.net%2Fimage%2Forigin%2F5090%2F2023%2F10%2F03%2F2291181.jpg&type=ofullfill264_180_gray&expire=2&refresh=true">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=소래포구축제">
					<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA5MDhfMjM3%2FMDAxNjk0MTI3NjA4MjI0.VO9umD9EOMeOaE2UD3eSlEMgyE4SwuLK0UMGZ393bRwg.6KfSPJ4Nlzag7zourYAAERv-EJsBYRbeqEKwuFeKB6kg.JPEG.imsogroovy%2FIMG_6250.jpg%231170x1170&type=ff264_180">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=INK콘서트">
					<img src="https://search.pstatic.net/common?type=o&size=174x242&quality=75&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230728_24%2F1690508176526O9trL_JPEG%2F269_image_url_1690508176515.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=울산서머페스티벌">
					<img src="https://search.pstatic.net/common?type=o&size=174x242&quality=75&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230710_7%2F1688966870274WI9xr_JPEG%2F269_image_url_1688966870253.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=송도세계문화관광축제(송도맥주축제)">
					<img src="https://search.pstatic.net/common?type=o&size=174x242&quality=75&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230721_59%2F1689934853550zjfiC_JPEG%2F269_31909565_image_url_1689934853526.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=부산바다축제">
					<img src="https://search.pstatic.net/common?type=n&size=138x200&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230714_35%2F1689320581639dsX56_PNG%2F110_24788876_manual_image_url_1689320581595.png">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=대구치맥페스티벌">
					<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA2MjNfMiAg%2FMDAxNjU1OTM2NTE5MDQ4.zS_3iIjO_9M-vPqx3Ym5Alik3_vnVUYLu-2p1RsQSZQg.JcxEVODiMX0sNNDZYoSDlyA5x7HELb5HpXRh0KBHqIgg.PNG.seulowy%2F%25BD%25E6%25B3%25D7%25C0%25CF_%25C1%25A4%25BA%25B8_%25C4%25A1%25B8%25C6%25C6%25E4%25BD%25BA%25C6%25BC%25B9%25FA.png&type=a340">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=인천개항장문화재야행">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230711_74%2F1689052799822d6I7e_JPEG%2F110_9767153_manual_image_url_1689052799784.jpeg">
				</a>
			</div>
		</div>

		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div>
		<!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div>
		<!-- 이전 버튼 -->

		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
	<br/><br/><br/>
	<!-- 슬라이드 끝 -->

	<!-- 슬라이드 시작 -->
	<!-- 클래스명은 변경하면 안 됨 -->
	<h2 id='theme' class="swiper-title">즐기기 좋은 체험!</h2>
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=해운대 카운트다운&해맞이축제">
					<img src="https://search.pstatic.net/sunny?src=https%3A%2F%2Fimg1.daumcdn.net%2Fthumb%2FR800x0%2F%3Ffname%3Dhttps%253A%252F%252Fblog.kakaocdn.net%252Fdn%252FbE70jL%252FbtrURUrcmPH%252F1rzkms6jXWnybSVi9LVrr0%252Fimg.jpg&type=fff264_180">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=해돋이 행사">
					<img src="https://search.pstatic.net/common?type=n&size=138x200&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230102_20%2F1672635797565SWEAm_JPEG%2F2576620_image2_1.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=천안흥타령춤축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230414_276%2F1681457793481o4IYS_JPEG%2F2953012_image2_1.jpg">
				</a>>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=상주 소울푸드 페스티벌">
					<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA5MjRfMTc5%2FMDAxNjYzOTQ5MzUzODk3.HlO35q4qpRw-oXvkttfSSwPp6BQV-H3eQCfoO-P9hBkg.F_X9hClDgx9oalqQ1LPBzqTKlyzwpgNCwom3R2t_oX8g.JPEG.happy5150515%2FScreenshot%25A3%25DF20220924%25A3%25DF010108.jpg&type=a340">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=계룡군문화축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230710_56%2F1688952087102NoS7f_JPEG%2F110_31862867_manual_image_url_1688952087066.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=정읍 구절초 꽃축제">
					<img src=https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEwMDNfMjM4%2FMDAxNjk2MzA4NTYwNDgw.DGfwaVsxB5ZrtvsOB9T5OFK6c9eBYPBHGZFWtktbsTwg.HMLF7b_hwil40Cit9c6gva40fFFd-yiMo_u7cL8bFaUg.JPEG.meal_910%2FScreenshot%25A3%25DF20231003%25A3%25AD134714.jpg&type=a340>
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=희망 드림 빛 축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20221220_57%2F1671502148257au1T2_JPEG%2F2935217_image2_1.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=사상강변축제">
					<img src="https://search.pstatic.net/common?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA5MjVfMTQ5%2FMDAxNjk1NjAzOTUxMzkx._fYGrG0yk6gIn-y5NT69m5uEfmzhAtbGjHztj4Lmf-Ug.VStSy0_992QTEhhqKnfHuE27a-GpFbiukzNNpeWyacQg.PNG.jeongganjii%2F1.png&type=fff264_180">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=동인천 낭만시장">
					<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEwMTBfMTYw%2FMDAxNjk2OTAwNTEyNzA4.BXJ0vvTuO-yJq6EUA2EzRuf2Quf8AmY35yQRVoy4H5gg.33dTDd68Chj203_8yyv6_1cJpqNSi9W4Tdjwgq5n9ZQg.PNG.planets456%2F%25B3%25B6%25B8%25B8%25C3%25E0%25C1%25A6.png%232917x2500&type=ff264_180">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=강릉단오제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230424_118%2F168230208523011o1g_JPEG%2F2983976_image2_1.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=청도소싸움축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230330_186%2F1680139466636F4HR6_JPEG%2F2953120_image2_1.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=울산옹기축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230420_133%2F1681955358381Xtrbm_JPEG%2F2978050_image2_1.jpg">
				</a>
			</div>
		</div>

		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div>
		<!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div>
		<!-- 이전 버튼 -->

		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
	<br/><br/><br/>
	<!-- 슬라이드 끝 -->
	
	<!-- 슬라이드 시작 -->
	<!-- 클래스명은 변경하면 안 됨 -->
	<h2 id="food" class="swiper-title">맛있는 먹거리 음식!</h2>
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=한산모시문화제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230331_100%2F1680229859332KvoIK_JPEG%2F2953001_image2_1.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=영동포도축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230711_81%2F1689054341424Vbv17_JPEG%2F110_19292767_manual_image_url_1689054341409.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=세종조치원복숭아축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230717_184%2F1689557140517KjHL1_PNG%2F110_19297112_manual_image_url_1689557140498.png">
				</a>>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=사천시 삼천포항 자연산 전어축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230816_179%2F1692171607698vJmot_JPEG%2F110_26498090_manual_image_url_1692171607657.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=봉화은어축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230720_120%2F1689812357852zC1Rc_PNG%2Fde48709ea48113fd045f3f9dc16a060c.png">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=둔내고랭지토마토축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230727_90%2F1690434884128jWLBm_JPEG%2F110_28606776_manual_image_url_1690434884107.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=고창 복분자와수박축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230601_31%2F1685582585983RjWPq_PNG%2F2989668_image2_1.png">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=창원진동미더덕축제">
					<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA0MThfOTgg%2FMDAxNjUwMjgzNTQxNzkx.LAplSiHwM91uvdfJyI4KmlzIHxJKKg3_VUottKfnYCEg.CL-otK3gad68o30yBqlo8r4iFy93mppVTx1crCLJjrgg.JPEG.tbsktnnews%2F%25C3%25A2%25BF%25F8%25C6%25AF%25B7%25CA%25BD%25C3%252B%25A1%25B0%25C3%25A2%25BF%25F8%25C1%25F8%25B5%25BF%25B9%25CC%25B4%25F5%25B4%25F6%25C3%25E0%25C1%25A6%252B21_22%25C0%25CF%252B%25BF%25C2%25B6%25F3%25C0%25CE%252B%25B0%25B3%25C3%25D6%25A1%25B1%252B%25281%2529.jpg&type=a340">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=서천 자연산 광어 도미 축제">
					<img src="https://search.pstatic.net/common?type=b&size=672&quality=95&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230420_113%2F16819655566923dr6K_JPEG%2F2978106_image2_1.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=몽산포항 주꾸미축제">
					<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA0MTJfMTE4%2FMDAxNTIzNDk4MTM0Mzcz.vPnAK14OE0LNbC9McRHgOxB3KTZp8uWd2tA6JYHSZO0g.gwSHwq-h8pC66qmBZjQggMkzGtsgO6PmzlPhfyG_J_Ig.PNG.daimalu9204%2FCapture%252B_2018-04-12-10-23-23.png&type=ff332_332">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=횡성한우축제">
					<img src="https://search.pstatic.net/common?type=n&size=174x250&quality=85&direct=true&src=https%3A%2F%2Fcsearch-phinf.pstatic.net%2F20230822_184%2F1692694451832IEd01_JPEG%2F110_1907981_manual_image_url_1692694451709.jpg">
				</a>
			</div>
			<div class="swiper-slide">
				<a href="http://localhost:8080/Festival/FestivalSearch.jsp?keyword=짬뽕페스티벌">
					<img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fimgnews.pstatic.net%2Fimage%2Forigin%2F5664%2F2023%2F10%2F04%2F8224.jpg&type=ofullfill264_180_gray&expire=2&refresh=true">
				</a>
			</div>
		</div>

		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div>
		<!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div>
		<!-- 이전 버튼 -->

		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
	<br/><br/><br/>
	<!-- 슬라이드 끝 -->
	
	<!-- 이미지 슬라이드 JS 시작 -->
	<script>	
		new Swiper('.swiper-container', {

			slidesPerView : 3, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 30, // 슬라이드간 간격
			slidesPerGroup : 3, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

			// 그룹수가 맞지 않을 경우 빈칸으로 메우기
			// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
			loopFillGroupWithBlank : true,

			loop : true, // 무한 반복

			pagination : { // 페이징
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			navigation : { // 네비게이션
				nextEl : '.swiper-button-next', // 다음 버튼 클래스명
				prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
			},
		});
	</script>
	<!-- 이미지 슬라이드 JS 끝 -->
	
	<script>
		$(document).ready(function($) {
			$(".scroll_move").click(function(event) {
				console.log(".scroll_move");
				event.preventDefault();
				$('html,body').animate({
					scrollTop : $(this.hash).offset().top
				}, 500);
			});

		});
	</script>
	
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
