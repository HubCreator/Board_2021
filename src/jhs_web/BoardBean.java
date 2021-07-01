﻿package jhs_web;

import java.sql.*;
import java.util.*;


public class BoardBean { 
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=Asia/Seoul"; 
	//String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=Asia/Seoul&allowPublicKeyRetrieval=true"; 
	
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
	
	public boolean clickContent(Board board) {
		connect();
		
		String sql ="update board set board_views=? where board_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,board.getBoard_views()+1);
			pstmt.setInt(2,board.getBoard_id());
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
	
	
	// 수정된 주소록 내용 갱신을 위한 메서드
	public boolean updateDB(Board board) {
		connect();
		
		String sql ="update board set board_title=?, board_author=?, board_content=? where board_id=?";		
		 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,board.getBoard_title());
			pstmt.setString(2,board.getBoard_author());
			pstmt.setString(3,board.getBoard_content());
			pstmt.setInt(4,board.getBoard_id());
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
	
	// 특정 주소록 게시글 삭제 메서드
	public boolean deleteDB(Board board) {
		connect();
		
		String sql ="delete from board where board_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,board.getBoard_id());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			//return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	// 신규 주소록 메시지 추가 메서드
	public boolean insertDB(Board board) {
		connect();
		// gb_id 는 자동 등록 되므로 입력하지 않는다.
				
		String sql ="insert into board(board_title,board_author,board_date,board_views,board_user_identification,board_content) values(?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,board.getBoard_title());
			pstmt.setString(2,board.getBoard_author());
			pstmt.setString(3,board.getBoard_date());
			pstmt.setInt(4,board.getBoard_views());
			pstmt.setString(5, board.getBoard_user_identification());
			pstmt.setString(6,board.getBoard_content());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			//return false;
		}
		finally {
			disconnect();
		}
		return true;
	}

	// 특정 주소록 게시글 가져오는 메서드
	public Board getDB(int gb_id) {
		connect();
		
		String sql = "select * from board where board_id=?";
		Board board = new Board();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,gb_id);
			ResultSet rs = pstmt.executeQuery();
			
			// 데이터가 하나만 있으므로 rs.next()를 한번만 실행 한다.
			rs.next();
			board.setBoard_id(rs.getInt("board_id"));
			board.setBoard_title(rs.getString("board_title"));
			board.setBoard_author(rs.getString("board_author"));
			board.setBoard_date(rs.getString("board_date"));
			board.setBoard_views(rs.getInt("board_views"));
			board.setBoard_user_identification(rs.getString("board_user_identification"));
			board.setBoard_content(rs.getString("board_content"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return board;
	}
	
	// 전체 주소록 목록을 가져오는 메서드
	public ArrayList<Board> getDBList() {
		connect();
		ArrayList<Board> datas = new ArrayList<Board>();
		
		String sql = "select * from board order by board_id desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				
				board.setBoard_id(rs.getInt("board_id"));
				board.setBoard_title(rs.getString("board_title"));
				board.setBoard_author(rs.getString("board_author"));
				board.setBoard_date(rs.getString("board_date"));
				board.setBoard_views(rs.getInt("board_views"));
				board.setBoard_user_identification(rs.getString("board_user_identification"));
				board.setBoard_content(rs.getString("board_content"));
				datas.add(board);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return datas;
	}
	
	public ArrayList<Board> getMyContent(String userid) {
		connect();
		ArrayList<Board> myContent = new ArrayList<Board>();
		String sql = "select * from board where board_user_identification = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				
				board.setBoard_id(rs.getInt("board_id"));
				board.setBoard_title(rs.getString("board_title"));
				board.setBoard_author(rs.getString("board_author"));
				board.setBoard_date(rs.getString("board_date"));
				board.setBoard_views(rs.getInt("board_views"));
				board.setBoard_user_identification(rs.getString("board_user_identification"));
				board.setBoard_content(rs.getString("board_content"));
				myContent.add(board);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return myContent;
	}
}