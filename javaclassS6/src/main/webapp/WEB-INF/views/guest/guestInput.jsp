<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>guestInput.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
  	body {
    	background-color: #f0f4f0;
		}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<hr/>
<p><br/></p>
<p><br/></p>
<div class="container">
  <h3>한줄수다</h3>
  <form name="myform" method="post" class="was-validated">
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" value="${sNickName}" placeholder="Enter username" name="name" required />
      <div class="valid-feedback">Ok!!!</div>
      <div class="invalid-feedback">성명을 입력해 주세요.</div>
    </div>
    <div class="form-group">
      <label for="content">방문소감</label>
      <textarea rows="5" name="content" id="content" required class="form-control"></textarea>
      <div class="valid-feedback">Ok!!!</div>
      <div class="invalid-feedback">방문소감을 입력해 주세요.</div>
    </div>
    <div class="form-group text-center">
    	<button type="submit" class="btn btn-outline-dark mr-3">글등록</button>
    	<button type="reset" class="btn btn-outline-dark mr-3">다시입력</button>
    	<button type="button" onclick="location.href='${ctp}/guest/guestList';" class="btn btn-outline-dark">돌아가기</button>
    </div>
    <%-- <input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>"/> --%>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
<p><br/></p>
</body>
</html>