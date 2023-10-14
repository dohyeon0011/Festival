package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	
	private Connection conn;	
	private ResultSet rs;	
	
	public BoardDAO() {	
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
	
	
	public String getDate() {
		String SQL = "select now()";	
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
		String SQL="SELECT boardNo from festival.board order by boardNo DESC";	
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int write(String boardTitle, String userID, String boardContent, int boardCount, int LikeCount) {
		String SQL="INSERT INTO festival.board VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());	
			pstmt.setString(2, userID);	
			pstmt.setString(3, boardTitle);	
			pstmt.setString(4, boardContent);	
			pstmt.setString(5, getDate());	
			pstmt.setInt(6, 1);	
			pstmt.setInt(7, boardCount);
			pstmt.setInt(8, LikeCount);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public ArrayList<BoardVO> getList(int pageNumber){	
		String SQL="SELECT * from festival.board where boardNo < ? AND boardAvailable = 1 order by boardNo desc limit 10";
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);	
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setBoardNo(rs.getInt(1));
				boardVO.setUserID(rs.getString(2));
				boardVO.setBoardTitle(rs.getString(3));
				boardVO.setBoardContent(rs.getString(4));
				boardVO.setCreateDate(rs.getString(5));
				boardVO.setBoardAvailable(rs.getInt(6));
				boardVO.setBoardCount(rs.getInt(7));
				boardVO.setLikeCount(rs.getInt(8));
				list.add(boardVO);	
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
	
	public int getCount() {
		String SQL = "select count(*) from festival.board";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// �럹�씠吏� 泥섎━瑜� �쐞�븳 �븿�닔
	public boolean nextPage(int pageNumber) {
		String SQL="SELECT * from festival.board where boardNo < ? AND boardAvailable =1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;	
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public BoardVO getBoard(int boardNo) {
		String SQL = "SELECT * from festival.board where boardNo = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setBoardNo(rs.getInt(1));
				boardVO.setUserID(rs.getString(2));
				boardVO.setBoardTitle(rs.getString(3));
				boardVO.setBoardContent(rs.getString(4));
				boardVO.setCreateDate(rs.getString(5));
				boardVO.setBoardAvailable(rs.getInt(6));
				int boardCount = rs.getInt(7);
				boardVO.setBoardCount(boardCount);
				boardCount++;
				countUpdate(boardCount,boardNo);
				boardVO.setLikeCount(rs.getInt(8));
				return boardVO;	
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int countUpdate(int boardCount, int boardNo) {
		String SQL = "update festival.board set boardCount = ? where boardNo = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardCount);
			pstmt.setInt(2, boardNo);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int update(int boardNo, String boardTitle,String boardContent ) {
		String SQL="update festival.board set boardTitle = ?, boardContent = ? where boardNo = ?"; 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardNo);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int delete(int boardNo) {
		String SQL = "update festival.board set boardAvailable = 0 where boardNo = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNo);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int like(int boardNo) {
		String SQL = "update festival.board set likeCount = likeCount + 1 where boardNo = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNo);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return -1;
	}
	
	public ArrayList<BoardVO> getSearch(String searchField, String searchText){
	      ArrayList<BoardVO> list = new ArrayList<BoardVO>();
	      String SQL ="select * from festival.board WHERE "+ searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	                SQL +=" LIKE '%"+searchText.trim()+"%' order by boardNo desc limit 10";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();
	         while(rs.next()) {
	        	BoardVO boardVO = new BoardVO();
	        	boardVO.setBoardNo(rs.getInt(1));
	        	boardVO.setUserID(rs.getString(2));
	        	boardVO.setBoardTitle(rs.getString(3));
	        	boardVO.setBoardContent(rs.getString(4));
	        	boardVO.setCreateDate(rs.getString(5));
	        	boardVO.setBoardAvailable(rs.getInt(6));
	        	boardVO.setBoardCount(rs.getInt(7));
	        	boardVO.setLikeCount(rs.getInt(8));
	            list.add(boardVO);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;	
	   }
}