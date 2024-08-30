<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>전국 자전거 대여소 현황</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <!-- <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet"> -->
  <style>
    body {
      background-color: #F4F1EA;
      color: #333;
    }
    .container {
      background-color: #FFF;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      margin-top: 50px;
    }
    h2 {
      color: #A98467;
      text-align: center;
      margin-bottom: 30px;
      font-weight: 700;
    }
    .btn-custom {
      background-color: #A98467;
      color: white;
      border: none;
      transition: all 0.3s;
    }
    .btn-custom:hover {
      background-color: #8D7052;
      color: white;
    }
    .form-control:focus {
      border-color: #A98467;
      box-shadow: 0 0 0 0.2rem rgba(169, 132, 103, 0.25);
    }
    #demo, #sitemap {
      height: 600px;
      overflow: auto;
      border: 1px solid #D2C4B1;
      border-radius: 10px;
      padding: 15px;
      background-color: #FFF;
    }
    .spinner-border {
      color: #A98467 !important;
    }
    hr {
      border-top: 1px solid #D2C4B1;
    }
    .input-group-append .btn {
      background-color: #A98467;
      color: white;
      border-color: #A98467;
    }
    .input-group-append .btn:hover {
      background-color: #8D7052;
    }
  </style>
  <script>
    'use strict';
    
    function bicycleCheck() {
    	let spin = "<div class='text-center'><div class='spinner-border text-muted'></div> 자료 검색중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
      $("#demo").html(spin);
    	let page = $("#page").val();
    	
    	$.ajax({
    		url  : "${ctp}/mapandweather/bicycle",
    		type : "post",
    		data : {page : page},
    		success:function(vos) {
    			console.log(vos);
    			let str = '';
    			let cnt = 0;
    			for(let i=0; i<vos.length; i++) {
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
    			if(cnt == 0) str += '<hr/>검색된 내역이 없습니다. 다시 검색해 주세요';
    			else str += '<hr/>총 '+cnt+'건이 검색되었습니다.';
    			$("#demo").html(str);
    		},
    		error : function() {
    			alert("출력할 Page가 없습니다. 페이지번호를 다시 선택후 조회하세요");
    			location.reload();
    		}
    	});
    }
    
    function bicycleCheck2() {
    	let spin = "<div class='text-center'><div class='spinner-border text-muted'></div> 자료 검색중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
      $("#demo").html(spin);
    	$.ajax({
    		url  : "${ctp}/mapandweather/bicycle2",
    		type : "post",
    		contentType : "application/json;charset=UTF-8",
    		success:function(vos) {
    			console.log(vos);
    			let str = '';
    			let cnt = 0;
    			for(let i=0; i<vos.length; i++) {
    				str += (i+1) + "."
    				str += "대여소명 : " + vos[i].stationName + '<br/>';
    				str += "대여소ID : " + vos[i].stationId + '<br/>';
    				str += "거치대수 : " + vos[i].rackTotCnt + '<br/>';
    				str += "거치율 : " + vos[i].shared + '<br/>';
    				str += "자전거 주차 총건수 : " + vos[i].parkingBikeTotCnt + '<br/>';
    				str += "위도/경도 : " + vos[i].stationLatitude + ' / ' + vos[i].stationLongitude + '<br/>';
    				str += '<input type="button" value="지도보기" onclick="mapShow('+vos[i].stationLatitude+','+vos[i].stationLongitude+',\''+vos[i].stationId+'\')" class="btn btn-sm btn-outline-secondary form-control"/><hr/>';
    			}
    			if(cnt == 0) str += '<hr/>검색된 내역이 없습니다. 다시 검색해 주세요';
    			else str += '<hr/>총 '+cnt+'건이 검색되었습니다.';
    			$("#demo").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function bicycleCheck3() {
    	let spin = "<div class='text-center'><div class='spinner-border text-muted'></div> 자료 검색중입니다. 잠시만 기다려주세요 <div class='spinner-border text-muted'></div></div>";
      $("#demo").html(spin);
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
    			console.log(vos);
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
    			$("#demo").html(str);
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
<div class="container">
  <h2>전국 자전거 대여소 현황</h2>
  <hr/>
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
    <div class="col-md-6 mb-4" id="demo"></div>
    <div class="col-md-6 mb-4" id="sitemap"></div>
  </div>
</div>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25842eaa8d7542aca1b754697717a5ab"></script>
	<script>
	  function mapShow(latitude, longitude, stationId) {
		  // 1.지도를 띄워주는 기본 코드(지도 생성)
			var mapContainer = document.getElementById('sitemap'), // 지도를 표시할 div 
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
	</script>
<p><br/></p>
</body>
</html>