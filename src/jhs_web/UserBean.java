package jhs_web;

import java.sql.*;

public class UserBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=Asia/Seoul";
	//String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=Asia/Seoul&allowPublicKeyRetrieval=true";
	
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
	
	public boolean signUp(User user) {
		connect();
		
		String sql = "insert into users(us_name, us_identification, us_password) values(?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUs_name());
			pstmt.setString(2, user.getUs_identification());
			pstmt.setString(3, user.getUs_password());
			pstmt.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	public User signIn(User user) {
		connect();
				
		String sql = "select * from users where us_identification=? and us_password=?";
		User current_user = new User();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUs_identification());
			pstmt.setString(2, user.getUs_password());
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			current_user.setUs_name(rs.getString("us_name"));
			current_user.setUs_identification(rs.getString("us_identification"));
			current_user.setUs_password(rs.getString("us_password"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		finally {
			disconnect();
		}
		return current_user;
	}
	
	public User findUser(String username) {
		connect();
		
		String sql = "select * from users where us_name=?";
		User current_user = new User();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			current_user.setUs_name(rs.getString("us_name"));
			current_user.setUs_identification(rs.getString("us_identification"));
			current_user.setUs_password(rs.getString("us_password"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		finally {
			disconnect();
		}
		return current_user;
	}
	
	public boolean changePW(String identification, String password) {
		connect();
		
		String sql = "update users set us_password=? where us_identification=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, identification);
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
	
	public boolean deleteAccount(String user) {
		connect();
		
		String sql = "update users set us_name=?, us_password=? where us_name=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "unknown");
			pstmt.setString(2, "unknown");
			pstmt.setString(3, user);
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
	
}
