package likey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeyDAO {
	private Connection conn;	
	private ResultSet rs;		

	public LikeyDAO() {
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
			System.out.println("MySql이 연결되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MySql연결에 실패했습니다.");
		}
	}
	
	public int like(String userID, int boardNo) {
		String SQL = "insert into boardLike values (?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardNo);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}

}
