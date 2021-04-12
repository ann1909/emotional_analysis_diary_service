<%@page import="com.model.ResponseDTO"%>
<%@page import="com.model.ResponseDAO"%>
<%@page import="com.model.EmotionDTO"%>
<%@page import="com.model.MemberDTO"%>
<%@page import="com.model.EmotionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FILLETTE</title>
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="fonts/icomoon/style.css">
  <link rel="stylesheet" href="css/main.css">
  <script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%
      request.setCharacterEncoding("UTF-8");
      
      EmotionDAO dao = new EmotionDAO();

      // 일기 작성하고 넘어 올 때
      MemberDTO m_dto = (MemberDTO) session.getAttribute("id");
      
      // 달력에서 바로 읽는 페이지로 넘어 올 때
      String read_id=null;
      String read_date=null;
      
      //session.getAttribute("dto") >> 첫 작성 후 dto세션설정
      if(session.getAttribute("wDto")!=null){
    	  // 수정된 값이 저장된 wDto
    	  EmotionDTO wdto=(EmotionDTO)session.getAttribute("wDto");

    	  read_id=wdto.getId();
    	  read_date=wdto.getDate();
    	  
      }else{
   		  read_id = request.getParameter("read_id");
     	  read_date = request.getParameter("read_date");  	     	  
      }

      session.removeAttribute("wDto");	
	  	
      // 수정 된 dto 세션
      EmotionDTO dto = dao.read(read_id, read_date);
      session.setAttribute("updateDTO", dto);
			      
      // 분석 결과 응답문
      ResponseDAO an_dao = new ResponseDAO();
      ResponseDTO an_dto = an_dao.comment(dto);
   %>

  <div id="read" class="container">
    <!-- 메뉴 버튼 -->
    <span class="btn_menu"><img src="images/menu.svg" alt="menu"></span>

    <!-- 일기 날짜 -->
   	<span class="date"><%=dto.getDate() %></span>
		
    <!-- 수정 버튼 -->
    <a href="update.jsp" class="modify">
	    <span >수정</span>
    </a>

    <!-- 메뉴 -->
    <div id="menu">
      <!-- 메뉴 닫기 버튼 -->
      <span class="icon-close2 btn_close"></span>

      <!-- 메뉴 리스트 -->
      <ul>
        <li><a href="calendar.jsp">감정 팔레트</a></li>
        <li><a href="analysis.jsp">감정분석결과 </a></li>
        <li><a href="log.html">로그아웃</a></li>
      </ul>
    </div><!-- END : #menu -->
    
    <div class="wrap">
      <table>
        <tbody>
          <tr>
            <td class="read_img">
            	<!-- dto에 저장된 값 불러오기 -->
            	<%
            		String src = null;
            		String color = null;
            		String emote = dto.getEmotion();
            		
                if(emote.equals("신남")) {
                	src = "exciting.svg";
                	color = "#fff18a";
               	} else if (emote.equals("행복")) {
                	src = "happy.svg";
                	color = "#fea25e";
                } else if (emote.equals("설렘")) {
                	src = "flutter.svg";
                	color = "#ffabc0";
                } else if (emote.equals("평온")) {
                	src = "calm.svg";
                	color = "#a0d094";
                } else if (emote.equals("우울")) {
                	src = "depression.svg";
                	color = "#b5b5b5";
                } else if (emote.equals("슬픔")) {
                	src = "sad.svg";
                	color = "#909ecf";
                } else if (emote.equals("후회")) {
                	src = "regret.svg";
                	color = "#deaeeb";
                } else if (emote.equals("분노")) {
                	src = "angry.svg";
                	color = "#ed7c78";
                }
            		%> 
              <img class="change" src="images/<%=src %>" alt="sticker">
            </td>
          </tr>
          <!-- 감정 마크 색 설정 -->
          <style>	
          	#read .mark {
						  background-color: <%=color%>;
						}
          </style>
          <tr>
            <td class="read_text">
              <h2><div class="mark"></div><span><%=dto.getEmotion() %></span>   
            </td>
          </tr>
          <tr>
            <td class="read_title">
	           <%=dto.getTitle()%>
            </td>
          </tr>
          <tr>
            <td class="read_content">
              <p>
                <%=dto.getContent()%>
              </p>
            </td>
          </tr>
          <!-- 코멘트 박스 -->
          <tr>
          	<td>
          		<div id="comment_box">
          			<table>
          				<tbody>
          					<tr>
          						<td>일기로 분석된 감정 &nbsp; &nbsp;<span class="icon-arrow-right"></span></td>
          						<td>
												<%
					            		String analysis_e = dto.getAnalysis_e();
					            		
					                if(analysis_e.equals("신남")) {
					                	src = "exciting.svg";
					                	color = "#fff18a";
					               	} else if (analysis_e.equals("행복")) {
					                	src = "happy.svg";
					                	color = "#fea25e";
					                } else if (analysis_e.equals("설렘")) {
					                	src = "flutter.svg";
					                	color = "#ffabc0";
					                } else if (analysis_e.equals("평온")) {
					                	src = "calm.svg";
					                	color = "#a0d094";
					                } else if (analysis_e.equals("우울")) {
					                	src = "depression.svg";
					                	color = "#b5b5b5";
					                } else if (analysis_e.equals("슬픔")) {
					                	src = "sad.svg";
					                	color = "#909ecf";
					                } else if (analysis_e.equals("후회")) {
					                	src = "regret.svg";
					                	color = "#deaeeb";
					                } else if (analysis_e.equals("분노")) {
					                	src = "angry.svg";
					                	color = "#ed7c78";
					                } 
				            		%>
				            		<!-- 일기로 분석한 감정 마크 색 설정 -->
				            		<style>
							          	#anal_diary .mark {
													  width : 140%;
													  left : -20%;
													  opacity: 0.3;
													  background-color: <%=color%>;
													}
							          </style>
	              				<img class="change" src="images/<%=src %>" alt="sticker">
          						</td>
          						<td id="anal_diary"><div class="mark"></div><%=analysis_e %></td>
          					</tr>
          					<tr>
          						<td>
          							<p>
          							  <!-- 분석 결과 응답문 -->
          								<%
          								String an_response = null;
          								if(analysis_e.equals("신남")){ 
          									an_response = an_dto.getResponse();
         									}else if(analysis_e.equals("행복")){
         										an_response = an_dto.getResponse();
                          }else if(analysis_e.equals("설렘")){
                        	  an_response = an_dto.getResponse();
                          }else if(analysis_e.equals("평온")){ 
                        	  an_response = an_dto.getResponse();
                          }else if(analysis_e.equals("우울")){
                        	  an_response = an_dto.getResponse();
                          }else if(analysis_e.equals("슬픔")){
                        	  an_response = an_dto.getResponse();
                          }else if(analysis_e.equals("후회")){
                        	  an_response = an_dto.getResponse();
                          }else if(analysis_e.equals("분노")){
                        	  an_response = an_dto.getResponse();        
                          } %>
                          <%=an_response %>
          							</p>
          						</td>
          					</tr>
          				</tbody>
          			</table>
          		</div> <!-- END : #comment_box  -->
          	</td>
          </tr>
        </tbody>
      </table>
    </div><!-- END : .wrap -->
  </div><!-- END : #log-->

  <script src="js/main.js"></script>
</body>
</html>