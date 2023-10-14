package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.BoardVO;

public class CommentDAO {
	private Connection conn;	
	private ResultSet rs;		

	public CommentDAO() {
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

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MySql 연결에 실패했습니다.");
		}
	}
	
	public String getDate() {	
		String SQL = "select DATE_FORMAT(now(), '%Y-%m-%d %H:%i:%s');";	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			rs=pstmt.executeQuery();	
			if(rs.next()) {
				return rs.getString(1);	
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";	
	}
	
	public int getNext() {
		String SQL = "SELECT commentID from COMMENT order by commentID DESC"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int write(String commentContent, String userID, int boardNo) {
		String SQL = "insert into COMMENT VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, boardNo);
			pstmt.setString(3, userID);
			pstmt.setString(4, commentContent);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

	public ArrayList<CommentVO> getList(int boardNo) {
		String SQL="SELECT * from comment where boardNo = ? AND commentAvailable = 1 order by boardNo desc limit 10"; 
		ArrayList<CommentVO> list = new ArrayList<CommentVO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentVO commentVO = new CommentVO();
				commentVO.setCommentID(rs.getInt(1));
				commentVO.setBoardNo(rs.getInt(2));
				commentVO.setUserID(rs.getString(3));
				commentVO.setCommentContent(rs.getString(4));
				commentVO.setCommentDate(rs.getString(5));
				commentVO.setCommentAvailable(rs.getInt(6));
				list.add(commentVO);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public CommentVO getComment(int commentID) {
		String SQL="SELECT * from comment where commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			rs=pstmt.executeQuery();
			if(rs.next()) {	
				CommentVO commentVO = new CommentVO();
				commentVO.setCommentID(rs.getInt(1));
				commentVO.setBoardNo(rs.getInt(2));
				commentVO.setUserID(rs.getString(3));
				commentVO.setCommentContent(rs.getString(4));
				commentVO.setCommentDate(rs.getString(5));
				commentVO.setCommentAvailable(rs.getInt(6));
				return commentVO;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int boardNo, int commentID, String commentContent ) {
		String SQL="update comment set commentContent = ? where boardNo = ? and commentID = ?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, commentContent); 
			pstmt.setInt(2, boardNo);
			pstmt.setInt(3, commentID);
			return pstmt.executeUpdate(); 		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int delete(int commentID) {
		String SQL = "update COMMENT set commentAvailable = 0 where commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
}
