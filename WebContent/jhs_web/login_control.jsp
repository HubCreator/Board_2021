<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="jhs_web.*, java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="userBean" class="jhs_web.UserBean"/>
<jsp:useBean id="user" class="jhs_web.User"/>
<jsp:setProperty name="user" property="*"/>
<%
	String action = request.getParameter("action");	// 파라미터에 따른 요청 처리 
	
	if(action.equals("login")) {
		User tmp = new User();
		tmp = userBean.signIn(user);
		//out.println(tmp.getUs_identification());
		if(tmp != null) {
			session.setAttribute("current_user", tmp);
			response.sendRedirect("board_control.jsp?action=list");
			// pageContext.forward("addrbook_control.jsp?action=list");
		}
		else {
			out.println("<script>alert('아이디와 비밀번호를 다시 확인해주세요.!!');history.go(-1);</script>");
		}
	}
	else if(action.equals("signUp")) {
		User tmp = new User();
		if(!user.getUs_password().equals(user.getUs_password2())) {
			out.println("<script>alert('비밀번호를 다시 확인해주세요.!!');history.go(-1);</script>");
		}
		else {
			if(userBean.signUp(user)) {
				tmp = userBean.signIn(user);
				session.setAttribute("current_user", tmp);
				response.sendRedirect("board_control.jsp?action=list");
			}
		}
	}
	else if(action.equals("logOut")) {
		session.invalidate(); 
		response.sendRedirect("login.jsp");
	}
	
	else if(action.equals("changePW")) {
		User tmp = new User();
		tmp = userBean.findUser(user.getUs_name());
		request.setAttribute("user", tmp);
		pageContext.forward("changePW.jsp");
	}
	
	else if(action.equals("changePW_done")) {
		User tmp = new User();
		if(!user.getUs_password().equals(user.getUs_password2())) {
			out.println("<script>alert('비밀번호를 다시 확인해주세요.!!');history.go(-1);</script>");
		}
		else {
			//out.println("<script>alert('"+ user.getUs_identification() +"');</script>");
			if(userBean.changePW(user.getUs_identification(), user.getUs_password())) {
				out.println("<script>alert('변경이 완료되었습니다!!');</script>");
				//tmp = userBean.signIn(user);
				//session.setAttribute("current_user", tmp);
				pageContext.forward("board_control.jsp?action=list");
			}
		}
	}
	else if(action.equals("deleteAccount")) {
		if(userBean.deleteAccount(user.getUs_name())) {
			//session.invalidate();
			//pageContext.forward("login.jsp");
			response.sendRedirect("login_control.jsp?action=logOut");
		}
		else {
			out.println("<script>alert('다시 확인해주세요.!!');history.go(-1);</script>");
		}
	}
	
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}

%>