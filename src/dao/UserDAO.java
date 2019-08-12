package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;

import model.User;
import util.DBConnection;

public class UserDAO {
	
	public boolean login(String email, String password) {
		boolean result = false;
		try {
			Connection conn = DBConnection.getInstance().getConnection();
			PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
			st.setString(1, email);
			st.setString(2, password);
			ResultSet rs = st.executeQuery();
			
			if(rs.next()) {
	            if(rs.getString("email").equals(email) && rs.getString("password").equals(password)) {
	            	result = true;
	            }
	        }
		} catch (SQLException e) {
			result = false;
		}
		return result;
		
	}
	
	public String register(User user) {
		try {
			Connection conn = DBConnection.getInstance().getConnection();
			PreparedStatement st = conn.prepareStatement("INSERT INTO user(first_name, last_name, email, password) VALUES (?, ?, ?, ?);");
			st.setString(1, user.getFirst_name());
			st.setString(2, user.getLast_name());
			st.setString(3, user.getEmail());
			st.setString(4, user.getPassword());
			st.execute();
			return "Registration Successful.";
		} catch (MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			return "Email alreay used.";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Registration Failed.";
		}
	}

	public ArrayList<User> getUsersForChat(int id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE user_id <> ?");
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		ArrayList<User> array = new ArrayList<>();
		while(rs.next()) {
			User u = new User();
			u.setUser_id(rs.getInt("user_id"));
			u.setFirst_name(rs.getString("first_name"));
			u.setLast_name(rs.getString("last_name"));
			u.setPassword(rs.getString("password"));
			u.setEmail(rs.getString("email"));
			u.setImage(rs.getString("image"));
			array.add(u);
		}
		return array; 
	}
	
	public User getUserById(int id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE user_id = ?");
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		User u = new User();
		if(rs.next()) {
			u.setUser_id(rs.getInt("user_id"));
			u.setFirst_name(rs.getString("first_name"));
			u.setLast_name(rs.getString("last_name"));
			u.setPassword(rs.getString("password"));
			u.setEmail(rs.getString("email"));
			u.setImage(rs.getString("image"));
		}
		return u;
	}
	
	public User getUserByEmail(String email) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE email = ?");
		st.setString(1, email);
		ResultSet rs = st.executeQuery();
		User u = new User();
		if(rs.next()) {
			u.setUser_id(rs.getInt("user_id"));
			u.setFirst_name(rs.getString("first_name"));
			u.setLast_name(rs.getString("last_name"));
			u.setPassword(rs.getString("password"));
			u.setEmail(rs.getString("email"));
			u.setImage(rs.getString("image"));
		}
		return u;
	}
	
	public void deleteUser(int user_id) throws SQLException {
		Connection conn = DBConnection.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("DELETE FROM user WHERE user_id = ?;");
		st.setInt(1, user_id);
		st.executeUpdate();
	}
	
	public String updateProfile(User user) {
		try {
			Connection conn = DBConnection.getInstance().getConnection();
			PreparedStatement st = conn.prepareStatement("UPDATE user SET first_name = ?, last_name = ?, email = ? WHERE user_id = ?;");
			st.setString(1, user.getFirst_name());
			st.setString(2, user.getLast_name());
			st.setString(3, user.getEmail());
			st.setInt(4, user.getUser_id());
			st.execute();
			return "Profile Update Successful.";
		} catch (MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			return "Email alreay used.";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Profile Update Failed.";
		}
	}
	
	public String updatePassword(User user) {
		try {
			Connection conn = DBConnection.getInstance().getConnection();
			PreparedStatement st = conn.prepareStatement("UPDATE user SET password = ? WHERE user_id = ?;");
			st.setString(1, user.getPassword());
			st.setInt(2, user.getUser_id());
			st.execute();
			return "Password Update Successful.";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Password Update Failed.";
		}
	}
}
