<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약 수정</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container mt-5">
  <h2>예약 수정</h2>
  <form method="post">
    <div class="form-group">
      <label for="course">코스:</label>
      <input type="text" class="form-control" id="course" name="course" value="${vo.course}" readonly>
    </div>
    <div class="form-group">
      <label for="visitDate">예약일자:</label>
      <input type="date" class="form-control" id="visitDate" name="visitDate" value="${fn:substring(vo.visitDate, 0, 10)}">
    </div>
    <div class="form-group">
      <label for="content">특이사항</label>
      <textarea name="content" id="content" class="form-control" rows="3">${vo.content}</textarea>
    </div>
    <div class="form-group">
      <label for="visitCnt">인원:</label>
      <input type="number" class="form-control" id="visitCnt" name="visitCnt" value="${vo.visitCnt}">
    </div>
    <input type="hidden" name="idx" value="${vo.idx}">
    <button type="submit" class="btn btn-primary">수정</button>
  </form>
</div>
</body>
</html>
