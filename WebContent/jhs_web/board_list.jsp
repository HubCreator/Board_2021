<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" 
 import="java.util.*, jhs_web.*"%>

<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="board.css" type="text/css" media="screen" />
<script type="text/javascript">
	function check(board_id) {
		document.location.href="board_control.jsp?action=show&board_id="+board_id;
	}
	
	function logOut() {
		result = confirm("정말로 로그아웃 하시겠습니까?");
		if(result == true){
			document.form1.submit();
		}
		else
			return;
	}
	
	function mypage() {
		document.location.href="board_control.jsp?action=mypage";
	}
	
	function previousPage(pageIndex) {
		var a = parseInt(pageIndex)-1;
		
		if(a == 0)  return;
		else {
			document.location.href="board_list.jsp?pageIndex="+a;
			//request.setAttribute("board", board);
		}
	}
	
	function nextPage(listSize, pageIndex) {
		var a = parseInt(pageIndex)+1;
		
		if(a < parseInt(listSize)/10 + 1) {
			document.location.href="board_list.jsp?pageIndex="+a;
			//request.setAttribute("board", board);
		}
		else return;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
</head>
<jsp:useBean id="datas" scope="request" class="java.util.ArrayList" /> <!-- getAttribute()? -->
<jsp:useBean id="current_user" scope="session" class="jhs_web.User"/>
<body><div align="center"> 
<H2>게시판 화면</H2>
<HR>
<form name="form1" method="post" action="login_control.jsp">
<input type="hidden" name="action" value="logOut"/>
<div align="right">
<a href='javascript:mypage()'><%=current_user.getUs_name() %></a> 님이 로그인 한 상태입니다.
<input type="submit" value="로그아웃" onClick="logOut()"/>
</div>
</form>

<form name="form2" method="post" action="board_form.jsp">
<br><br>
<table border="1">
	<tr><th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>조회수</th></tr>
	<%
		int pageIndex;
		try {
			pageIndex = Integer.parseInt(request.getAttribute("pageIndex").toString());
		}
		catch(Exception exception){
			/* if (!empty(request.getParameter("pageIndex").toString()))
				pageIndex = Integer.parseInt(request.getParameter("pageIndex").toString());
			else pageIndex = 1; */
			pageIndex = Integer.parseInt(request.getParameter("pageIndex").toString());
		}
		/* catch(Exception exception){
			pageIndex = 1;
		} */
		
		ArrayList<Board> board = (ArrayList<Board>)session.getAttribute("datas");
		//ArrayList<Board> board = (ArrayList<Board>)request.getAttribute("board");
		
		try {
			for(int i = 10*(pageIndex-1); i < 10*pageIndex; i++) {
				
			if (board.get(i) == null) return;
	%>
		<tr>
			<td><%=board.get(i).getBoard_id() %></td>
			<td><a href="javascript:check(<%=board.get(i).getBoard_id() %>)"><%=board.get(i).getBoard_title() %></a></td>
			<td><%=board.get(i).getBoard_author() %></td>
			<td><%=board.get(i).getBoard_date() %></td>
			<td><%=board.get(i).getBoard_views() %></td>
		</tr>
	<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		/* finally {
			request.setAttribute("listSize", board.size());
		} */
	%>
</table>

<br><br>
<input type="button" value="◀" onClick="previousPage('<%=pageIndex%>')" />  <input type="button" value="▶" onClick="nextPage('<%=board.size() %>', '<%=pageIndex %>')" />  
<%-- <input type="button" value="이전" onClick="previousPage('<%=pageIndex%>', <%=board %>)" />  <input type="button" value="이후" onClick="nextPage('<%=board.size() %>', '<%=pageIndex %>', <%=board %>)" /> --%>
<div align="right"><input type="submit" value="글쓰기"/></div>
<br>
</form>
<div style="background-color: rgb(191, 214, 255);">
<br>
<form name="form3" method="POST" action="board_control.jsp?action=find">
	<select name="category">
		<option selected>제목 검색</option>
		<option>내용 검색</option>
	</select>
	<input type="text" name="findSth" style="width:45%;height:20px;font-size:45;"/>
	<input type="submit" value="찾기" />
</form>
<table border="1">
		<tr><th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>조회수</th></tr>
<%
	try{
		ArrayList<Board> findData = (ArrayList<Board>)session.getAttribute("findData");
		out.println("<h3>검색 결과</h3>");
		for(Board result : findData) {
%>
	
		<tr>
			<td><%=result.getBoard_id() %></td>
			<td><a href="javascript:check(<%=result.getBoard_id() %>)"><%=result.getBoard_title() %></a></td>
			<td><%=result.getBoard_author() %></td>
			<td><%=result.getBoard_date() %></td>
			<td><%=result.getBoard_views() %></td>
		</tr>
<%
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	finally{
		//session.removeAttribute("findData");
	}
%>
</table>
<br>
</div>
</div>
<br><br>
</body>
</html>