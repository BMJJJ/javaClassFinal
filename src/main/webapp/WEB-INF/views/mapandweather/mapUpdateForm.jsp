<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>지점 정보 수정</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    function fCheck() {
      let address = myform.address.value;
      let latitude = myform.latitude.value;
      let longitude = myform.longitude.value;
      let content = CKEDITOR.instances.content.getData();
      
      if(address.trim() == "") {
        alert("지점명을 입력하세요");
        myform.address.focus();
        return false;
      }
      else if(latitude.trim() == "") {
        alert("위도를 입력하세요");
        myform.latitude.focus();
        return false;
      }
      else if(longitude.trim() == "") {
        alert("경도를 입력하세요");
        myform.longitude.focus();
        return false;
      }
      else if(content.trim() == "") {
        alert("내용을 입력하세요");
        myform.content.focus();
        return false;
      }
      
      myform.submit();
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">지점 정보 수정</h2>
  <form name="myform" method="post" action="${ctp}/mapandweather/mapUpdateForm">
    <div class="form-group">
      <label for="address">지점명:</label>
      <input type="text" class="form-control" id="address" name="address" value="${vo.address}" readonly>
    </div>
    <div class="form-group">
      <label for="latitude">위도:</label>
      <input type="text" class="form-control" id="latitude" name="latitude" value="${vo.latitude}" required>
    </div>
    <div class="form-group">
      <label for="longitude">경도:</label>
      <input type="text" class="form-control" id="longitude" name="longitude" value="${vo.longitude}" required>
    </div>
    <div class="form-group">
      <label for="content">내용:</label>
      <textarea class="form-control" rows="5" id="content" name="content" required>${vo.content}</textarea>
    </div>
    <script>
      CKEDITOR.replace("content",{
        height:500,
        filebrowserUploadUrl:"${ctp}/imageUpload",
        uploadUrl : "${ctp}/imageUpload"
      });
    </script>
    <button type="button" onclick="fCheck()" class="btn btn-primary">수정하기</button>
    <button type="button" onclick="location.href='${ctp}/mapandweather/mapUpdate';" class="btn btn-secondary">돌아가기</button>
  </form>
</div>
<p><br/></p>
</body>
</html>