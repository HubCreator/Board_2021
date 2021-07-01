<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="board_error.jsp" import="jhs_web.*, java.util.*, java.text.*"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="board.css" type="text/css" media="screen" />

<script type="text/javascript">
	function delCheck(board_id) {
		result = confirm("정말로 삭제하시겠습니까 ?");
	
		if(result == true){
			document.location.href="board_control.jsp?action=delete&board_id="+board_id;
		}
		else
			return;
	}
	
	function updateCheck(board_id) {
		document.location.href="board_control.jsp?action=edit&board_id="+board_id;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글</title>
</head>

<jsp:useBean id="current_user" scope="session" class="jhs_web.User"/>
<jsp:useBean id="board" scope="request" class="jhs_web.Board" />
<%-- <jsp:useBean id="contents" scope="request" class="java.util.ArrayList" /> --%>


<body>
<div align="center">
<H2>게시글 </H2>
<HR>
[<a href=board_control.jsp?action=mypage>게시글 목록으로</a>] <p>
<form name="form1" method="post" action="board_control.jsp">
<input type="hidden" name="board_id" value="<%=board.getBoard_id()%>">

<table border="1">
	<tr>
    	<th>제목</th>	
    	<td><%=board.getBoard_title() %></td>
  	</tr>
  	<%-- <tr>
		<th>작성자</th>
		<td><%=board.getBoard_author() %></td>
  	</tr> --%>
  	<tr>
    	<th>작성일</th>
    	<td><%=board.getBoard_date() %></td>
  	</tr>
  	<tr>
    	<th>내용</th>
    	<td><%=board.getBoard_content() %></td>
  	</tr>
</table>
<br><br><br>
<%
	if(board.getBoard_user_identification().equals(current_user.getUs_identification())) {
		out.println("<input type='button' value='수정' onClick='updateCheck("+board.getBoard_id()+")'/>");
		out.println("<input type='button' value='삭제' onClick='delCheck("+board.getBoard_id()+")'/>");
	}
%>

</form>
<br>
<table>
<tr><th>작성자</th><th>시간</th><th>내용</th></tr>
<%
		ArrayList<Comment> comments = (ArrayList<Comment>)request.getAttribute("comments");
		
		for(Comment comment : (ArrayList<Comment>) comments) {
%>
		 <tr>
			<td><%=comment.getComment_author() %></td>
			<td><%=comment.getComment_date() %></td>
			<td><%=comment.getComment_contents() %></td>
		</tr>
<%
			}
%>
</table>

</div>
</body>
</html>