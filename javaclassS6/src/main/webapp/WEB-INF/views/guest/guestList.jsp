<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>산책로 방명록</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: "Karma", sans-serif !important;
      /* background-color: #f0f4f0; */
      color: #333;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }
    h2, h4 {
      color: #2c3e50;
    }
    .table {
      /* background-color: #fff; */
      border-radius: 10px;
      overflow: hidden;
    }
    th {
      /* background-color: #7cb342; */
      background-color: #A98467;
      color: white;
      text-align: center;
    }
    .btn-nature {
      background-color: #A98467;
      color: white;
      border: none;
    }
    /* .btn-nature:hover {
      background-color: #45a049;
    } */
    .pagination a {
      color: #A98467;
    }
    .guest-message {
      background-color: #F8F2ED;
      /* background-color: #A98467; */
      border-left: 5px solid #A98467;
      margin-bottom: 20px;
      padding: 15px;
      border-radius: 5px;
    }
    .page-item.active .page-link{
    	background-color: #A98467;
    	border-color: none;
    }
    .footer {
      background-color: #2c3e50;
      color: #ecf0f1;
      padding: 20px 0;
      margin-top: 30px;
    }
  </style>
  <script>
    'use strict';
    
    function showModal(idx) {
      document.getElementById('deleteConfirmBtn').setAttribute('href', 'guestDelete?idx=' + idx);
      $('#deleteModal').modal('show');
    }
    
    function pageSizeCheck() {
      let pageSize = document.getElementById("pageSize").value;
      location.href = "guestList?pag=${pag}&pageSize="+pageSize;
    }
  </script>
</head>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<body>
<div class="container mt-5">
  <h2 class="text-center mb-4"><i>Serenity</i></h2>
  <h4 class="text-center mb-5">여러분의 소중한 발자취를 남겨주세요.</h4>
  
  <div class="d-flex justify-content-between align-items-center mb-4">
    <a href="guestInput" class="btn btn-nature">글쓰기</a>
    <div>
      <c:if test="${pag > 1}">
        <a href="guestList?pag=1&pageSize=${pageSize}" class="btn btn-sm btn-outline-secondary">◁◁</a>
        <a href="guestList?pag=${pag-1}&pageSize=${pageSize}" class="btn btn-sm btn-outline-secondary">◀</a>
      </c:if>
      <span class="mx-2">${pag}/${totPage}</span>
      <c:if test="${pag < totPage}">
        <a href="guestList?pag=${pag+1}&pageSize=${pageSize}" class="btn btn-sm btn-outline-secondary">▶</a>
        <a href="guestList?pag=${totPage}&pageSize=${pageSize}" class="btn btn-sm btn-outline-secondary">▷▷</a>
      </c:if>
    </div>
    <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-control" style="width: auto;">
      <option <c:if test="${pageSize == 2}">selected</c:if>>2</option>
      <option <c:if test="${pageSize == 3}">selected</c:if>>3</option>
      <option <c:if test="${pageSize == 5}">selected</c:if>>5</option>
      <option <c:if test="${pageSize == 10}">selected</c:if>>10</option>
    </select>
  </div>

  <c:forEach var="vo" items="${vos}" varStatus="st">
    <div class="guest-message">
      <div class="d-flex justify-content-between">
        <h5>${vo.name}</h5>
        <small>${fn:substring(vo.visitDate,0,19)}</small>
      </div>
      <p>${fn:replace(vo.content, newLine, "<br/>")}</p>
      <div class="text-right">
        <a href="javascript:showModal(${vo.idx})" class="btn btn-sm btn-outline-danger">삭제</a>
      </div>
    </div>
  </c:forEach>

  <!-- 페이지네이션 -->
  <nav aria-label="Page navigation" class="mt-5">
    <ul class="pagination justify-content-center">
      <c:if test="${pag > 1}"><li class="page-item"><a class="page-link" href="guestList?pag=1&pageSize=${pageSize}">처음</a></li></c:if>
      <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link" href="guestList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전</a></li></c:if>
      <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
        <c:if test="${i <= totPage}">
          <li class="page-item ${i == pag ? 'active' : ''}"><a class="page-link" href="guestList?pag=${i}&pageSize=${pageSize}">${i}</a></li>
        </c:if>
      </c:forEach>
      <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link" href="guestList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음</a></li></c:if>
      <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link" href="guestList?pag=${totPage}&pageSize=${pageSize}">마지막</a></li></c:if>
    </ul>
  </nav>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteModalLabel">삭제 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        현재 방문글을 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <a id="deleteConfirmBtn" class="btn btn-danger" href="#">삭제</a>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>

