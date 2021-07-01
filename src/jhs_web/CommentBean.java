package jhs_web;

import java.sql.*;
import java.util.*;

public class CommentBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=Asia/Seoul"; 
	
	// DB연결 메서드
		void connect() {
			try {
				Class.forName(jdbc_driver);

				conn = DriverManager.getConnection(jdbc_url,"***","*******");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		void disconnect() {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} 
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		public boolean insertComment(Comment comment) {
			connect();
			String sql ="insert into comments(comment_from,comment_contents,comment_date,comment_author) values(?,?,?,?)";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,comment.getComment_from());
				pstmt.setString(2,comment.getComment_contents());
				pstmt.setString(3,comment.getComment_date());
				pstmt.setString(4,comment.getComment_author());
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
			finally {
				disconnect();
			}
			return true;
		}
		
		public boolean deleteComments(int board_id) {
			connect();
			String sql ="delete from comments where comment_from=?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
			finally {
				disconnect();
			}
			return true;
		}
		
		public ArrayList<Comment> getCommentsList(int board_id) {
			connect();
			ArrayList<Comment> comments = new ArrayList<Comment>();
			
			String sql = "select comment_id, comment_from, comment_contents, comment_date, comment_author from comments, board where board.board_id=comments.comment_from and board.board_id= ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Comment comment = new Comment();
					
					comment.setComment_id(rs.getInt("comment_id"));
					comment.setComment_from(rs.getInt("comment_from"));
					comment.setComment_contents(rs.getString("comment_contents"));
					comment.setComment_date(rs.getString("comment_date"));
					comment.setComment_author(rs.getString("comment_author"));
					comments.add(comment);
				}
				rs.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
			finally {
				disconnect();
			}
			return comments;
		}
		
}

