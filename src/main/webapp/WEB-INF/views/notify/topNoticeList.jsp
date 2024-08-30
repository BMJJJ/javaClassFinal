<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #f8f9fa; }
    .notice-card { transition: all 0.3s ease; }
    .notice-card:hover { transform: translateY(-5px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>

<div class="container my-5">
  <h1 class="text-center mb-5">공지사항</h1>
  
  <div class="row">
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <c:if test="${vo.popupSw == 'Y'}">
        <div class="col-md-6 mb-4">
          <div class="card notice-card">
            <div class="card-body">
              <h5 class="card-title">${vo.title}</h5>
              <p class="card-text">${fn:replace(vo.content, newLine, '<br/>')}</p>
              <p class="card-text"><small class="text-muted">게시일: ${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</small></p>
            </div>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </div>

  <h3 class="text-center my-5">전체 공지사항</h3>
  <div class="table-responsive">
    <table class="table table-hover">
      <thead class="table-dark">
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>게시기간</th>
        </tr>
      </thead>
      <tbody>
        <c:set var="cnt" value="${fn:length(vos)}"/>
        <c:forEach var="vo" items="${vos}">
          <tr>
            <td>${cnt}</td>
            <td>
              <a href="#" onclick="openNotifyView(${vo.idx})" class="text-decoration-none">
                ${vo.title}
              </a>
            </td>
            <td>${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</td>
          </tr>
          <c:set var="cnt" value="${cnt - 1}"/>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function openNotifyView(idx) {
  window.open('${ctp}/notify/notifyView?idx=' + idx, 'mnList', 'width=560px,height=600px');
}
</script>
</body>
</html>