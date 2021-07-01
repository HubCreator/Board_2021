<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function signUpCheck() {
		var pass1 = document.getElementsByTagName("input")[1].value;
		var pass2 = document.getElementsByTagName("input")[2].value;
		
		if (pass1.equals(pass2)) {
			document.form2.submit();
		}
		else {
			alert("password를 다시 입력하십시오.");
			return;
		}
		
	}
</script>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<div align="center">
<h4>회원가입 화면입니다.</h4>
<hr>
<form name="form2" action="login_control.jsp" method="post">
<input type=hidden name="action" value="signUp">
<table border="1">
<tr>
	<td>이름</td><td><input type="text" name="us_name"/></td>
</tr>
<tr>
	<td>아이디</td><td><input type="text" name="us_identification"></td>
</tr>
<tr>
	<td>비밀번호1</td><td><input type="password" name="us_password"></td>
</tr>
<tr>
	<td>비밀번호2</td><td><input type="password" name="us_password2"></td>
	
</tr>
<tr>
	<td colspan="2" align="center"><input type="submit" value="가입하기"/></td>
</tr>
</table>
</form>

</div>
</body>
</html>