<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="board_error.jsp" import="jhs_web.*"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="board.css" type="text/css" media="screen" />

<script type="text/javascript">
	function delcheck() {
		result = confirm("정말로 삭제하시겠습니까 ?");
	
		if(result == true){
			document.form1.action.value="delete";
			document.form1.submit();
		}
		else
			return;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정 화면</title>
</head>

<jsp:useBean id="board" scope="request" class="jhs_web.Board" />

<body>
<div align="center">
<H2>주소록:수정화면 </H2>
<HR>
[<a href=board_control.jsp?action=list>게시글로 돌아가기</a>] <p>
<form name="form1" method="post" action="board_control.jsp">
<input type="hidden" name="action" value="update">
<input type="hidden" name="board_id" value="<%=board.getBoard_id()%>"> <!-- 이 부분은 DBMS에서 자동으로 부여하는 것이 아닌 기존에 있던 id를 지정 -->
<input type="hidden" name="board_author" value="<%=board.getBoard_author() %>">
<input type="hidden" name="board_date" value="<%=board.getBoard_date() %>">

<table border="1">
	<tr>
    	<th>제목</th>	
    	<td><input type="text" name="board_title" value="<%=board.getBoard_title() %>"></td>
  	</tr>
  	<%-- <tr>
		<th>작성자</th>
		<td><input type="text" name="board_author" value="<%=board.getBoard_author() %>"></td>
  	</tr> --%>
  <%-- 	<tr>
    	<th>작성일(수정예정)</th>
    	<td><input type="text" name="board_date" value="<%=board.getBoard_date() %>"></td>
  	</tr> --%>
  	<tr>
    	<th>글 작성하기</th>
    	<td><input type="text" name="board_content" value="<%=board.getBoard_content() %>"></td>
  	</tr>
  <tr>
    <td colspan=2 align="center"><input type="submit" value="저장"><input type="reset" value="취소">
     <input type="button" value="삭제" onClick="delcheck()"></td>
</tr>
</table>
</form>

</div>
</body>
</html>