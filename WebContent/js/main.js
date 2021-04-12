$(function () {
  // 메뉴 //////////////////////////////////////////////////////////////
  var $menu = $('#menu');
  
  // 메뉴 버튼 클릭 
  $('.btn_menu').on('click', function() {
		$('#menu a').css('opacity', '1');
		$('#menu .btn_close').css('opacity', '1');
		$menu.css('width', '60%');
  });

  // 메뉴 닫기 버튼 클릭
  $('#menu > .btn_close').on('click', function () {
		$('#menu a').css('opacity', '0');
		$('#menu .btn_close').css('opacity', '0');
		$menu.css('width', '0');
  });


  // 감정 스티커 오버레이 //////////////////////////////////////////////
  // open
  $('#write .sticker').on('click', function() {
    $('#write .overlay').css('display', 'block');
  });
  
  // close 
  $('#write .overlay .btn_close').on('click', function() {
    $('#write .overlay').css('display', 'none');
  });
  
// 감정 스티커 종류 .emotion 자식으로 넣어주는 코드
  var emotionData = [
  	{ route: 'exciting.svg', name: '신남'},
    { route: 'happy.svg', name: '행복'},
    { route: 'flutter.svg', name: '설렘'},
    { route: 'calm.svg', name: '평온'},
    { route: 'depression.svg', name: '우울'},
    { route: 'sad.svg', name: '슬픔'},
    { route: 'regret.svg', name: '후회'},
    { route: 'angry.svg', name: '분노'}
  ]; // emotionData

  function emotionPrint() {
    emotionData.forEach(function(vl, idx) {
      dataHTML = '<li>'+
                '<img src="images/'+ vl.route +'" alt="emotion">'+
                '<span><div class="mark"></div>'+ vl.name + '</span>' +
                '</li>';
      $('.emotion').append(dataHTML);
    });
  } // emotionPrint
  
  emotionPrint();
  
  // 스티커 바꾸기
  $('#write .overlay li').on('click', function() {
    var $text = $(this).children().last().text();
    var $html = $(this).children().last().html();
    var $img = $(this).children().first().attr('src');
    var $color = $(this).children().last().children().css('background-color');
    
    $('#write .sticker h2').html($html);
    $('#write .sticker h2 .mark').css('background-color', $color);
    $('.change').attr('src', $img);
    $('#write .overlay').css('display', 'none');
	
	// 감정 값 input으로 해주기
    $('#myForm').empty();
    $('#myForm').append('<input name="emote" type="hidden" value="'+$text+'">');
  });
  
}); //on.ready

  // 오늘 날짜 구하기 //////////////////////////////////////////////////
  var today = new Date();
  var year = today.getFullYear();     // 년도
  var month = today.getMonth() + 1;   // 월
  var date = today.getDate();         // 날짜
  // var day = today.getDay();        // 요일

  // 실시간 달력 오늘 날짜
  if(month / 10 < 1){
    month = '0' + month;
  }
  if(date / 10 < 1){
    date = '0' + date;
  }
	
	// 현재 시간 기준으로
	// 오늘 날짜
  var today_print = year + '-' + month + '-' + date;
  // 이번 달
  var month_print = year + '.' + month;

  // fullcalendar Libraries ////////////////////////////////////////////////////
	document.addEventListener('DOMContentLoaded', function() {
	  // 실시간 달력 오늘 날짜 
	  today_print = year + '-' + month + '-' + date;
	
	  var calendarEl = document.getElementById('calendar');
	
	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    // 캘린더 언어 : 한글
	    locale: 'ko',
	    height: '100%',
	    expandRows: true,
	    // slotMinTime: '08:00',
	    // slotMaxTime: '20:00',
	    headerToolbar: {
	      left: '',
	      center: 'prev,title,next',
	      right: ''
	    },
	    initialView: 'dayGridMonth',
	    initialDate: today_print,
	    navLinks: true, // can click day/week names to navigate views
	    editable: true,
	    selectable: true,
	    nowIndicator: true,
	    dayMaxEvents: true // allow "more" link when too many events
	    
	  });
	
	  calendar.render();
	});


  // 실시간 오늘 날짜 calendar.jsp 날짜 위치에 넣기
  $('.today').append(today_print);
  
  // 실시간 이번 달 analysis.jsp 날짜 위치에 넣기
	var $month = $('.month');
  var $dateList = $('.date-list');
  
	$month.append(month_print);

	// analysis.jsp 월 바꾸기
	$month.on('click', function () {
		if($dateList.is(':visible')){
    		$dateList.css('display', 'none');
		} else {
    		$dateList.css('display', 'block');
		}
	});
	
