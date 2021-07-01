<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="jhs_web.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="boardBean" class="jhs_web.BoardBean"/> 
<jsp:useBean id="board" class="jhs_web.Board"/>
<jsp:useBean id="commentBean" class="jhs_web.CommentBean"/>
<jsp:useBean id="comment" class="jhs_web.Comment"/>

<jsp:setProperty name="comment" property="*"/>

<%
	String action = request.getParameter("action");


	if(action.equals("insert")) {
		if(commentBean.insertComment(comment)) {
			pageContext.forward("board_control.jsp?action=show&board_id="+comment.getComment_from());

		}
		else
			throw new Exception("DB 입력오류");
	}
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>