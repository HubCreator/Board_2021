<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="board_error.jsp" import="java.util.*, jhs_web.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="board.css" type="text/css" media="screen" />
<script type="text/javascript">
	function check(board_id) {
		//pwd = prompt('수정/삭제 하려면 비밀번호를 넣으세요');
		//document.location.href="addrbook_control.jsp?action=edit&ab_id="+ab_id+"&upasswd="+pwd;
		document.location.href="board_control.jsp?action=show_fromMypage&board_id="+board_id;
	}
	
	function changePW(username) {
		document.location.href="login_control.jsp?action=changePW&us_name="+username;
	}
	
	function deleteAccount(username) {
		var res = confirm("정말로 회원탈퇴를 하시겠습니까?!");
		if(res == true)
			document.location.href="login_control.jsp?action=deleteAccount&us_name="+username;
		else
			return;
	}
</script>
<meta charset="UTF-8">
<title>내가 쓴 글들</title>
</head>
<jsp:useBean id="datas" scope="request" class="java.util.ArrayList" /> <!-- getAttribute()? -->
<jsp:useBean id="current_user" scope="session" class="jhs_web.User"/>

<body>
<br>
<div align="center">
<H2>마이페이지</H2>
<div align="right">
	<%=current_user.getUs_name() %>님의 화면정보입니다.
</div>
<input type="button" value="비밀번호 변경" onClick="changePW('<%=current_user.getUs_name() %>')" style="width:100px"/>
<input type="button" value="회원 탈퇴" onClick="deleteAccount('<%=current_user.getUs_name() %>')"/>
<HR>
[<a href=board_control.jsp?action=list>게시글 목록으로</a>] <p>
<table border="1">
 <tr><th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>조회수</th></tr>
<%
	ArrayList<Board> myContent = (ArrayList<Board>)request.getAttribute("myContent");
	// out.println(myContent);
%>
  
<%
	
	for(Board board : (ArrayList<Board>) myContent) {
%>
		<tr>
			<td><%=board.getBoard_id() %></td>
			<td><a href="javascript:check(<%=board.getBoard_id() %>)"><%=board.getBoard_title() %></a></td>
			<td><%=board.getBoard_author() %></td>
			<td><%=board.getBoard_date() %></td>
			<td><%=board.getBoard_views() %></td>
		</tr>
 <%
	}
 %>
</table>
</div>
</body>
</html>