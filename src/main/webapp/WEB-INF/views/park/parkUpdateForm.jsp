<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>장소 정보 수정</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">장소 정보 수정</h2>
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
      <label for="course">코스:</label>
      <input type="text" class="form-control" id="course" name="course" value="${vo.course}" required>
    </div>
    <div class="form-group">
      <label for="title">제목:</label>
      <input type="text" class="form-control" id="title" name="title" value="${vo.title}" required>
    </div>
    <div class="form-group">
      <label for="content">내용:</label>
      <textarea class="form-control" rows="5" id="CKEDITOR" name="content" required>${vo.content}</textarea>
    </div>
    <div class="form-group">
      <label for="NPeople">방문 정원:</label>
      <input type="number" class="form-control" id="NPeople" name="NPeople" value="${vo.NPeople}" required>
    </div>
   	<div class="form-group">
      <label for="CKEDITOR">사진</label>
    	<textarea name="photo" id="photo" rows="6" class="form-control" required>${vo.photo}</textarea>
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
    <input type="hidden" name="idx" value="${vo.idx}">
    <button type="submit" class="btn btn-primary">수정하기</button>
    <button type="button" onclick="history.back()" class="btn btn-secondary">돌아가기</button>
  </form>
</div>
<p><br/></p>
</body>
</html>