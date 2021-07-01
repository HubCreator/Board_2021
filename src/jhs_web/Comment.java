package jhs_web;

public class Comment {

	private int comment_id;
	private int comment_from;
	private String comment_contents;
	private String comment_date;
	private String comment_author;
	
	
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	
	public int getComment_from() {
		return comment_from;
	}
	public void setComment_from(int comment_from) {
		this.comment_from = comment_from;
	}
	
	public String getComment_contents() {
		return comment_contents;
	}
	public void setComment_contents(String comment_contents) {
		this.comment_contents = comment_contents;
	}
	
	public String getComment_author() {
		return comment_author;
	}
	public void setComment_author(String comment_author) {
		this.comment_author = comment_author;
	}
	
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	
	
}