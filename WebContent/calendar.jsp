<%@page import="com.model.EmotionDAO"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.model.EmotionDTO"%>
<%@page import="com.model.MemberDTO"%>
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
  <link rel="stylesheet" href="fullcalendar/lib/main.css">
  <script src="fullcalendar/lib/main.js"></script>
  <script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%
		// 오늘 날짜 구하기 
		Date date = new Date();
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month_new = "";
		String day_new = "";
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		if(month / 10 < 1){
			month_new = '0' + Integer.toString(month);
		}else {
			month_new = Integer.toString(month);
		}
		if(day / 10 < 1){
			day_new = '0' + Integer.toString(day);
		}else {
			day_new = Integer.toString(day);
		}
		
		String today = year +'-' +  month_new + '-' + day_new;
	%>
	<%
		request.setCharacterEncoding("UTF-8");
		
		// 로그인 한 id session값
		MemberDTO m_dto = (MemberDTO) session.getAttribute("id");
		
		EmotionDAO dao = new EmotionDAO();
		
		// 첫 로그인인지 확인
		EmotionDTO dto = dao.select(m_dto.getId()); 
		
		// 달력에 감정 표시 할 dao
		ArrayList<EmotionDTO> list = dao.calendar(m_dto.getId());
	%>
  <div id="emotion_calendar" class="container">
    <!-- 메뉴 버튼 -->
    <span class="btn_menu"><img src="images/menu.svg" alt="menu"></span>

		<!-- 오늘 날짜 -->
    <span class="today"></span>
    
    <!-- 분석 버튼 -->
    <a href="analysis.jsp">
      <img class="btn_analysis" src="images/icon.svg" alt="icon">
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
      <!-- 감정 스티커 -->
      <a href="#" class="sticker">
      	<!-- 첫 로그인인지 확인 -->
      	<%if(dto != null) {%>
      		<!-- 오늘 입력한 감정이 없을 때 기본이미지 나오게 하기 --> 
	     		<%if(!today.equals(list.get(0).getDate())) {%>
		      	<img src="images/nofeeling.svg" alt="sticker">
	        	<h2>오늘의 감정 색을 채워주세요!</h2>
	       	<%} else {%>
	       		<%
		       		String src = null;
			    		String color = null;
			    		
			    		String emote = list.get(0).getEmotion();
			    		
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
	           
	           <!-- 감정 텍스트 마크 컬러 설정 -->
	           <style>	
	          	#emotion_calendar .mark {
							  background-color: <%=color%>;
							}
	          </style>
	          <img src="images/<%=src %>" alt="sticker">
	          <h2><div class="mark"></div><%=list.get(0).getEmotion() %></h2>
	      	<%} %>
      	<%} else {%>
      			<img src="images/nofeeling.svg" alt="sticker">
	        	<h2>오늘의 감정 색을 채워주세요!</h2>
      	<%} %>  	
	      </a>
    </div><!-- END : .wrap -->

    <!-- fullcalendar Library -->
    <div class="calendar_border">
      <div id='calendar-container'>
        <div id='calendar'></div>
      </div>
    </div>
  
  	<style>
  	/* select_read.jsp로 보낼 form태그 안보이게 설정  */
		#readForm, #writeForm {
			visibility : hidden;
		}
  	</style>
  	
    <!-- 감정이 있을 때 다이어리 조회 페이지로 이동 -->
    <form action="select_read.jsp" method="post" id="readForm">
    	<input type="text" name="read_id" id="read_id">
    	<input type="text" name="read_date" id="read_date">
    	<input type="submit">
    </form>
    
    <!-- 감정이 없을 때 다이어리 작성 페이지로 이동 -->
    <form action="write.jsp" method="post" id="writeForm">
    	<input type="text" name="write_id" id="write_id">
    	<input type="text" name="write_date" id="write_date">
    	<input type="submit">
    </form>
    
  </div>
	
  <script src="js/main.js"></script>
  <script>
	  $(function () {
		  
			// 감정 입력 시 캘린더에 감정 등록
		  function stickerPrint(){
			  var items = $('.fc-daygrid-day');
			  
			  <%if(dto != null) {%>
			  	<%for(int j = 0; j < list.size(); j++) {%>
					  	for(var i = 0; i < items.length; i++){
					  		// 감정을 입력한 날짜와 같은 날에 감정물감 등록
					  		if("<%=list.get(j).getDate()%>" == items[i].dataset.date) {
					  			<%
				             String src = null;
				             String emote = list.get(j).getEmotion();
				             if(emote.equals("신남")) src = "exciting_mini.svg";
				             else if (emote.equals("행복")) src = "happy_mini.svg";
				             else if (emote.equals("설렘")) src = "flutter_mini.svg";
				             else if (emote.equals("평온")) src = "calm_mini.svg";
				             else if (emote.equals("우울")) src = "depression_mini.svg";
				             else if (emote.equals("슬픔")) src = "sad_mini.svg";
				             else if (emote.equals("후회")) src = "regret_mini.svg";
				             else if (emote.equals("분노")) src = "angry_mini.svg";
				           %>
						      items.eq(i).children().append("<img src='images/<%=src%>'  class='calendar_sticker'>");
						    }
					  	}
			  	<%}%>	
		  	<%}%>
		  	
		  } // stickerPrint()
      
		  stickerPrint();
		  
		  // 달력 prev, next 버튼 눌렀을 때 태그가 새로 생성돼서 스티커가 사라지는 오류 고침
		  $('.fc-prev-button').on('click', function () {
			  stickerPrint();
			  test();
      });
		  $('.fc-next-button').on('click', function () {
			  stickerPrint();
			  test();
      });
		  
		  
		  function test() {
			  // 감정 있는 부분을 누르면 해당하는 날짜의 select_read.jsp로 가는 코드
			  // 참조하는 객체 미리 생성
			  var items_index = $('.fc-daygrid-day');
			  var itemsClick = $('.fc-daygrid-day-frame');
			  
			  // 클릭된 날짜를 불러오기 위해 data-index 속성으로 index 번호 생성
			  for(var i = 0; i < items_index.length; i++){
				  items_index.eq(i).attr('data-index', i);
			  }
			  
			  // 캘린더에 클릭 이벤트 발생
			  itemsClick.on('click', function() {
				  
				  // 클릭 된 날짜의 인덱스 번호를 통해 객체의 날짜를 받아옴
				  var index = $(this).parent().attr('data-index');
				  index = parseInt(index);
				  var data_date = items_index.eq(index).attr('data-date');
				  
				  // 클릭 된 날짜에 이미 감정이 있을 때
				  if($(this).children().last().hasClass('calendar_sticker')){
						// 세션에 저장된 id와 날짜를 <form> #readForm로 select_read.jsp 이동
					  $('#read_id').val("<%=m_dto.getId()%>");
						$('#read_date').val(data_date);
						$('#readForm > input[type="submit"]').click();
					} else {
						// 감정이 없을 때
						// 세션에 저장된 id와 날짜를 <form> #writeForm로 write.jsp 이동
						$('#write_id').val("<%=m_dto.getId()%>");
						$('#write_date').val(data_date);
						$('#writeForm > input[type="submit"]').click();
					}
			  }); //itemsClick.onClick
			  
			  // calendar.jsp 페이지의 감정 입력 칸을 클릭 했을 때 (오늘의 감정)
			  if($('.sticker img').attr('src') == 'images/nofeeling.svg') {
						// 감정이 없다면 write.jsp로 이동
				  	$('.sticker').on('click', function (e) {
						// # 페이지로 이동하는 거 방지
					  e.preventDefault();
					  $('#write_id').val("<%=m_dto.getId()%>");
						$('#write_date').val("<%=today%>");
						// submit 버튼 자동 클릭
						$('#writeForm > input[type="submit"]').click();
				  });
			  } else {
						// 감정이 있다면 select_read.jsp로 이동
				  	$('.sticker').on('click', function (e) {
					  // # 페이지로 이동하는 거 방지
					  e.preventDefault();
					  $('#read_id').val("<%=m_dto.getId()%>");
						$('#read_date').val("<%=today%>");
						// submit 버튼 자동 클릭
						$('#readForm > input[type="submit"]').click();
				  });
			  }
		  }
		  
		  // prev, next 누를 때마다 클릭이 안 되는 오류 해결
		  test();
		 
	  }); // on.ready
  </script>
</body>
</html>
