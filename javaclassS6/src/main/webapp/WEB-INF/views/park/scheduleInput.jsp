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
      background-color: #f8f9fa;
      color: #333;
    }
    .container {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 50px;
    }
    h2 {
      color: #2c3e50;
      margin-bottom: 20px;
    }
    .form-control, .input-group-text {
      border-radius: 0;
    }
    .btn {
      padding: 10px 20px;
      border-radius: 5px;
      transition: background-color 0.3s;
      width: 100%;
      margin-bottom: 10px;
    }
    .btn-custom {
      background-color: #2c3e50;
      color: #fff;
      border: none;
    }
    .btn-custom:hover {
      background-color: #34495e;
      color: #fff;
    }
    .btn-warning {
      background-color: #f39c12;
      border: none;
      color: #fff;
    }
    .btn-warning:hover {
      background-color: #e67e22;
      color: #fff;
    }
  </style>
  <script>
    'use strict';
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center mb-4">예약하기</h2>
  <form name="myform" method="post" action="scheduleInput">
    <div class="form-group">
      <label for="title">지역명</label>
      <input type="text" name="title" id="title" value="${nationalVo.title}" class="form-control" readonly>
    </div>
    <div class="form-group">
      <label for="title">지역명</label>
      <input type="Date" name="visitDate" id="visitDate" value="${ymd}" class="form-control" readonly>
    </div>
    <div class="form-group">
      <label for="nPeople">총인원수: ${nationalVo.NPeople}, 현재 신청 인원수: ${visitCnt}, 신청가능인원수: ${nationalVo.NPeople - visitCnt}</label>
      <input type="number" name="nPeople" id="nPeople" class="form-control" required>
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