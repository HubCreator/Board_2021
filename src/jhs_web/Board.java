package jhs_web;

public class Board {
	// 멤버변수 선언
	private int board_id;
	private String board_title;
	private String board_author;
	private String board_date;
	private int board_views;
	private String board_user_identification;
	private String board_content;
	
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_author() {
		return board_author;
	}
	public void setBoard_author(String board_author) {
		this.board_author = board_author;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public int getBoard_views() {
		return board_views;
	}
	public void setBoard_views(int board_views) {
		this.board_views = board_views;
	}
	public String getBoard_user_identification() {
		return board_user_identification;
	}
	public void setBoard_user_identification(String board_user_identification) {
		this.board_user_identification = board_user_identification;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	
}
