package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	MemberDTO dto = null;
	int cnt = 0;
	
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
	
	// 회원가입
	public int join(MemberDTO dto) {
		conn();
		
		try {
			String sql = "insert into member values(?,?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getBirth());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getPw());
			
			cnt = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return cnt;
	}
	
	// 로그인
	public MemberDTO login(MemberDTO dto) {
		conn();
		try {
			String sql = "select * from member where id = ? and pw = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPw());

			rs = psmt.executeQuery();

			if (rs.next()) {
				String name = rs.getString(1);
				String birth = rs.getString(2);
				// 위에 있는 전역변수를 가리킴
				this.dto = new MemberDTO(name, birth, dto.getId(), dto.getPw());
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return this.dto;
	}
	
	
}
