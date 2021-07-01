<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="jhs_web.*, java.util.*"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="current_user" scope="session" class="jhs_web.User"/>
<jsp:useBean id="board" scope="request" class="jhs_web.Board" />
<jsp:useBean id="comments" scope="request" class="java.util.ArrayList" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<%
		
		for(Comment comment : (ArrayList<Comment>)comments) {
	%>
		<tr>
			<td><%=comment.getComment_id() %></td>
			<td><%=comment.getComment_author() %></td>
			<td><%=comment.getComment_date() %></td>
			<td><%=comment.getComment_contents() %></td>
		</tr>
			 <%
				}
			 %>
</table>
</body>
</html>