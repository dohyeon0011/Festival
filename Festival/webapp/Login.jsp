<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>축제모아 - 로그인</title>
	<link href="css/LoginForm.css" type="text/css" rel="stylesheet">
	<!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<!-- Google fonts(기본 폰트, 구글 폰트 라이브러리 제공) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<!-- Google JQuery CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<h1>
		<a href="Main.jsp">축제모아 바로가기</a>
	</h1>
	<div class="container" id="container">
		<div class="form-container sign-up-container">
			<form action="JoinAction.jsp">
				<h1>회원가입</h1>
				<span>빠르고 쉽게 가입해보세요!</span>
				<input type="text" placeholder="아이디" name="userID" required />
				<input type="password" placeholder="비밀번호" name="userPassword" required />
				<input type="text" placeholder="이름" name="userName" required />
				<input type="email" placeholder="이메일 주소" name="userEmail" required />
				<button>가입하기</button>
			</form>
		</div>
		<div class="form-container sign-in-container">
			<form action="LoginAction.jsp">
				<h1>로그인</h1>
				<span>or use your account</span>
				<input type="text" placeholder="아이디" name="userID" required />
				<input type="password" placeholder="비밀번호" name="userPassword" required />
				<button>로그인하기</button>
			</form>
		</div>
		<div class="overlay-container">
			<div class="overlay">
				<div class="overlay-panel overlay-left">
					<h1>이미 회원이신가요?</h1>
					<p>전국에 많고 다양한 축제들이 준비되어</br> 
					있습니다. 저희와 함께 즐겨요!</p>
					<button class="ghost" id="signIn">로그인하기</button>
				</div>
			<div class="overlay-panel overlay-right">
				<h1>처음 이용하시나요?</h1>
				<p>간단한 회원가입으로 이용해보세요!</p>
		        <button class="ghost" id="signUp">가입하기</button>
			</div>
			</div>
		</div>
	</div>	
	
	<script>
		const signUpButton = document.getElementById('signUp');
		const signInButton = document.getElementById('signIn');
		const container = document.getElementById('container');
	
		signUpButton.addEventListener('click', () => {
			container.classList.add("right-panel-active");
		});
	
		signInButton.addEventListener('click', () => {
			container.classList.remove("right-panel-active");
		});
	</script>
</body>
</html>
