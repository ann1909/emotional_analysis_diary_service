package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmotionDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	int cnt = 0;
	EmotionDTO dto = null;
	MemberDTO m_dto = null;
	ArrayList<EmotionDTO> list = null;
	
	// 연결
	public void conn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String db_url = "jdbc:oracle:thin:@localhost:1521:xe";
			String db_id = "hr";
			String db_pw = "hr";
			conn = DriverManager.getConnection(db_url, db_id, db_pw);

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 닫기
	public void close() {
		try {
			if (rs != null) {
				rs.close();
			}

			if (psmt != null) {
				psmt.close();
			}

			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 달력에 감정 표시
	public ArrayList<EmotionDTO> calendar(String id){
		list = new ArrayList<EmotionDTO>();
		conn();
		
		try {
			String sql = "select * from diary where id = ? order by today_date desc";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				String emotion = rs.getString(3);
	            String title = rs.getString(4);
	            String content = rs.getString(5);                  
	            String date = rs.getString(6);    
	            dto = new EmotionDTO(id, emotion, title, content, date);
	            list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return list;
	}
	
	// 분석
	public ArrayList<EmotionDTO> response(String id){
		list = new ArrayList<EmotionDTO>();
		conn();
		
		try {
			String sql = "select * from diary where id = ? order by today_date";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				String emotion = rs.getString(3);
	            String title = rs.getString(4);
	            String content = rs.getString(5);                  
	            String date = rs.getString(6);    
	            String analysis = rs.getString(7);    
	            dto = new EmotionDTO(id, emotion, title, content, date, analysis);
	            list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return list;
	}
	
	// 첫 로그인인지 확인 
	public EmotionDTO select(String id){
		conn();
		
		try {
			String sql = "select * from diary where id = ? order by today_date desc";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				String emotion = rs.getString(3);
	            String title = rs.getString(4);
	            String content = rs.getString(5);                  
	            String date = rs.getString(6);    
	            dto = new EmotionDTO(id, emotion, title, content, date);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return this.dto;
	}
	
	// 다이어리 작성
	public int write(EmotionDTO dto) {
		conn();
		
		try {
			String sql = "insert into diary values(?, diary_num.nextval,?,?,?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getEmotion());
			psmt.setString(3, dto.getTitle());
			psmt.setString(4, dto.getContent());
			psmt.setString(5, dto.getDate());
			psmt.setString(6, dto.getAnalysis_e());
			
			cnt = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}
	
	// 다이어리 조회
	public EmotionDTO read(String id, String date) {
		conn();
		
		try {
			String sql = "select * from diary where id = ? and today_date = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, date);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				String emotion = rs.getString(3);
				String title = rs.getString(4);
				String content = rs.getString(5);
				String analysis_e = rs.getString(7);

				dto = new EmotionDTO(id, emotion, title, content, date, analysis_e);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return dto;
	}
	
	// 다이어리 수정
	public int update(EmotionDTO dto) {
	  conn();
	  try {
	     String sql = "update diary set emotion = ? , title =? , content =?, analysis_e = ? where id =? and today_date = ?"; 
	         psmt = conn.prepareStatement(sql);
	         psmt.setString(1, dto.getEmotion());
	         psmt.setString(2, dto.getTitle());
	         psmt.setString(3, dto.getContent());
	         psmt.setString(4, dto.getAnalysis_e());
	         psmt.setString(5, dto.getId());
	         psmt.setString(6, dto.getDate());
	         cnt = psmt.executeUpdate();
	
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      return cnt;
   }
	
	// 다이어리 수정 여부 확인 시 필요
	public int countDiary(String id, String date) {
		conn();
		int count=0;
		try {
			String sql="select count(*) from diary where id=? and today_date=?";
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, date);
			
			rs=psmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return count;
	}
	
}
