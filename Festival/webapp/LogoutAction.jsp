<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
	<%
		session.invalidate(); // 접속한 회원의 세션을 빼앗음
	%>

	<script>
		// 메인폼으로 이동
		location.href = 'Main.jsp';
	</script>
</body>
</html>