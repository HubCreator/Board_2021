<!-- 2. 게시글작성화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="board_error.jsp" import="java.util.*, java.text.*"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<jsp:useBean id="current_user" scope="session" class="jhs_web.User"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성화면</title>
<link rel="stylesheet" href="board.css" type="text/css" media="screen" />
</head>
<body>

<div align="center">
<H2>게시글 작성화면 </H2>
<HR>
[<a href=board_control.jsp?action=list>게시글 목록으로</a>] <P>
<form name="form1" method="POST" action="board_control.jsp">
<input type="hidden" name="action" value="insert">
<input type="hidden" name="board_user_identification" value="<%=current_user.getUs_identification() %>"/>
<input type="hidden" name="board_author" value="<%=current_user.getUs_name() %>" />
<table id="table_form" border="1">
	<tr>
    	<th>제목</th>	
    	<td><input type="text" name="board_title" maxlength="30"/></td>
  	</tr>
  	<!-- <tr>
		<th>작성자</th>
		<td><input type="text" name="board_author" maxlength="10"/></td>
  	</tr> -->
  	<!-- <tr>
    	<th>작성일(수정예정)</th>
    	<td><input type="text" name="board_date" /></td>
  	</tr> -->
  	<%
		Date date = new Date();
		SimpleDateFormat DateFor = new SimpleDateFormat("yyyy년 MM월 dd일   (hh시 mm분 ss초)");
		String stringDate= DateFor.format(date);
		
		out.println("<input type='hidden' name='board_date' value='"+stringDate+"'/>");
	%>
  	<tr>
    	<th>글 작성하기</th>
    	<td><textarea rows=20 cols=15 maxlength="200" name="board_content" style="overflow:scroll"></textarea></td>
  	</tr>
  	<tr>
    	<td colspan=2 align="center"><input type="submit" value="저장"/><input type="reset" value="취소"/></td>
	</tr>
</table>
</form>

</div>
</body>
</html>