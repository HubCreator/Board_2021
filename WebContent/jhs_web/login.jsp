<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
</head>
<body>
<div align="center">
<h3>로그인 화면</h3>
<hr>
<br><br><br>
<form action="login_control.jsp" method="post">
<input type=hidden name="action" value="login">
<table border="1">
<tr>
	<td>아이디</td><td><input type="text" name="us_identification"></td><td rowspan="2"><input type="submit" value="로그인"/></td>
</tr>
<tr>
	<td>패스워드</td><td><input type="password" name="us_password"></td>
</tr>
</table>
</form>
<br>
<a href="sign_up.jsp">회원가입하기</a> <br>
<!-- <a href="find_password.jsp">비밀번호 찾기</a> / <a href="find_identification.jsp">아이디 찾기</a> -->
</div>
</body>
</html>