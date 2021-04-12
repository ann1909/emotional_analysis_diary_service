package com.model;

public class ResponseDTO {

   private String analysis_e, response;

   public ResponseDTO(String analysis_e, String response) {
      this.analysis_e = analysis_e;
      this.response = response;
    
   }
   

   public ResponseDTO(String response) {
      this.response = response;
   }


   public String getAnalysis_e() {
      return analysis_e;
   }

   public void setAnalysis_e(String analysis_e) {
      this.analysis_e = analysis_e;
   }

   public String getResponse() {
      return response;
   }

   public void setResponse(String response) {
      this.response = response;
   }
   
   
}