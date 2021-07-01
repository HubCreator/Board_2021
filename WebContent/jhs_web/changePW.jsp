<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, jhs_web.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="userBean" class="jhs_web.UserBean"/>
<jsp:useBean id="user" class="jhs_web.User"/>
<!DOCTYPE html>
<% User a = (User)request.getAttribute("user"); %>
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
<h4>비밀번호 변경 화면입니다.</h4>
<hr>
<form name="form2" action="login_control.jsp" method="post">
<input type=hidden name="action" value="changePW_done">
<input type="hidden" name="us_name" value="<%=a.getUs_name() %>"/>
<input type="hidden" name="us_identification" value="<%=a.getUs_identification() %>"/>
<table border="1">
<tr>
	<td>이름</td><td><%=a.getUs_name() %></td>
</tr>
<tr>
	<td>아이디</td><td><%=a.getUs_identification() %></td>
</tr>
<tr>
	<td>변경할 비밀번호</td><td><input type="password" name="us_password"></td>
</tr>
<tr>
	<td>비밀번호 확인</td><td><input type="password" name="us_password2"></td>
	
</tr>
<tr>
	<td colspan="2" align="center"><input type="submit" value="변경하기"/></td>
</tr>
</table>
</form>

</div>
</body>
</html>