<%@page import="com.model.EmotionDTO"%>
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
    response.setCharacterEncoding("UTF-8");
    
    // 수정 된 값을 가지고 올 때 
    EmotionDTO dto = (EmotionDTO)session.getAttribute("updateDTO");
    String write_id = dto.getId();
    String write_date = dto.getDate();
   %>
  <div id="write" class="container">
    <!-- 메뉴 버튼 -->
    <span class="btn_menu"><img src="images/menu.svg" alt="menu"></span>

    <!-- 일기 날짜 -->
    <span class="date"><%=dto.getDate() %></span>

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
      
      <!-- 일기 입력 양식 -->
      <form action="http://localhost:9000/predict" method="post">
         <div id = "myForm">
         
         </div>
        <!-- 감정 스티커 -->
        <div class="sticker">
          <img class="change" src="images/nofeeling.svg" alt="sticker">
          <h2>오늘의 감정 색을 채워주세요!</h2>    
        </div>
        
        <input type="text" name="title" placeholder="오늘을 한 마디로 표현한다면?">
        <textarea name="content" cols="45" rows="20" placeholder="오늘의 일기를 작성해보세요."></textarea>
        <input type="text" name="date" style="visibility: hidden" id="write_date">
        <input type="submit" value="저장">
      </form>
    </div><!-- END : .wrap -->

    <!-- 감정 스티커 오버레이 -->
    <div class="overlay">
      <!-- 오버레이 닫기 버튼 -->
      <span class="icon-close2 btn_close"></span>

      <!-- 감정 스티커 종류 -->
      <ul class="emotion"></ul>

    </div><!-- END : .overlay -->
  </div><!-- END : #log-->

  <script src="js/main.js"></script>
  <script>
    $(function () {
     // 날짜 데이터 WriteCon으로 전송
     $('#write_date').val("<%=write_date%>");
   });// on.ready
 </script>
</body>
</html>