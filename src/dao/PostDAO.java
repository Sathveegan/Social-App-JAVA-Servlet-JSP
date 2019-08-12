package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Post;
import util.DBConnection;

public class PostDAO {

	public void insertPost(int user_id, String body) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("INSERT INTO post(user_id, body) VALUES (?,?);");
		st.setInt(1, user_id);
		st.setString(2, body);
		st.executeUpdate();
	}
	
	public ArrayList<Post> getAllPost() throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM post ORDER BY post_time DESC;");
		ResultSet rs = st.executeQuery();
		ArrayList<Post> array = new ArrayList<>();
		while(rs.next()) {
			Post p = new Post();
			p.setPost_id(rs.getInt("post_id"));
			p.setUser_id(rs.getInt("user_id"));
			p.setBody(rs.getString("body"));
			p.setPost_time(rs.getString("post_time"));
			array.add(p);
		}
		return array; 
	}
	
	public ArrayList<Post> getUserPost(int user_id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM post WHERE user_id = ? ORDER BY post_time DESC;");
		st.setInt(1, user_id);
		ResultSet rs = st.executeQuery();
		ArrayList<Post> array = new ArrayList<>();
		while(rs.next()) {
			Post p = new Post();
			p.setPost_id(rs.getInt("post_id"));
			p.setUser_id(rs.getInt("user_id"));
			p.setBody(rs.getString("body"));
			p.setPost_time(rs.getString("post_time"));
			array.add(p);
		}
		return array; 
	}
	
	public void deletePost(int post_id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("DELETE FROM post WHERE post_id = ?;");
		st.setInt(1, post_id);
		st.executeUpdate();
	}
	
	public Post getPost(int post_id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM post WHERE post_id = ?;");
		st.setInt(1, post_id);
		ResultSet rs = st.executeQuery();
		Post p = new Post();
		if(rs.next()) {
			p.setPost_id(rs.getInt("post_id"));
			p.setUser_id(rs.getInt("user_id"));
			p.setBody(rs.getString("body"));
			p.setPost_time(rs.getString("post_time"));
		}
		return p; 
	}
	
	public String updatePost(Post post) {
		try {
			Connection conn = DBConnection.getInstance().getConnection();
			PreparedStatement st = conn.prepareStatement("UPDATE post SET body = ? WHERE post_id = ?;");
			st.setString(1, post.getBody());
			st.setInt(2, post.getPost_id());
			st.execute();
			return "Post Update Successful.";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Post Update Failed.";
		}
	}
}
