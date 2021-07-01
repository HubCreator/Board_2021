<%@ page language="java" contentType="text/html; charset=utf-8"   
 pageEncoding="utf-8"   import="jhs_web.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="boardBean" class="jhs_web.BoardBean"/> 
<jsp:useBean id="board" class="jhs_web.Board"/>
<jsp:useBean id="userBean" class="jhs_web.UserBean"/>
<jsp:useBean id="user" class="jhs_web.User"/>
<jsp:useBean id="commentBean" class="jhs_web.CommentBean"/>
<jsp:useBean id="comment" class="jhs_web.Comment"/>

<jsp:setProperty name="board" property="*"/>

<jsp:useBean id="current_user" scope="session" class="jhs_web.User"/>


<% // 컨트롤러 요청 파라미터
	String action = request.getParameter("action");	// 파라미터에 따른 요청 처리 

	// 주소록 목록 요청인 경우
	if(action.equals("list")) {
		//request.removeAttribute("pageIndex");
		ArrayList<Board> datas = boardBean.getDBList();
		//session.setAttribute("datas", datas); // 왜 해주는걸까..?
		session.setAttribute("datas", datas); // 왜 해주는걸까..?
		request.setAttribute("pageIndex", 1);
        pageContext.forward("board_list.jsp");
	}	
	// 주소록 등록 요청인 경우
	else if(action.equals("insert")) {
		if(board.getBoard_content() == null )
			out.println("<script>alert('내용을 입력하세요!!');history.go(-1);</script>");
		else if( board.getBoard_title() == null)
			out.println("<script>alert('제목을 입력하세요!!');history.go(-1);</script>");
		else {
			if(boardBean.insertDB(board)) {
				response.sendRedirect("board_control.jsp?action=list");
			}
			else
				response.sendRedirect("board_control.jsp?action=list");
				//throw new Exception("DB 입력오류");	
		}
		
			
	}	
	else if(action.equals("show")) {
		Board show_board = boardBean.getDB(board.getBoard_id());
		ArrayList<Comment> comments = commentBean.getCommentsList(board.getBoard_id());
		
		if(comments != null && show_board != null) {
			boardBean.clickContent(show_board);
			request.setAttribute("comments", comments);
			request.setAttribute("board",show_board);
			
			pageContext.forward("board_show.jsp");
		}
		else 
			throw new Exception("게시글 불러오기 오류");
		
	}
	else if(action.equals("show_fromMypage")) {
		Board show_board = boardBean.getDB(board.getBoard_id());
		ArrayList<Comment> comments = commentBean.getCommentsList(board.getBoard_id());
		
		if(show_board != null) {
			boardBean.clickContent(show_board);
			request.setAttribute("comments", comments);
			request.setAttribute("board",show_board);
			
			pageContext.forward("board_show_fromMypage.jsp");
		}
		else 
			throw new Exception("마이페이지 게시글 불러오기 오류");
		
	}
	else if(action.equals("edit")) {
		Board edit_board = boardBean.getDB(board.getBoard_id());
		/* out.println("<script>alert("+ abook +");</script>"); */
		
		if(!edit_board.getBoard_user_identification().equals(current_user.getUs_identification())) {
			out.println("<script>alert('권한이 없습니다!!');history.go(-1);</script>");
		}
		else {
			request.setAttribute("board",edit_board);
			pageContext.forward("board_edit_form.jsp");
		}
	}	// 주소록 수정 등록 요청인 경우
	else if(action.equals("update")) {
		//out.println("<script>alert('"+ board.getBoard_id()+"');history.go(-1);</script>");
		if(boardBean.updateDB(board)) {
			pageContext.forward("board_control.jsp?action=show&board_id="+board.getBoard_id());
			// response.sendRedirect("board_control.jsp?action=list");
			
		}
		else
			throw new Exception("DB 갱신오류");
	}	
	// 주소록 삭제 요청인 경우
	/* else if(action.equals("delete")) {
		if(boardBean.deleteDB(board.getBoard_id())) {
			commentBean.deleteComments(board.getBoard_id());
			// response.sendRedirect("board_control.jsp?action=list");
			pageContext.forward("board_control.jsp?action=list");
		}
		else
			throw new Exception("DB 삭제 오류");
	} */
	else if(action.equals("delete")) {
		if(commentBean.deleteComments(board.getBoard_id())) {
			if(boardBean.deleteDB(board)) {
				// response.sendRedirect("board_control.jsp?action=list");
				pageContext.forward("board_control.jsp?action=list");
			}	
		}
		
		else if(commentBean.deleteComments(board.getBoard_id()) == false) {
			if(boardBean.deleteDB(board)) {
				// response.sendRedirect("board_control.jsp?action=list");
				pageContext.forward("board_control.jsp?action=list");
			}
		}

 		else
 			throw new Exception("DB 삭제 오류"); 
 			//pageContext.forward("board_control.jsp?action=list");	
	
	}
	else if(action.equals("mypage")) {
		ArrayList<Board> myContent = boardBean.getMyContent(current_user.getUs_identification());
		if(myContent != null) {
			request.setAttribute("myContent", myContent);
			pageContext.forward("board_mypage.jsp");
		}
		else
			throw new Exception("mypage 불러오기 오류");
	}
	
	else if(action.equals("find")) {
		String category = request.getParameter("category");
		String findSth = request.getParameter("findSth");
		
		ArrayList<Board> result = new ArrayList<Board>();
		
		if (category.equals("제목 검색")){
			//ArrayList<Board> datas = boardBean.getDBList();
			//session.getAttribute("datas");
			for(Board data : (ArrayList<Board>)session.getAttribute("datas")) {
				String a = data.getBoard_title();
				
				if(a.indexOf(findSth) != -1){
					result.add(data);
					//request.setAttribute("findData", data);
				}
			}
		}
		else {
			//ArrayList<Board> datas = boardBean.getDBList();
			for(Board data : (ArrayList<Board>)session.getAttribute("datas")) {
				String a = data.getBoard_content();
				
				if(a.indexOf(findSth) != -1){
					result.add(data);
					//request.setAttribute("findData", data);
					/* session.setAttribute("findData", data);
					pageContext.forward("board_list.jsp"); */
				}
			}
		}
		session.setAttribute("findData", result);
		pageContext.forward("board_control.jsp?action=list");
		//out.println("<script>history.go(-1);</script>");
	}
	
	
	
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>