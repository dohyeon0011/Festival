package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import board.BoardVO;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			
			/*
			 * String driver="org.mariadb.jdbc.Driver"; String
			 * url="jdbc:mariadb://183.111.199.216:3306/ljs2267"; String dbId="ljs2267";
			 * String dbPw="ehdwns2020@@!"; Class.forName(driver); conn =
			 * DriverManager.getConnection(url, dbId, dbPw);
			 * System.out.println("MariaDB에 연결되었습니다.");
			 */
			
			 String driver = "com.mysql.cj.jdbc.Driver"; 
			 String url = "jdbc:mysql://localhost:3306/festival?useUnicode=true&serverTimezone=Asia/Seoul&jdbcCompliantTruncation=false";
			 String dbId = "festival"; 
			 String dbPw = "ehgus12"; 
			 Class.forName(driver);
			 conn = DriverManager.getConnection(url, dbId, dbPw);
			 System.out.println("MySql에 연결되었습니다.");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM festival.festivalMember WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;	
				else
					return 0; 	
			}
			return -1;	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; 
	}
	
	
	public int join(UserVO userVO) {
		String SQL = "INSERT INTO festival.festivalMember VALUES (?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userVO.getUserID());
			pstmt.setString(2, userVO.getUserPassword());
			pstmt.setString(3, userVO.getUserName());
			pstmt.setString(4, userVO.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}

	
	public UserVO getUser(String userID) {
		String SQL="SELECT * from festival.festivalMember where userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				UserVO userVO = new UserVO();
				userVO.setUserID(rs.getString(1));
				userVO.setUserPassword(rs.getString(2));
				userVO.setUserName(rs.getString(3));
				userVO.setUserEmail(rs.getString(4));
				return userVO;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String userID, String userPassword, String userEmail ) {
		String SQL="update festival.festivalMember set userPassword = ?, userEmail = ? where userID = ?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int delete(String userID) { 
		String SQL="delete from festival.festivalMember where userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
}