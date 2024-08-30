<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카카오맵과 날씨 정보</title>
   <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25842eaa8d7542aca1b754697717a5ab&libraries=services"></script>
    <style>
			.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
			.map_wrap {position:relative;width:100%;height:350px;}
			#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 1;}
			#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
			#category li.on {background: #eee;}
			#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
			#category li:last-child{margin-right:0;border-right:0;}
			#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
			#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
			#category li .bank {background-position: -10px 0;}
			#category li .mart {background-position: -10px -36px;}
			#category li .pharmacy {background-position: -10px -72px;}
			#category li .oil {background-position: -10px -108px;}
			#category li .cafe {background-position: -10px -144px;}
			#category li .store {background-position: -10px -180px;}
			#category li.on .category_bg {background-position-x:-46px;}
			.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
			.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
			.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
			.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
			.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
			.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
			.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
			.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
			.placeinfo .tel {color:#0f7833;}
			.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
  
    .container-fluid {
      max-width: 1400px;
      margin: 0 auto;
      padding: 20px;
    }
    .row {
      margin-left: 0;
      margin-right: 0;
    }
    .col-md-8, .col-md-4 {
      padding: 15px;
    }
    #map {
      width: 100%;
      height: 500px;
      border: 1px solid #ddd;
    }
    .weather-cards {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
    }
    .weather-card {
      width: 180px;
      margin: 10px;
      border: 1px solid #ddd;
    }
    
    .pretty-button {
	    background-color: #A98467; 
	    border: none; /* 테두리 없음 */
	    color: white; /* 흰색 글자 */
	    padding: 10px 20px; /* 버튼의 패딩 */
	    text-align: center; /* 텍스트 중앙 정렬 */
	    text-decoration: none; /* 텍스트 데코레이션 없음 */
	    display: inline-block; /* 인라인 블록 요소 */
	    font-size: 14px; /* 글자 크기 */
	    margin: 5px 5px; /* 마진 */
	    cursor: pointer; /* 커서 포인터 */
	    border-radius: 20px; /* 둥근 테두리 */
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	    transition: background-color 0.3s ease, transform 0.2s ease; /* 배경색 전환 및 변형 효과 */
	    vertical-align:middle;
		}

		.pretty-button:hover {
		    background-color: #6C584C; /* 호버 시 배경색 */
		    transform: translateY(-2px); /* 호버 시 살짝 위로 이동 */
		}
		
		.pretty-button:active {
		    background-color: #A0A0A0; /* 클릭 시 배경색 */
		    transform: translateY(0); /* 클릭 시 원래 위치 */
		} 
		
		.select-wrapper {
		  display: inline-block;
		  position: relative;
		  margin-right: 10px;
		  width: 120px; /* 너비 설정 */
		}
		
		.select-wrapper select {
		  appearance: none;
		  -webkit-appearance: none;
		  -moz-appearance: none;
		  width: 100%; /* 부모 요소의 너비에 맞춤 */
		  padding: 10px 30px 10px 10px; /* 패딩 조정 */
		  font-size: 14px; /* 글자 크기 조정 */
		  border: 2px solid #A98467;
		  border-radius: 20px;
		  background-color: white;
		  cursor: pointer;
		}
		
		.select-wrapper::after {
		  content: '\25BC';
		  position: absolute;
		  top: 50%;
		  right: 10px;
		  transform: translateY(-50%);
		  pointer-events: none;
		  color: #A98467;
		  font-size: 12px; /* 화살표 크기 조정 */
		}
		
		.select-wrapper select:hover,
		.select-wrapper select:focus {
		  border-color: #A98467;
		  outline: none;
		}
		nav {
		  z-index: 9999; /* 네비게이션 바의 z-index를 높게 설정 */
		  position: relative; /* z-index가 적용되려면 position 속성이 필요합니다 */
		}
		
		.modal-body img {
  		max-width: 100%;
  		height: auto;
		}
		
		/* 이미지 모달 스타일 */
    .img-modal {
      display: none;
      position: fixed;
      z-index: 9999;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.8);
    }
    .img-modal-content {
      margin: auto;
      display: block;
      width: 80%;
      max-width: 700px;
    }
    .close-img-modal {
      position: absolute;
      top: 15px;
      right: 35px;
      color: #fff;
      font-size: 40px;
      font-weight: bold;
      transition: 0.3s;
    }
    .close-img-modal:hover,
    .close-img-modal:focus {
      color: #bbb;
      text-decoration: none;
      cursor: pointer;
    }
     #bicycleDemo, #bicycleSitemap {
      height: 600px;
      overflow: auto;
      border: 1px solid #D2C4B1;
      border-radius: 10px;
      padding: 15px;
      background-color: #FFF;
    }
    
  </style>
  <script>
  let selectedLocation = null;

  function accessToGeo(position) {
    const positionObj = {
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    }
    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
    $("#demo").text(lot);
  }
    
  $(document).ready(function () {
    function convertTime() {
      var now = new Date();
      var month = now.getMonth() + 1;
      var date = now.getDate();
      return month + '월' + date + '일';
    }
    var currentTime = convertTime();
    $('.nowtime').append(currentTime);
  });
    
  function weatherCheck1() {
    if (!selectedLocation) {
      alert("먼저 지도에서 위치를 선택해주세요.");
      return;
    }

    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+selectedLocation.latitude+'&lon='+selectedLocation.longitude+'&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
      function (WeatherResult) {
        $(".dispForm3").show();
        $('.jiyukName').html(selectedLocation.name);
        $('.nowTempl').html('현재기온: '+WeatherResult.main.temp + " ℃");
        $('.lowTempl').text('최저기온: '+WeatherResult.main.temp_min + " ℃");
        $('.highTempl').text('최고기온: '+WeatherResult.main.temp_max + " ℃");

        var weathericonUrl =
          '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
        $('.icon3').html(weathericonUrl);

        $("#demo").html("선택한 위치: " + selectedLocation.name + ", 위도: " + selectedLocation.latitude + ", 경도: " + selectedLocation.longitude);
      }
    );
  }
    
  $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
    function (WeatherResult) {
      $('.SeoulNowtemp').append(WeatherResult.main.temp + " ℃");
      $('.SeoulLowtemp').append(WeatherResult.main.temp_min + " ℃");
      $('.SeoulHightemp').append(WeatherResult.main.temp_max + " ℃");

      var weathericonUrl =
        '<img src= "http://openweathermap.org/img/wn/'
        + WeatherResult.weather[0].icon +
        '.png" alt="' + WeatherResult.weather[0].description + '"/>';
      $('.SeoulIcon').html(weathericonUrl);
    }
  );
    
  function weatherCheck2() {
    navigator.geolocation.getCurrentPosition(accessToGeo2)
  }
    
  function accessToGeo2(position) {
    const positionObj = {
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    }
    
    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
    $("#demo").text(lot);
    
    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+position.coords.latitude+'&lon='+position.coords.longitude+'&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
      function (WeatherResult) {
        $(".dispForm2").show();
       
        $('.nowtemp').html("현재기온 : " + WeatherResult.main.temp + " ℃");
        $('.lowtemp').html("최저기온 : " + WeatherResult.main.temp_min + " ℃");
        $('.hightemp').html("최고기온 : " + WeatherResult.main.temp_max + " ℃");

        var weathericonUrl =
          '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
        $('.icon2').html(weathericonUrl);
      }
    );
  }
    
  let jiyuk = "";
  function weatherCheck3() {
    jiyuk = document.getElementById("jiyuk").value.split("/");
    
    navigator.geolocation.getCurrentPosition(accessToGeo3);
  }

  function accessToGeo3(position) {
    const positionObj = {
      latitude: jiyuk[1],
      longitude: jiyuk[2]
    }
    
    let lot = "(선택위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
    $("#demo").text(lot);
    
    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+positionObj.latitude+'&lon='+positionObj.longitude+'&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
      function (WeatherResult) {
        $(".dispForm3").show();
        $('.jiyukName').html(jiyuk[0]);
        $('.nowTempl').html('현재기온:'+WeatherResult.main.temp + " ℃");
        $('.lowTempl').text('최저기온:'+WeatherResult.main.temp_min + " ℃");
        $('.highTempl').text('최고기온:'+WeatherResult.main.temp_max + " ℃");

        var weathericonUrl =
          '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
        $('.icon3').html(weathericonUrl);
      }
    );
  }

   // 지도 관련 스크립트
  $(document).ready(function() {
  	var mapContainer = document.getElementById('map'),
    mapOption = {
    	center: new kakao.maps.LatLng(36.63508163115122, 127.45948750459904),
      level: 3
    };

    //var map = new kakao.maps.Map(mapContainer, mapOption);
    var ps = new kakao.maps.services.Places();
    ps.keywordSearch('${address2}', placesSearchCB);
    ps.keywordSearch('${address1}', placesSearchCB);
    
    function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
          displayMarker(data[i]);    
          bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       
        map.setBounds(bounds);
      } 
    }
		
    function displayMarker(place) {
      var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
      });
     	kakao.maps.event.addListener(marker, 'click', function() {
      	$("#selectAddress").val(place.place_name);
        $("#latitude").val(place.y);
        $("#longitude").val(place.x);
        $("#demo").html("장소명:"+place.place_name+" , 위도:"+place.y+" , 경도:"+place.x);
        	selectedLocation = {
        		name: place.place_name,
          	latitude: place.y,
          	longitude: place.x
        	};
      	});
    	}
  	});
	  function addressSearch() {
	  	let address = myform.address1.value;
	  	if(address == "") {
	  		alert("검색할 지점을 선택하세요");
	  		return false;
	  	}
	  	myform.submit();
	  } 
	  function contentSearch() {
			let cont = document.getElementById("address1").value;
		}
	  // 이미지 모달을 여는 함수
	  function openImgModal(src) {
	    var imgModal = document.getElementById("imgModal");
	    var imgModalContent = document.getElementById("imgModalContent");
	    imgModal.style.display = "block";
	    imgModalContent.src = src;
	  }

	  // 이미지 모달을 닫는 함수
	  function closeImgModal() {
	    var imgModal = document.getElementById("imgModal");
	    imgModal.style.display = "none";
	  }

	  // 페이지 로드 시 모든 이미지를 클릭 이벤트와 연결
	  window.onload = function() {
	    var images = document.querySelectorAll(".modal-body img");
	    images.forEach(function(image) {
	      image.onclick = function() {
	        openImgModal(this.src);
	      }
	    });
	  }
  
	  function crawlingCheck() {
		  $("#spinnerIcon").show();
		  let stationStart = $("#stationStart").val();
		  let stationStop = $("#stationStop").val();
		  
		  $.ajax({
		    url   : "${ctp}/Srt/srt",
		    type  : "post",
		    data  : {
		      stationStart : stationStart,
		      stationStop : stationStop
		    },
		    success:function(vos) {
		      if(vos != "") {
		        let str = '';
		        str += '<table class="table table-bordered text-center"><tr class="table-dark text-dark"><th>열차</th><th>출발</th><th>도착</th><th>소요시간</th><th>요금</th></tr>';
		        for(let i=0; i<vos.length; i++) {
		          str += '<tr>';
		          str += '<td>'+vos[i].train+'</td>';
		          str += '<td>'+vos[i].start+'</td>';
		          str += '<td>'+vos[i].arrive+'</td>';
		          str += '<td>'+vos[i].time+'</td>';
		          str += '<td><a href="${ctp}/data/ckeditor/screenshot.png" target="_blank">'+vos[i].price+'</a></td>';
		          str += '</tr>';
		        }
		        str += '</tr></table>';
		        $("#strDemo").html(str);
		        
		        $("#spinnerIcon").hide();
		      }
		      else $("#strDemo").html("검색한 자료가 없습니다.");
		    }
		  });
		}
	  
	  function bicycleCheck() {
		  let spin = "<div class='text-center'> 자료 검색중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
		  $("#bicycleDemo").html(spin);
		  let page = $("#page").val();
		  
		  $.ajax({
			    url  : "${ctp}/mapandweather/bicycle",
			    type : "post",
			    data : {page : page},
			    success: function(vos) {
			      let str = '';
			      let cnt = 0;
			      
			      // 수정된 스타일
			      str = '<style>' +
			            'table { border-collapse: collapse; width: 100%; }' +
			            'th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }' +
			            'th { background-color: #f2f2f2; font-size: 1.1em; }' +
			            '.table-title { font-size: 1.3em; font-weight: bold; background-color: #4CAF50; color: white; padding: 12px; text-align: center; }' +
			            '.item-column { width: 30%; font-weight: bold; background-color: #e7f3fe; }' + // 항목 열 스타일
			            '</style>';
			      
			      str += '<table>';
			      str += '<tr><th colspan="2" class="table-title">자전거 대여소 정보</th></tr>';
			      str += '<tr><th class="item-column">항목</th><th>내용</th></tr>';
			      
			      for(let i=0; i<vos.length; i++) {
			        str += '<tr><td class="item-column">자전거대여소명</td><td>' + vos[i].bcyclLendNm + '</td></tr>';
			        str += '<tr><td class="item-column">자전거대여소구분</td><td>' + vos[i].bcyclLendSe + '</td></tr>';
			        str += '<tr><td class="item-column">소재지도로명주소</td><td>' + vos[i].rdnmadr + '</td></tr>';
			        str += '<tr><td class="item-column">소재지지번주소</td><td>' + vos[i].lnmadr + '</td></tr>';
			        str += '<tr><td class="item-column">위도</td><td>' + vos[i].latitude + '</td></tr>';
			        str += '<tr><td class="item-column">경도</td><td>' + vos[i].longitude + '</td></tr>';
			        str += '<tr><td class="item-column">운영시작시각</td><td>' + vos[i].operOpenHm + '</td></tr>';
			        str += '<tr><td class="item-column">운영종료시각</td><td>' + vos[i].operCloseHm + '</td></tr>';
			        str += '<tr><td class="item-column">휴무일</td><td>' + vos[i].rstde + '</td></tr>';
			        str += '<tr><td class="item-column">요금구분</td><td>' + vos[i].chrgeSe + '</td></tr>';
			        str += '<tr><td class="item-column">자전거이용요금</td><td>' + vos[i].bcyclUseCharge + '</td></tr>';
			        str += '<tr><td class="item-column">자전거보유대수</td><td>' + vos[i].bcyclHoldCharge + '</td></tr>';
			        str += '<tr><td class="item-column">거치대수</td><td>' + vos[i].holderCo + '</td></tr>';
			        str += '<tr><td class="item-column">공기주입기비치여부</td><td>' + vos[i].airInjectorYn + '</td></tr>';
			        str += '<tr><td class="item-column">공기주입기유형</td><td>' + vos[i].airInjectorType + '</td></tr>';
			        str += '<tr><td class="item-column">수리대설치여부</td><td>' + vos[i].repairStandYn + '</td></tr>';
			        str += '<tr><td class="item-column">관리기관전화번호</td><td>' + vos[i].phoneNumber + '</td></tr>';
			        str += '<tr><td class="item-column">관리기관명</td><td>' + vos[i].institutionNm + '</td></tr>';
			        str += '<tr><td class="item-column">데이터기준일자</td><td>' + vos[i].referenceDate + '</td></tr>';
			        str += '<tr><td class="item-column">제공기관코드</td><td>' + vos[i].insttCode + '</td></tr>';
			        str += '<tr><td class="item-column">지도보기</td><td><input type="button" value="지도보기" onclick="mapShow('+vos[i].latitude+','+vos[i].longitude+',\''+vos[i].bcyclLendNm+'\')" class="btn btn-sm btn-outline-secondary form-control"/></td></tr>';
			        str += '<tr><td colspan="2"><hr/></td></tr>';
			        cnt++;
			      }
			      str += '</table>';
			      if(cnt == 0) str += '<hr/>검색된 내역이 없습니다. 다시 검색해 주세요';
			      else str += '<hr/>총 '+cnt+'건이 검색되었습니다.';
			      $("#bicycleDemo").html(str);
			    },
			    error : function() {
			      alert("출력할 Page가 없습니다. 페이지번호를 다시 선택후 조회하세요");
			    }
			});
	  }

	  function bicycleCheck2() {
		  let spin = "<div class='text-center'> 자료 검색중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
		  $("#bicycleDemo").html(spin);
		  $.ajax({
		    url  : "${ctp}/mapandweather/bicycle2",
		    type : "post",
		    contentType : "application/json;charset=UTF-8",
		    success:function(vos) {
		      let str = '';
		      let cnt = 0;
		      
		      // 스타일 정의
		      str = '<style>' +
		            'table { border-collapse: collapse; width: 100%; }' +
		            'th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }' +
		            'th { background-color: #f2f2f2; font-size: 1.1em; }' +
		            '.table-title { font-size: 1.3em; font-weight: bold; background-color: #4CAF50; color: white; padding: 12px; text-align: center; }' +
		            '.item-column { width: 30%; font-weight: bold; background-color: #e7f3fe; }' +
		            '</style>';
		      
		      str += '<table>';
		      str += '<tr><th colspan="2" class="table-title">자전거 대여소 정보</th></tr>';
		      str += '<tr><th class="item-column">항목</th><th>내용</th></tr>';
		      
		      for(let i=0; i<vos.length; i++) {
		        str += '<tr><td class="item-column">번호</td><td>' + (i+1) + '</td></tr>';
		        str += '<tr><td class="item-column">대여소명</td><td>' + vos[i].stationName + '</td></tr>';
		        str += '<tr><td class="item-column">대여소ID</td><td>' + vos[i].stationId + '</td></tr>';
		        str += '<tr><td class="item-column">거치대수</td><td>' + vos[i].rackTotCnt + '</td></tr>';
		        str += '<tr><td class="item-column">거치율</td><td>' + vos[i].shared + '</td></tr>';
		        str += '<tr><td class="item-column">자전거 주차 총건수</td><td>' + vos[i].parkingBikeTotCnt + '</td></tr>';
		        str += '<tr><td class="item-column">위도/경도</td><td>' + vos[i].stationLatitude + ' / ' + vos[i].stationLongitude + '</td></tr>';
		        str += '<tr><td class="item-column">지도보기</td><td><input type="button" value="지도보기" onclick="mapShow('+vos[i].stationLatitude+','+vos[i].stationLongitude+',\''+vos[i].stationId+'\')" class="btn btn-sm btn-outline-secondary"/></td></tr>';
		        str += '<tr><td colspan="2"><hr/></td></tr>';
		        cnt++;
		      }
		      str += '</table>';
		      if(cnt == 0) str += '<div class="alert alert-warning">검색된 내역이 없습니다. 다시 검색해 주세요</div>';
		      else str += '<div class="alert alert-info">총 '+cnt+'건이 검색되었습니다.</div>';
		      $("#bicycleDemo").html(str);
		    },
		    error : function() {
		      alert("전송오류!");
		    }
		  });
		}
		
		function bicycleCheck3() {
	    	let spin = "<div class='text-center'> 자료 검색중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
	      $("#bicycleDemo").html(spin);
	    	let page = $("#page").val();
	    	let region = $("#region").val().trim();
	    	if(region == "") {
	    		alert("검색할 지역명을 입력하세요");
	    		$("#region").focus();
	    		return false;
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/mapandweather/bicycle",
	    		type : "post",
	    		data : {page : page},
	    		success:function(vos) {
	    			let str = '';
	    			let cnt = 0;
	    			for(let i=0; i<vos.length; i++) {
	    				if(vos[i].lnmadr.indexOf(region) != -1) {
		    				str += '자전거대여소명 : ' + vos[i].bcyclLendNm + '<br/>';
		    				str += '자전거대여소구분 : ' + vos[i].bcyclLendSe + '<br/>';
		    				str += '소재지도로명주소 : ' + vos[i].rdnmadr + '<br/>';
		    				str += '소재지지번주소 : ' + vos[i].lnmadr + '<br/>';
		    				str += '위도 : ' + vos[i].latitude + '<br/>';
		    				str += '경도 : ' + vos[i].longitude + '<br/>';
		    				str += '운영시작시각 : ' + vos[i].operOpenHm + '<br/>';
		    				str += '운영종료시각 : ' + vos[i].operCloseHm + '<br/>';
		    				str += '휴무일 : ' + vos[i].rstde + '<br/>';
		    				str += '요금구분 : ' + vos[i].chrgeSe + '<br/>';
		    				str += '자전거이용요금 : ' + vos[i].bcyclUseCharge + '<br/>';
		    				str += '자전거보유대수 : ' + vos[i].bcyclHoldCharge + '<br/>';
		    				str += '거치대수 : ' + vos[i].holderCo + '<br/>';
		    				str += '공기주입기비치여부 : ' + vos[i].airInjectorYn + '<br/>';
		    				str += '공기주입기유형 : ' + vos[i].airInjectorType + '<br/>';
		    				str += '수리대설치여부 : ' + vos[i].repairStandYn + '<br/>';
		    				str += '관리기관전화번호 : ' + vos[i].phoneNumber + '<br/>';
		    				str += '관리기관명 : ' + vos[i].institutionNm + '<br/>';
		    				str += '데이터기준일자 : ' + vos[i].referenceDate + '<br/>';
		    				str += '제공기관코드 : ' + vos[i].insttCode + '<br/>';
		    				str += '<input type="button" value="지도보기" onclick="mapShow('+vos[i].latitude+','+vos[i].longitude+',\''+vos[i].bcyclLendNm+'\')" class="btn btn-sm btn-outline-secondary form-control"/><hr/>';
		    				cnt++;
	    				}
	    			}
	    			if(cnt == 0) str += "검색된 지역이 없습니다. 다시 검색해 주세요";
	    			else str += '<hr/>총 '+cnt+'건이 검색되었습니다.';
	    			$("#bicycleDemo").html(str);
	    		},
	    		error : function() {
	    			alert("출력할 Page가 없습니다. 페이지번호를 다시 선택후 조회하세요");
	    			location.reload();
	    		}
	    	});
	    }
		
		
  </script>
  
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container-fluid">
  <div class="row">
    <!-- 왼쪽: 지도 -->
    <div class="col-md-8">
      <h2>검색하신 위치(${address1},${address2})</h2>
      <hr/>
      <form name="myform">
        <div>키워드검색 :
          <input type="text" name="address2" id="address2" autofocus required />
          <input type="submit" value="키워드 검색" class="pretty-button"/>
          <div id="demo"></div>
          <div style="display: flex; gap: 20px;">
					  <a href="#" data-toggle="modal" data-target="#srtModal">
					    <i class="fas fa-train"></i> 열차 시간표 알아보기
					  </a>
					  <a href="#" data-toggle="modal" data-target="#bicycleModal">
					    <i class="fas fa-bicycle"></i> 자전거 산책 알아보기
					  </a>
					</div>
        </div>
        <div class="select-wrapper">
  				<select name="address1" id="address1">
   				 <option value="">추천보기</option>
    				<c:forEach var="aVo" items="${addressVos}">
      				<option value="${aVo.address}" <c:if test="${aVo.address == vo.address}">selected</c:if>>${aVo.address}</option>
   			 		</c:forEach>
  				</select>
				</div> 
				<input type="button" value="지점선택" onclick="addressSearch()" class="pretty-button" style="vertical-align: middle;"/>
				<input type="button" value="사진및설명" onclick="contentSearch()" class="pretty-button" data-toggle="modal" data-target="#myModal"/>
        <input type="hidden" name="selectAddress" id="selectAddress" />
        <input type="hidden" name="latitude" id="latitude" />
        <input type="hidden" name="longitude" id="longitude" />
      </form>
      <hr/>
			<div class="map_wrap">
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			    <ul id="category">
			        <li id="BK9" data-order="0"> 
			            <span class="category_bg bank"></span>
			            은행
			        </li>       
			        <li id="MT1" data-order="1"> 
			            <span class="category_bg mart"></span>
			            마트
			        </li>  
			        <li id="PM9" data-order="2"> 
			            <span class="category_bg pharmacy"></span>
			            약국
			        </li>  
			        <li id="OL7" data-order="3"> 
			            <span class="category_bg oil"></span>
			            주유소
			        </li>  
			        <li id="CE7" data-order="4"> 
			            <span class="category_bg cafe"></span>
			            카페
			        </li>  
			        <li id="CS2" data-order="5"> 
			            <span class="category_bg store"></span>
			            편의점
			        </li>      
			    </ul>
			</div>
    </div>
    
    <!-- The Modal -->
	 <div class="modal" id="myModal">
	   <div class="modal-dialog">
	     <div class="modal-content">
	       <!-- Modal Header -->
	       <div class="modal-header">
	         <h4 class="modal-title">Story</h4>
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	       </div>
	       <!-- Modal body -->
	       <div class="modal-body">
	       	${vo.address}
	         ${vo.content}
	       </div>
	       <!-- Modal footer -->
	       <div class="modal-footer">
	         <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	       </div>
	     </div>
	   </div>
	 </div>
  
 	<!-- 이미지 모달 -->
  <div id="imgModal" class="img-modal">
    <span class="close-img-modal" onclick="closeImgModal()">&times;</span>
    <img class="img-modal-content" id="imgModalContent">
  </div>
	  
	  <!-- SRT Modal -->
	<div class="modal fade" id="srtModal" tabindex="-1" aria-labelledby="srtModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="srtModalLabel">SRT 승차권 조회</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <h5>원하는 출발역과 도착역을 입력하세요.</h5>
	        <form name="trainform">
	          <div class="input-group mb-3">
	            <span class="input-group-text mr-2">출발역</span>
	            <div class="input-group-append mr-3">
	            	<select name="stationStart" id="stationStart" class="form-control">
	            		<option value="수서">(서울)수서</option>
	            		<option value="동탄">(경기도 화성)동탄</option>
	            		<option value="평택지제">(경기도 평택)평택지제</option>
	            		<option value="천안아산">(충청남도 아산)천안아산</option>
	            		<option value="오송">(충청북도 청주)오송</option>
	            		<option value="대전">(대전광역시)대전</option>
	            		<option value="공주">(충청남도 공주)공주</option>
	            		<option value="김천(구미)">(경상북도 김천)김천(구미)</option>
	            		<option value="서대구">(대구광역시)서대구</option>
	            		<option value="동대구">(대구광역시)동대구</option>
	            		<option value="경주">(경상북도 경주시)경주</option>
	            		<option value="울산(통도사)">(울산 광역시)울산(통도사)</option>
	            		<option value="부산">(부산 광역시)부산</option>
	            		<option value="익산">(전라북도 익산시)익산</option>
	            		<option value="정읍">(전라북도 정읍시)정읍</option>
	            		<option value="광주송정">(광주 광역시)광주송정</option>
	            		<option value="나주">(전라남도 나주시)나주</option>
	            		<option value="목포">(전라남도 목포시)목포</option>
	            		<option value="밀양">(경상남도 밀양시)밀양</option>
	            		<option value="전주">(전라북도 전주시)전주</option>
	            		<option value="남원">(전라북도 남원시)남원</option>
	            		<option value="곡성">(전라북도 곡성군)곡성</option>
	            		<option value="순천">(전라남도 순천시)순천</option>
	            		<option value="여천">(전라남도 여수시)여천</option>
	            		<option value="여수EXPO">(전라남도 여수시)여수EXPO</option>
	            		<option value="진영">(경상남도 김해시)진영</option>
	            		<option value="창원중앙">(경상남도 창원시)창원중앙</option>
	            		<option value="창원">(경상남도 창원시)창원</option>
	            		<option value="마산">(경상남도 창원시)마산</option>
	            		<option value="진주">(경상남도 진주시)진주</option>
	            		<option value="포항">(경상북도 포항시)포항</option>
	            	</select>
	            </div>
	            ~
	            <span class="input-group-text ml-3 mr-2">도착역</span>
	            <div class="input-group-append">
	            	<select name="stationStop" id="stationStop" class="form-control">
		            	<option value="수서">(서울)수서</option>
	            		<option value="동탄">(경기도 화성)동탄</option>
	            		<option value="평택지제">(경기도 평택)평택지제</option>
	            		<option value="천안아산">(충청남도 아산)천안아산</option>
	            		<option value="오송">(충청북도 청주)오송</option>
	            		<option value="대전">(대전광역시)대전</option>
	            		<option value="공주">(충청남도 공주)공주</option>
	            		<option value="김천(구미)">(경상북도 김천)김천(구미)</option>
	            		<option value="서대구">(대구광역시)서대구</option>
	            		<option value="동대구">(대구광역시)동대구</option>
	            		<option value="경주">(경상북도 경주시)경주</option>
	            		<option value="울산(통도사)">(울산 광역시)울산(통도사)</option>
	            		<option value="부산">(부산 광역시)부산</option>
	            		<option value="익산">(전라북도 익산시)익산</option>
	            		<option value="정읍">(전라북도 정읍시)정읍</option>
	            		<option value="광주송정">(광주 광역시)광주송정</option>
	            		<option value="나주">(전라남도 나주시)나주</option>
	            		<option value="목포">(전라남도 목포시)목포</option>
	            		<option value="밀양">(경상남도 밀양시)밀양</option>
	            		<option value="전주">(전라북도 전주시)전주</option>
	            		<option value="남원">(전라북도 남원시)남원</option>
	            		<option value="곡성">(전라북도 곡성군)곡성</option>
	            		<option value="순천">(전라남도 순천시)순천</option>
	            		<option value="여천">(전라남도 여수시)여천</option>
	            		<option value="여수EXPO">(전라남도 여수시)여수EXPO</option>
	            		<option value="진영">(경상남도 김해시)진영</option>
	            		<option value="창원중앙">(경상남도 창원시)창원중앙</option>
	            		<option value="창원">(경상남도 창원시)창원</option>
	            		<option value="마산">(경상남도 창원시)마산</option>
	            		<option value="진주">(경상남도 진주시)진주</option>
	            		<option value="포항">(경상북도 포항시)포항</option>
	            	</select>
	            </div>
	          </div>
	          <div class="input-group mb-3">
	            <div class="input-group-prepend"><input type="button" value="새로고침" onclick="location.reload()" class="btn btn-info" /></div>
	            <span class="input-group-text" style="width:50%">SRT 열차 시간표 조회</span>
	            <div class="input-group-append mr-1"><input type="button" value="검색" onclick="crawlingCheck()" class="btn btn-success" /></div>
	            <div class="input-group-append"><span id="spinnerIcon" style="display:none"><span class="spinner-border"></span>검색중입니다.<span class="spinner-border"></span></span></div>
	          </div>
	        <div id="strDemo"></div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
		<!-- 자전거 모달 추가 -->
	<div class="modal fade" id="bicycleModal" tabindex="-1" role="dialog" aria-labelledby="bicycleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="bicycleModalLabel">전국 자전거 대여소 현황</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="row mb-4">
	          <div class="col-md-8 mb-3">
	            <div class="input-group">
	              <input type="number" name="page" id="page" value="1" min="1" class="form-control" style="max-width: 80px;">
	              <div class="input-group-append">
	                <span class="input-group-text">Page</span>
	              </div>
	            </div>
	          </div>
	          <div class="col-md-4 mb-3">
	            <div class="input-group">
	              <input type="text" name="region" id="region" placeholder="검색할 지역명" class="form-control">
	              <div class="input-group-append">
	                <button onclick="bicycleCheck3()" class="btn btn-custom">검색</button>
	              </div>
	            </div>
	          </div>
	        </div>
	        <div class="row mb-4">
	          <div class="col-md-6 mb-2">
	            <button onclick="bicycleCheck()" class="btn btn-custom btn-block">전국자전거대여소출력</button>
	          </div>
	          <div class="col-md-6 mb-2">
	            <button onclick="bicycleCheck2()" class="btn btn-custom btn-block">서울시 공공자전거 실시간 대여정보</button>
	          </div>
	        </div>
	        <hr/>
	        <div class="row">
	          <div class="col-md-6 mb-4" id="bicycleDemo"></div>
	          <div class="col-md-6 mb-4" id="bicycleSitemap"></div>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	  
    <!-- 오른쪽: 날씨 정보 -->
    <div class="col-md-4">
      <h2>날씨정보 확인하기</h2>
      <hr/>
     	<input type="button" value="마크표시 날씨" onclick="weatherCheck1()" class="pretty-button success"/>
			<input type="button" value="현재위치날씨" onclick="weatherCheck2()" class="pretty-button info"/>
      <hr/>
      <div id="demo"></div>
      <hr/>
      <div class="weather-cards">
        <div class="card weather-card">
          <div class="SeoulIcon"></div>
          <div class="card-body">
            <h4 class="card-title">서울</h4>
            <p class="card-text SeoulNowtemp">현재기온:</p>
            <p class="card-text SeoulLowtemp">최저기온:</p>
            <p class="card-text SeoulHightemp">최고기온:</p>
          </div>
        </div>
        <div class="card weather-card dispForm2" style="display:none;">
          <div class="icon2"></div>
          <div class="card-body">
            <h4 class="card-title">현재위치</h4>
            <p class="card-text nowtemp">현재기온:</p>
            <p class="card-text lowtemp">최저기온:</p>
            <p class="card-text hightemp">최고기온:</p>
          </div>
        </div>
        <div class="card weather-card dispForm3" style="display:none;">
          <div class="icon3"></div>
          <div class="card-body">
            <h4 class="card-title jiyukName"></h4>
            <p class="card-text nowTempl">현재기온:</p>
            <p class="card-text lowTempl">최저기온:</p>
            <p class="card-text highTempl">최고기온:</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25842eaa8d7542aca1b754697717a5ab&libraries=services"></script> 
