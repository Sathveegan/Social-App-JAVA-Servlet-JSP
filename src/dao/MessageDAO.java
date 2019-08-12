package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Message;
import util.DBConnection;

public class MessageDAO {
	
	public ArrayList<Message> getAllMessage(int id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM message WHERE from_user = ? AND chat_time IN (SELECT MAX(chat_time) FROM message GROUP by to_user) ORDER BY chat_time DESC;");
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		ArrayList<Message> array = new ArrayList<>();
		while(rs.next()) {
			Message c = new Message();
			c.setChat_id(rs.getInt("chat_id"));
			c.setFrom_user(rs.getString("from_user"));
			c.setTo_user(rs.getString("to_user"));
			c.setMessage(rs.getString("message"));
			c.setChat_time(rs.getString("chat_time"));
			array.add(c);
		}
		return array; 
	}
	
	public void deleteAllMessage(int fromUserID, int toUserID) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("DELETE FROM message WHERE (from_user = ? AND to_user = ?) OR (to_user = ? AND from_user = ?);");
		st.setInt(1, fromUserID);
		st.setInt(2, toUserID);
		st.setInt(3, fromUserID);
		st.setInt(4, toUserID);
		st.executeUpdate();
	}
	
	public ArrayList<Message> getMessage(int fromUserID, int toUserID) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM message WHERE (from_user = ? OR to_user = ?) AND (from_user = ? OR to_user = ?) ORDER BY chat_time;");
		st.setInt(1, fromUserID);
		st.setInt(2, fromUserID);
		st.setInt(3, toUserID);
		st.setInt(4, toUserID);
		ResultSet rs = st.executeQuery();
		ArrayList<Message> array = new ArrayList<>();
		while(rs.next()) {
			Message c = new Message();
			c.setChat_id(rs.getInt("chat_id"));
			c.setFrom_user(rs.getString("from_user"));
			c.setTo_user(rs.getString("to_user"));
			c.setMessage(rs.getString("message"));
			c.setChat_time(rs.getString("chat_time"));
			array.add(c);
		}
		return array; 
	} 
	
	public void insertMessage(int fromUserID, int toUserID, String message) throws SQLException{
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("INSERT INTO message(from_user, to_user, message) VALUES (?,?,?);");
		st.setInt(1, fromUserID);
		st.setInt(2, toUserID);
		st.setString(3, message);
		st.executeUpdate();
	}
	
	public void deleteMessage(int chatID) throws SQLException{
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("DELETE FROM message WHERE chat_id = ?;");
		st.setInt(1, chatID);
		st.executeUpdate();
	}
	
	public int messageCount(int from_user, int to_user) throws SQLException {
		int count = 0;
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT COUNT(*) msg_count FROM message WHERE (from_user = ? OR to_user = ?) AND (from_user = ? OR to_user = ?);");
		st.setInt(1, from_user);
		st.setInt(2, from_user);
		st.setInt(3, to_user);
		st.setInt(4, to_user);
		ResultSet rs = st.executeQuery();
		while(rs.next())
			count = rs.getInt("msg_count");
		
		return count;
	}
	
}
