<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
  <script src="js/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
</head>
<body>
	<%
		// 이번 달 화면에 표시
		String month_name = null;
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
		
		String today_month = year + '.' + month_new;
	%>
  <%
    request.setCharacterEncoding("UTF-8");
    
    // 로그인 한 id session값
    MemberDTO m_dto = (MemberDTO) session.getAttribute("id");
    
    EmotionDAO dao = new EmotionDAO();
    
    // 응답문 dao
    ArrayList<EmotionDTO> list = dao.response(m_dto.getId());
   
   // 감정물감 변수
   int flutter = 0;
   int happy = 0;
   int exciting = 0;
   int calm = 0;
   int sad = 0;
   int angry = 0;
   int regret = 0;
   int depression = 0;

	  // 감정물감 개수 꺼내기 
	 	for(int i=0; i< list.size(); i++){  
	 		month_name = list.get(i).getDate().substring(0,4) + "." + list.get(i).getDate().substring(5,7);
	 		if(month_name.equals(today_month)) {
		 		if(list.get(i).getEmotion().equals("설렘")) {
		       flutter++;
		    }else if((list.get(i).getEmotion()).equals("행복")){
		       happy++;
		    }else if((list.get(i).getEmotion()).equals("신남")){
		       exciting++;
		    }else if((list.get(i).getEmotion()).equals("평온")){
		       calm++;
		    }else if((list.get(i).getEmotion()).equals("슬픔")){
		       sad++;
		    }else if((list.get(i).getEmotion()).equals("분노")){
		       angry++;
		    }else if((list.get(i).getEmotion()).equals("후회")){
		       regret++;
		    }else if((list.get(i).getEmotion()).equals("우울")){
		       depression++;
		    }
		  }
	 	}
	  
	   // 일기 분석 감정 변수
	 	 int flutter_e = 0;
	   int happy_e = 0;
	   int exciting_e = 0;
	   int calm_e = 0;
	   int sad_e = 0;
	   int angry_e = 0;
	   int regret_e = 0;
	   int depression_e = 0;
 
	  // 일기 분석 감정 개수 꺼내기 
	 	for(int i=0; i< list.size(); i++){ 
	 		month_name = list.get(i).getDate().substring(0,4) + "." + list.get(i).getDate().substring(5,7);
	 		if(month_name.equals(today_month)) {
		    if(list.get(i).getAnalysis_e().equals("설렘")) {
		       flutter_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("행복")){
		       happy_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("신남")){
		       exciting_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("평온")){
		       calm_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("슬픔")){
		       sad_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("분노")){
		       angry_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("후회")){
		       regret_e++;
		    }else if((list.get(i).getAnalysis_e()).equals("우울")){
		       depression_e++;
		    }
		  }
	 	}
 
		// 가장 많이 & 가장 적게 느낀 감정 구하기
		// 감정물감 개수 + 일기분석 감정 개수로 최대 최소값 구하기
    Map<String, Integer> val=new HashMap<String, Integer>();
    val.put("happy_sum",happy + happy_e);
    val.put("flutter_sum", flutter + flutter_e);
    val.put("sad_sum", sad + sad_e);
    val.put("depression_sum", depression + depression_e);
    val.put("regret_sum", regret + regret_e);
    val.put("angry_sum", angry + angry_e);
    val.put("calm_sum", calm + calm_e);
    val.put("exciting_sum", exciting + exciting_e);

    // 최소값 넣어줄 ArrayList
    ArrayList<Entry<String,Integer>> result=new ArrayList<Entry<String,Integer>>();
    // 최대값 넣어줄 ArrayList
    ArrayList<Entry<String,Integer>> result2=new ArrayList<Entry<String,Integer>>();
 
    // 감정물감 + 일기분석 감정 개수 합 넣은 ArrayList
    ArrayList<Entry<String, Integer>> list_entries = new ArrayList<Entry<String, Integer>>(val.entrySet());
	  
    // 비교함수 Comparator를 사용하여 오름차순으로 정렬
    Collections.sort(list_entries, new Comparator<Entry<String, Integer>>() {
	      // compare로 값을 비교
	      public int compare(Entry<String, Integer> obj1, Entry<String, Integer> obj2) {
	         // 오름 차순 정렬
	         return obj1.getValue().compareTo(obj2.getValue());
	      }
	  });

	   // 최소값 result에 추가
	   // 0인 값 제외
	   int cnt = 0;   
	   for( int i=0; i<list_entries.size();i++){
      if(list_entries.get(i).getValue() == 0){
   	  	cnt++; 
      } else if(list_entries.get(cnt).getValue()==list_entries.get(i).getValue()){
        	  result.add(list_entries.get(i));
        }
     }
	   
	   //최대값 result2 추가
	   for( int i=0; i<list_entries.size();i++){
	         if(list_entries.get(list_entries.size()-1).getValue()==list_entries.get(i).getValue()){
	            result2.add(list_entries.get(i));
	         }
	      }   
	  %>
	
	  <div id="analysis" class="container">
	    <!-- 메뉴 버튼 -->
	    <span class="btn_menu"><img src="images/menu.svg" alt="menu"></span>
	
			<!-- 이번 달 -->
			<span class="month"></span>
			<span class="icon-sort-desc"></span>
	
			<ul class="date-list"></ul>
			
			<!-- diary에 이번 달이 아닌 달이 있으면 선택 사항으로 고를 수 있게 listitem 생성 -->
			<script>
			<%
				for(int i=0; i < list.size(); i++) {
					month_name = list.get(i).getDate().substring(0,4) + "." + list.get(i).getDate().substring(5,7);
					if(!month_name.equals(today_month)){%>
						$('.date-list').append('<li>'+ <%=month_name%> +'</li>');	
					
				<%}
			}
		%>	
		</script>
		
    <!-- 닫기 버튼 : calendar.jsp로 이동 -->
    <a href="calendar.jsp">
      <span class="icon-close2 btn_close"></span>
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
			<ul id="chart">
				<!-- 감정물감 개수 -->
				<li class="anal_sticker">
					<h2><span class="icon-circle">&nbsp;</span>감정물감으로 보는 당신의 감정</h2>
					<div class="doughnut">
	          <canvas id="stickerChart" width="100%" height="100%"></canvas>
	        </div>
	        <ul class="sticker_view"></ul><!-- END : .sticker_view -->
				</li>
	
				<!-- 다이어리 분석 감정 개수 -->
				<li class="anal_diary">
					<h2><span class="icon-circle">&nbsp;</span>일기로 보는 당신의 감정</h2>
					<div class="doughnut">
	          <canvas id="analysisChart" width="100%" height="100%"></canvas>
	        </div>
	        <ul class="sticker_view"></ul><!-- END : .sticker_view -->
				</li>
				
				<!-- 이번 달 가장 많이 나온 감정 -->
				<li class="anal_most">
				<%
					 // 가장 많이 나온 감정의 값이 2개 이상일 경우, 화면에 전체 출력하기 위해 감정들을 배열로 저장
           String[] src_most = new String[result2.size()];
           String[] color_most = new String[result2.size()];
           String[] name_most = new String[result2.size()];
           
           for(int i=0; i<result2.size(); i++){
              
              if(result2.get(i).getKey().equals("happy_sum")){
                   src_most[i]=("happy.svg");
                   color_most[i]=("#fea25e");
                   name_most[i]=("행복");
                } else if(result2.get(i).getKey().equals("flutter_sum")){
                   src_most[i]=("flutter.svg");
                   color_most[i]=("#ffabc0");
                   name_most[i]=("설렘");
                } else if(result2.get(i).getKey().equals("exciting_sum")){
                   src_most[i]=("exciting.svg");
                   color_most[i]=("#fff18a");
                   name_most[i]=("신남");
                } else if(result2.get(i).getKey().equals("sad_sum")){
                   src_most[i]=("sad.svg");
                   color_most[i]=("#909ecf");
                   name_most[i]=("슬픔");
                } else if(result2.get(i).getKey().equals("depression_sum")){
                   src_most[i]=("depression.svg");
                   color_most[i]=("#b5b5b5");
                   name_most[i]=("우울");
                } else if(result2.get(i).getKey().equals("regret_sum")){
                   src_most[i]=("regret.svg");
                   color_most[i]=("#deaeeb");
                   name_most[i]=("후회");
                } else if(result2.get(i).getKey().equals("calm_sum")){
                   src_most[i]=("calm.svg");
                   color_most[i]=("#a0d094");
                   name_most[i]=("평온");
                } else if(result2.get(i).getKey().equals("angry_sum")){
                   src_most[i]=("angry.svg");
                   color_most[i]=("#ed7c78");
                   name_most[i]=("분노");
                }      
              
           }
                    
         %>
					<h2><span class="icon-circle">&nbsp;</span>이번 달 가장 많이 느낌 감정</h2>
					<!-- 동일 개수 처리 -->
	       <%for(int i=0; i < result2.size(); i++){ %>
           <!-- 감정 마크 색 js로 처리 후 .backId로 받아줌 -->
           <input class="myColor" type="hidden" value="<%= color_most[i]%>">    
           <div>
             <img src="images/<%=src_most[i]%>">
             <h3><div class="mark backId"></div><span><%=name_most[i] %></span></h3>
           </div>
          <%} %>
          
				<!-- 이번 달 가장 적게 나온 감정 -->
				<%
						// 가장 적게 나온 감정의 값이 2개 이상일 경우, 화면에 전체 출력하기 위해 감정들을 배열로 저장
            String[] src_least = new String[result.size()];
            String[] color_least = new String[result.size()];
            String[] name_least = new String[result.size()];        
            
            for(int i=0; i<result.size(); i++){         
               
               if(result.get(i).getKey().equals("happy_sum")){
                  src_least[i]=("happy.svg");
                  color_least[i]=("#fea25e");
                  name_least[i]=("행복");
               } else if(result.get(i).getKey().equals("flutter_sum")){
                  src_least[i]=("flutter.svg");
                  color_least[i]=("#ffabc0");
                  name_least[i]=("설렘");
               } else if(result.get(i).getKey().equals("exciting_sum")){
                  src_least[i]=("exciting.svg");
                  color_least[i]=("#fff18a");
                  name_least[i]=("신남");
               } else if(result.get(i).getKey().equals("sad_sum")){
                  src_least[i]=("sad.svg");
                  color_least[i]=("#909ecf");
                  name_least[i]=("슬픔");
               } else if(result.get(i).getKey().equals("depression_sum")){
                  src_least[i]=("depression.svg");
                  color_least[i]=("#b5b5b5");
                  name_least[i]=("우울");
               } else if(result.get(i).getKey().equals("regret_sum")){
                  src_least[i]=("regret.svg");
                  color_least[i]=("#deaeeb");
                  name_least[i]=("후회");
               } else if(result.get(i).getKey().equals("calm_sum")){
                  src_least[i]=("calm.svg");
                  color_least[i]=("#a0d094");
                  name_least[i]=("평온");
               } else if(result.get(i).getKey().equals("angry_sum")){
                  src_least[i]=("angry.svg");
                  color_least[i]=("#ed7c78");
                  name_least[i]=("분노");
               }      
             
          }
          
         %>
          <li class="anal_least">
					<h2><span class="icon-circle">&nbsp;</span>이번 달 가장 적게 느낀 감정</h2>
	         <!-- 동일 개수 처리 -->
	         <%for(int i=0; i < result.size(); i++){ %>
	         	<!-- 감정 마크 색 js로 처리 후 .backId로 받아줌 -->
            <input class="myColor" type="hidden" value="<%= color_least[i]%>">               
           
           <div class="clear">
             <img src="images/<%=src_least[i]%>">
             <h3><div class="mark backId"></div><span><%=name_least[i] %></span></h3>
           </div>
          <%}%>
				</li>
			</ul><!-- END : #chart -->    

   		<!-- 이번 달 작성한 일기 보는 곳 -->
   		<h2 class="anal_diary_title"><div class="mark"></div><span>일기를 다시 보고 내 감정을 확인하세요!<span></span></h2>
    	<ul id="diary">
    	<%for(int i = 0; i < list.size(); i++) {
    		// 이번 달만 나오게 날짜 비교
    		month_name = list.get(i).getDate().substring(0,4) + "." + list.get(i).getDate().substring(5,7);
    		if(month_name.equals(today_month)) {%>
    		<li>
    			<div class="diary_wrap">
	    			<div>
	    				<%
	    					// 특정 날짜 요일로 바꾸기
	    					String inputDate = list.get(i).getDate();
	    					DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
	    					Date date_special = dateFormat.parse(inputDate);
	    					Calendar calendar = Calendar.getInstance();
	    					calendar.setTime(date_special);
	    					int day_num = calendar.get(Calendar.DAY_OF_WEEK);
	    					String day_special = "";
	    					if(day_num == 1){
	    						day_special = "수";
	    					} else if (day_num == 2) {
	    						day_special = "목";
	    					} else if (day_num == 3) {
	    						day_special = "금";
	    					} else if (day_num == 4) {
	    						day_special = "토";
	    					} else if (day_num == 5) {
	    						day_special = "일";
	    					} else if (day_num == 6) {
	    						day_special = "월";
	    					} else if (day_num == 7) {
	    						day_special = "화";
	    					}
	    					
	    					String date_num = list.get(i).getDate().substring(8,10);
	    				%>
		    			<span><%=date_num %>일 <%=day_special %>요일</span>
		    			<h3><%=list.get(i).getTitle() %></h3>
	    			</div>
	    			
	    			<div>
	    				<%
	    				 // 감정 물감
	    				 String emote = list.get(i).getEmotion();
	    				 String src = null;
	    				 
	    				 if(emote.equals("신남")) {
				        	src = "exciting.svg";
				       	} else if (emote.equals("행복")) {
				        	src = "happy.svg";
				        } else if (emote.equals("설렘")) {
				        	src = "flutter.svg";
				        } else if (emote.equals("평온")) {
				        	src = "calm.svg";
				        } else if (emote.equals("우울")) {
				        	src = "depression.svg";
				        } else if (emote.equals("슬픔")) {
				        	src = "sad.svg";
				        } else if (emote.equals("후회")) {
				        	src = "regret.svg";
				        } else if (emote.equals("분노")) {
				        	src = "angry.svg";
				        }
	    				 
	    				 // 일기분석 감정
	    				 String analysis_e = list.get(i).getAnalysis_e();
	    				 String src_e = null;
	    				 
	    				 if(analysis_e.equals("신남")) {
	    					 src_e = "exciting.svg";
				       	} else if (analysis_e.equals("행복")) {
				       		src_e = "happy.svg";
				        } else if (analysis_e.equals("설렘")) {
				        	src_e = "flutter.svg";
				        } else if (analysis_e.equals("평온")) {
				        	src_e = "calm.svg";
				        } else if (analysis_e.equals("우울")) {
				        	src_e = "depression.svg";
				        } else if (analysis_e.equals("슬픔")) {
				        	src_e = "sad.svg";
				        } else if (analysis_e.equals("후회")) {
				        	src_e = "regret.svg";
				        } else if (analysis_e.equals("분노")) {
				        	src_e = "angry.svg";
				        }
	    				%>
	    				<img src="images/<%=src%>">
	    				<img src="images/<%=src_e%>">
	    			</div>
    			</div>
    			<p><%=list.get(i).getContent() %></p>
    		</li>
    		<%} %>
   		<%} %>
    	</ul>
    </div><!-- END : .wrap  -->
  </div><!-- END : #container -->

  <script src="js/main.js"></script>
  <script>
    $(function () {
    	// 감정 마크 색 받아와서 .backId한테 돌려 줌
    	var h3Value = document.querySelectorAll('.backId'); 
      var colorValue = document.querySelectorAll('.myColor');
      for(var i = 0; i < colorValue.length; i++){
         h3Value[i].style.backgroundColor = colorValue[i].value;
      }
      
    	// 감정물감 각각 감정 개수
      var stickerData = [
      { route: 'flutter_mini.svg', num: <%=flutter%>},
        { route: 'happy_mini.svg', num: <%=happy%>},
        { route: 'exciting_mini.svg"', num: <%=exciting%>},
        { route: 'calm_mini.svg', num: <%=calm%>},
        { route: 'sad_mini.svg', num: <%=sad%>},
        { route: 'angry_mini.svg', num: <%=angry%>},
        { route: 'regret_mini.svg', num: <%=regret%>},
        { route: 'depression_mini.svg"', num: <%=depression%>}
      ]; // stickerData

      
      function stickerPrint() {
        stickerData.forEach(function(vl, idx) {
          dataHTML = '<li>'+
                    '<img src="images/'+ vl.route +'" alt="sticker_mini">'+
                    '<span>'+ vl.num + '개</span>' +
                    '</li>';
          $('.anal_sticker .sticker_view').append(dataHTML);
        });
      } // stickerPrint

      stickerPrint();

   		// 다이어리 분석 감정 각각 감정 개수
      var analysisData = [
      { route: 'flutter_mini.svg', num: <%=flutter_e%>},
        { route: 'happy_mini.svg', num: <%=happy_e%>},
        { route: 'exciting_mini.svg"', num: <%=exciting_e%>},
        { route: 'calm_mini.svg', num: <%=calm_e%>},
        { route: 'sad_mini.svg', num: <%=sad_e%>},
        { route: 'angry_mini.svg', num: <%=angry_e%>},
        { route: 'regret_mini.svg', num: <%=regret_e%>},
        { route: 'depression_mini.svg"', num: <%=depression_e%>}
      ]; // stickerData

      function analysisPrint() {
        analysisData.forEach(function(vl, idx) {
          dataHTML = '<li>'+
                    '<img src="images/'+ vl.route +'" alt="sticker_mini">'+
                    '<span>'+ vl.num + '개</span>' +
                    '</li>';
          $('.anal_diary .sticker_view').append(dataHTML);
        });
      } // analysisPrint

      analysisPrint();
      
    });// on.ready

    // 감정물감 도넛 차트
    var ctx = document.getElementById('stickerChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [<%=happy%>, <%=flutter%>, <%=exciting%>, <%=calm%>, <%=sad%>, <%=depression%>, <%=regret%>, <%=angry%>],
                backgroundColor: [
                    '#fea25e', // 행복
                    '#ffabc0', // 설렘
                    '#fff18a', // 신남
                    '#a0d094', // 평온
                    '#909ecf', // 슬픔
                    '#b5b5b5', // 우울
                    '#deaeeb', // 후회
                    '#ed7c78' // 분노
                ],
                borderWidth: 0
            }]
        }
    });

    // 다이어리분석 감정 도넛 차트
    var ctx = document.getElementById('analysisChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [<%=happy_e%>, <%=flutter_e%>, <%=exciting_e%>, <%=calm_e%>, <%=sad_e%>, <%=depression_e%>, <%=regret_e%>, <%=angry_e%>],
                backgroundColor: [
                    '#fea25e', // 행복
                    '#ffabc0', // 설렘
                    '#fff18a', // 신남
                    '#a0d094', // 평온
                    '#909ecf', // 슬픔
                    '#b5b5b5', // 우울
                    '#deaeeb', // 후회
                    '#ed7c78' // 분노
                ],
                borderWidth: 0
            }]
        }
    });

  </script>
</body>
</html>