<!-- 검색어로 검색된 지역을 출력시켜줄 스크립트 앞쪽('kakaoEx3.jsp의 스크립트')에 기술후, 그 아래 '카테고리별 장소 검색하기'스크립트 처리한다.(화면 검색후 주변처리해야하기때문..) --> 
	<script>
	  function mapShow(latitude, longitude, stationId) {
		  // 1.지도를 띄워주는 기본 코드(지도 생성)
			var mapContainer = document.getElementById('bicycleSitemap'), // 지도를 표시할 div 
	    mapOption = {
				center: new kakao.maps.LatLng(36.63508163115122, 127.45948750459904), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
	    var coords = new kakao.maps.LatLng(latitude, longitude);
	    //var coords = new kakao.maps.LatLng(36.63508163115122, 127.45948750459904);
	
	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: coords
	    });
	
	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">'+stationId+'</div>'
	    });
	    infowindow.open(map, marker);
	
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map.setCenter(coords);
	  }
	
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		
		
		// 키워드로 장소를 검색합니다
		ps.keywordSearch('${address}', placesSearchCB); 

		
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        //infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        //infowindow.open(map, marker);
		        
		        $("#selectAddress").val(place.place_name);
		        $("#latitude").val(place.y);
		        $("#longitude").val(place.x);
		        $("#demo").html("장소명:"+place.place_name+" , 위도:"+place.y+" , 경도:"+place.x);
		    });
		} 
	</script>
	
	<!-- 주변지역의 검색지점을 표출시켜줄 스크립트를 뒤쪽에 기술해준다.(샘플 : '카테고리별 장소 검색하기') -->
  <script>
		//마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
	  var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
	      contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
	      markers = [], // 마커를 담을 배열입니다
	      currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
	   
	  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	      mapOption = {
	          center: new kakao.maps.LatLng(36.63508163115122, 127.45948750459904), // 지도의 중심좌표
	          level: 5 // 지도의 확대 레벨
	      };  
	
	  // 지도를 생성합니다    
	  var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	  // 장소 검색 객체를 생성합니다
	  var ps = new kakao.maps.services.Places(map); 
	
	  // 지도에 idle 이벤트를 등록합니다
	  kakao.maps.event.addListener(map, 'idle', searchPlaces);
	
	  // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	  contentNode.className = 'placeinfo_wrap';
	
	  // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	  // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	  addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	  addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
	
	  // 커스텀 오버레이 컨텐츠를 설정합니다
	  placeOverlay.setContent(contentNode);  
	
	  // 각 카테고리에 클릭 이벤트를 등록합니다
	  addCategoryClickEvent();
	
	  // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	  function addEventHandle(target, type, callback) {
	      if (target.addEventListener) {
	          target.addEventListener(type, callback);
	      } else {
	          target.attachEvent('on' + type, callback);
	      }
	  }
	
	  // 카테고리 검색을 요청하는 함수입니다
	  function searchPlaces() {
	      if (!currCategory) {
	          return;
	      }
	      
	      // 커스텀 오버레이를 숨깁니다 
	      placeOverlay.setMap(null);
	
	      // 지도에 표시되고 있는 마커를 제거합니다
	      removeMarker();
	      
	      ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	  }
	
	  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	  function placesSearchCB(data, status, pagination) {
	      if (status === kakao.maps.services.Status.OK) {
	
	          // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	          displayPlaces(data);
	      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	          // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
	
	      } else if (status === kakao.maps.services.Status.ERROR) {
	          // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	          
	      }
	  }
	
	  // 지도에 마커를 표출하는 함수입니다
	  function displayPlaces(places) {
	
	      // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	      // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	      var order = document.getElementById(currCategory).getAttribute('data-order');
	
	      
	
	      for ( var i=0; i<places.length; i++ ) {
	
	              // 마커를 생성하고 지도에 표시합니다
	              var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
	
	              // 마커와 검색결과 항목을 클릭 했을 때
	              // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	              (function(marker, place) {
	                  kakao.maps.event.addListener(marker, 'click', function() {
	                      displayPlaceInfo(place);
	                  });
	              })(marker, places[i]);
	      }
	  }
	
	  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	  function addMarker(position, order) {
	      var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	          imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
	          imgOptions =  {
	              spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
	              spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	              offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	          },
	          markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	              marker = new kakao.maps.Marker({
	              position: position, // 마커의 위치
	              image: markerImage 
	          });
	
	      marker.setMap(map); // 지도 위에 마커를 표출합니다
	      markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	      return marker;
	  }
	
	  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
	  function removeMarker() {
	      for ( var i = 0; i < markers.length; i++ ) {
	          markers[i].setMap(null);
	      }   
	      markers = [];
	  }
	
	  // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	  function displayPlaceInfo (place) {
	      var content = '<div class="placeinfo">' +
	                      '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   
	
	      if (place.road_address_name) {
	          content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
	                      '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
	      }  else {
	          content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
	      }                
	     
	      content += '    <span class="tel">' + place.phone + '</span>' + 
	                  '</div>' + 
	                  '<div class="after"></div>';
	
	      contentNode.innerHTML = content;
	      placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
	      placeOverlay.setMap(map);  
	  }
	
	
	  // 각 카테고리에 클릭 이벤트를 등록합니다
	  function addCategoryClickEvent() {
	      var category = document.getElementById('category'),
	          children = category.children;
	
	      for (var i=0; i<children.length; i++) {
	          children[i].onclick = onClickCategory;
	      }
	  }
	
	  // 카테고리를 클릭했을 때 호출되는 함수입니다
	  function onClickCategory() {
	      var id = this.id,
	          className = this.className;
	
	      placeOverlay.setMap(null);
	
	      if (className === 'on') {
	          currCategory = '';
	          changeCategoryClass();
	          removeMarker();
	      } else {
	          currCategory = id;
	          changeCategoryClass(this);
	          searchPlaces();
	      }
	  }
	
	  // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	  function changeCategoryClass(el) {
	      var category = document.getElementById('category'),
	          children = category.children,
	          i;
	
	      for ( i=0; i<children.length; i++ ) {
	          children[i].className = '';
	      }
	
	      if (el) {
	          el.className = 'on';
	      } 
	  }
	  
	  
  </script>
  <div id="modalPhoto"></div>
</body>
</html>