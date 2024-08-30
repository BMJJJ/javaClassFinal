<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>boardUpdate.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f4f0;
      color: #333;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }
    h2 {
      color: #2c3e50;
      text-align: center;
      margin-bottom: 30px;
    }
    .table {
      background-color: #fff; 
      border-radius: 10px;
      overflow: hidden;
    }
    th {
      background-color: #e8f5e9;
      text-align: center;
    }
    .btn-nature {
      background-color: #4CAF50;
      color: white;
      border: none;
    }
    .btn-nature:hover {
      background-color: #45a049;
    }
    .pagination .page-link {
      color: #4CAF50;
    }
    .pagination .page-item.active .page-link {
      background-color: #4CAF50;
      border-color: #4CAF50;
    }
    .search-form {
      background-color: #e8f5e9;
      padding: 20px;
      border-radius: 10px;
      margin-top: 20px;
    }
    .modal-header {
      background-color: #4CAF50;
      color: white;
    }
    .footer {
      background-color: #2c3e50;
      color: #ecf0f1;
      padding: 20px 0;
      margin-top: 30px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">게 시 판 글 수 정 하 기</h2>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>글쓴이</th>
        <td><input type="text" name="nickName" id="nickName" value="${sNickName}" readonly class="form-control" /></td>
      </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" id="title" value="${vo.title}" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea name="content" id="CKEDITOR" rows="6" class="form-control" required>${vo.content}</textarea></td>
				<script>
          CKEDITOR.replace("content",{
        	  height:480,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
        	  uploadUrl : "${ctp}/imageUpload"						/* uploadUrl : 여러개의 그림파일을 드래그&드롭해서 올릴수 있다. */
          });
        </script>
      </tr>
      <tr>
        <th>공개여부</th>
        <td>
          <input type="radio" name="openSw" id="openSw1" value="OK" ${vo.openSw == 'OK' ? 'checked' : ''} /> 공개 &nbsp;
          <input type="radio" name="openSw" id="openSw2" value="NO" ${vo.openSw == 'NO' ? 'checked' : ''}/> 비공개
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="수정하기" class="btn btn-outline-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-outline-warning mr-2"/>
          <input type="button" value="돌아가기" onclick="location.href='boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <%-- <input type="hidden" name="mid" value="${sMid}"/> --%>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<p><br/></p>
</body>
</html>