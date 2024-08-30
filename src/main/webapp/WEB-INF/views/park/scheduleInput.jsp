<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>scheduleInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      color: #333;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 50px;
    }
    h2 {
      color: #0c7b93; /* 깊은 바다색 */
      margin-bottom: 20px;
    }
    .form-control, .input-group-text {
      border-radius: 5px;
      border-color: #a2d2ff; /* 연한 하늘색 테두리 */
    }
    .btn {
      padding: 10px 20px;
      border-radius: 5px;
      transition: all 0.3s;
      width: 100%;
      margin-bottom: 10px;
    }
    .btn-custom {
      background-color: #00b4d8; /* 밝은 하늘색 */
      color: #fff;
      border: none;
    }
    .btn-custom:hover {
      background-color: #0077b6; /* 깊은 바다색 */
      color: #fff;
    }
    .btn-warning {
      background-color: #ffd166; /* 밝은 노란색 */
      border: none;
      color: #333;
    }
    .btn-warning:hover {
      background-color: #ffc300; /* 진한 노란색 */
      color: #333;
    }
    label {
      color: #0c7b93; /* 깊은 바다색 */
    }
    /* 배경에 물결 효과 추가 */
    .wave {
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 100px;
      background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23a2d2ff" fill-opacity="0.3" d="M0,128L48,154.7C96,181,192,235,288,234.7C384,235,480,181,576,170.7C672,160,768,192,864,197.3C960,203,1056,181,1152,170.7C1248,160,1344,160,1392,160L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') repeat-x;
      background-size: 1440px 100px;
      z-index: -1;
    }
  </style>
  <script>
    'use strict';
    
    // 페이지 로드 시 날짜 포맷 변경
    window.onload = function() {
      let ymd = '${ymd}';
      if(ymd) {
        // ymd 형식이 'YYYY-M-D'일 경우 'YYYY-MM-DD' 형식으로 변경
        let parts = ymd.split('-');
        let formattedDate = parts[0] + '-' + 
                            (parts[1].length < 2 ? '0' + parts[1] : parts[1]) + '-' + 
                            (parts[2].length < 2 ? '0' + parts[2] : parts[2]);
        document.getElementById('visitDate').value = formattedDate;
      }
    }
    
    
    function validateForm() {
        let selectedDate = document.getElementById('visitDate').value;
        let today = new Date().toISOString().split('T')[0];
        
        if (selectedDate < today) {
          alert('오늘 이후의 날짜만 선택할 수 있습니다.');
          return false;
        }
        return true;
    }
  </script>
</head>
<body>
<div class="wave"></div>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center mb-4">예약하기</h2>
  <form name="myform" method="post" action="scheduleInput">
<div class="form-group">
      <label for="title">지역명</label>
      <input type="text" name="title" id="title" value="${nationalVo.title}" class="form-control" readonly>
    </div>
    <div class="form-group">
      <label for="visitDate">예약 날짜</label>
      <input type="date" name="visitDate" id="visitDate" value="${ymd}" class="form-control" readonly>
    </div>
    <div class="form-group">
      <label for="nPeople">총인원수: ${nationalVo.NPeople}, 현재 신청 인원수: ${visitCnt}, 신청가능인원수: ${nationalVo.NPeople - visitCnt}</label>
      <input type="number" name="visitCnt" id="visitCnt" class="form-control" required>
    </div>
    <div class="form-group">
      <label for="content">특이사항</label>
      <textarea name="content" id="content" class="form-control" rows="3"></textarea>
    </div>
    <div class="form-group">
      <label for="course">코스명(행사명)</label>
      <input type="text" name="course" id="course" value="${nationalVo.course}" class="form-control" readonly>
    </div>
    <div class="form-group">
      <label for="part">구분</label>
      <input type="text" name="part" id="part" value="${nationalVo.part}" class="form-control" readonly>
    </div>
    <div class="row mt-4">
      <div class="col-md-6">
        <button type="submit" class="btn btn-custom">예약 신청하기</button>
      </div>
      <div class="col-md-6">
        <button type="button" onclick="location.href='parkList';" class="btn btn-warning">돌아가기</button>
      </div>
    </div>
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="visitCheck" value="NO">
    <input type="hidden" name="ymd" value="${ymd}">
    <input type="hidden" name="nationalIdx" value="${nationalVo.idx}">
  </form>
</div>
</body>
</html>