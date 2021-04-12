package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ResponseDAO {

   Connection conn = null;
   PreparedStatement psmt = null;
   ResultSet rs = null;
   ResponseDTO resultDTO=null;
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

   // ´Ý±â
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
   
   public ResponseDTO comment(EmotionDTO dto) {
      conn();

      try {
         String sql = "select * from response where analysis_e=?";
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, dto.getAnalysis_e());         
         rs = psmt.executeQuery();
         
         if (rs.next()) {                  
                     
            String response = rs.getString(3);
         
            resultDTO = new ResponseDTO(response);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         close();
      }

      return resultDTO;
   }

   
}