<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이야기 공유</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
     body {
     font-family: "Karma", sans-serif !important;
      background-color: #f0f4f0;
      color: #333;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h2 {
      color: #2e8b57;
      font-weight: bold;
    }
    .table {
      background-color: #ffffff;
    }
    .btn-success {
      background-color: #2e8b57;
      border-color: #2e8b57;
    }
    .btn-warning {
      background-color: #ffa500;
      border-color: #ffa500;
    }
    .btn-info {
      background-color: #4682b4;
      border-color: #4682b4;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4"><i class="fas fa-tree mr-2"></i>산책로 이야기 공유</h2>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th><i class="fas fa-user mr-2"></i>작성자</th>
        <td><input type="text" name="nickName" id="nickName" value="${sNickName}" readonly class="form-control" /></td>
      </tr>
      <tr>
        <th><i class="fas fa-heading mr-2"></i>제목</th>
        <td><input type="text" name="title" id="title" placeholder="산책로 이야기 제목을 입력하세요" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th><i class="fas fa-heading mr-2"></i>분류</th>
        <td>
        	<select name="part" id="part" class="form-control">
        		<c:if test="${sMid == 'admin'}">
        			<option ${part=="공지사항" ? "selected" : ""}>공지사항</option>
        		</c:if>
        		<c:if test="${sMid != 'admin'}">
        			<option ${part=="자유게시판" ? "selected" : ""}>자유게시판</option>
        		</c:if>
        	</select>
        </td>
      </tr>
      <tr>
        <th><i class="fas fa-pen mr-2"></i>내용</th>
        <td><textarea name="content" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
        <script>
          CKEDITOR.replace("content",{
        	  height:480,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",
        	  uploadUrl : "${ctp}/imageUpload"
          });
        </script>
      </tr>
      <tr>
        <th><i class="fas fa-lock mr-2"></i>공개 설정</th>
        <td>
          <input type="radio" name="openSw" id="openSw1" value="OK" checked /> 전체 공개 &nbsp;
          <input type="radio" name="openSw" id="openSw2" value="NO" /> 비공개
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="이야기 공유하기" class="btn btn-outline-success mr-2"/>
          <input type="reset" value="다시 작성" class="btn btn-outline-warning mr-2"/>
          <input type="button" value="목록으로" onclick="location.href='boardList';" class="btn btn-outline-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<p><br/></p>
</body>
</html>