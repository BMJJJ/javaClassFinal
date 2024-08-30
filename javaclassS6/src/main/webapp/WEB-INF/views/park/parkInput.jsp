<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>parkInput.jsp</title>
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
  <h2 class="text-center mb-4">사진파일 업로드</h2>
  <p class="text-muted text-center mb-4">(Shift/Ctrl키를 사용하여 여러장의 사진을 업로드할수 있습니다.)</p>
  <hr/>
  <form name="myform" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="part">분류</label>
      <select name="part" id="part" class="form-control">
        <option value="산책로" selected>산책로</option>
        <option value="탐방로(산)">탐방로(산)</option>
        <option value="탐방로(해안)">탐방로(해안)</option>
      </select>
    </div>
    <div class="form-group">
      <label for="title">지역</label>
      <select name="title" id="title" class="form-control">
        <option selected>서울</option>
        <option>경기도</option>
        <option>강원도</option>
        <option>강원도</option>
        <option>강원도</option>
        <option>강원도</option>
        <option>강원도</option>
        <option>강원도</option>
        <option>강원도</option>
      </select>
    </div>
    <div class="form-group">
  		<label for="nPeople">인원수</label>
  		<input type="number" name="nPeople" id="nPeople" class="form-control"/>
		</div>
    <div class="form-group">
      <label for="CKEDITOR">사진</label>
    	<textarea name="photo" id="photo" rows="6" class="form-control" required></textarea>
        <script>
          CKEDITOR.replace("photo", {
            height: 480,
            filebrowserUploadUrl: "${ctp}/imageUpload",
            uploadUrl: "${ctp}/imageUpload",
            toolbar: [
              { name: 'insert', items: ['Image'] }
            ], 
            removeButtons: 'Cut,Copy,Paste,Undo,Redo,Anchor',
            extraAllowedContent: 'img[alt,border,width,height,align,vspace,hspace,!src];'
          });
        </script>
    </div>
    <div class="form-group">
    	<label for="content">설명</label>
    	<input type="text" name="content" id="content" class="form-control"/>
    </div>
    <div class="form-group">
    	<label for="course">코스</label>
    	<input type="text" name="course" id="course" class="form-control"/>
    </div>
    <div class="form-group">
    	<label for="noneDate">비개방날짜</label>
    	<input type="text" name="noneDate" id="noneDate" class="form-control"/>
    </div>
    <div class="row mt-4">
      <div class="col-md-6">
        <button type="submit" class="btn btn-custom">이야기 공유하기</button>
      </div>
      <div class="col-md-6">
        <button type="button" onclick="location.href='parkList';" class="btn btn-warning">돌아가기</button>
      </div>
    </div>
    <input type="hidden" name="mid" value="${sMid}" />
  </form>
</div>
</body>
</html>