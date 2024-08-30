<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>산책로 이야기</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f4f8;
      color: #2c3e50;
      background-image: url('${ctp}/images/nature-background.jpg');
      background-size: cover;
      background-attachment: fixed;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      margin-top: 30px;
    }
    h2 {
      color: #2ecc71;
      text-align: center;
      margin-bottom: 30px;
      font-weight: 700;
      text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
    }
    .table {
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }
    .table th {
      background-color: #2ecc71;
      color: white;
      border: none;
    }
    .table td {
      border: none;
      vertical-align: middle;
    }
    .table-hover tbody tr:hover {
      background-color: #e8f5e9;
    }
    .btn-nature {
      background-color: #27ae60;
      color: white;
      border: none;
      transition: all 0.3s;
    }
    .btn-nature:hover {
      background-color: #219a52;
      color: white;
    }
    .pagination .page-link {
      color: #27ae60;
    }
    .pagination .page-item.active .page-link {
      background-color: #27ae60;
      border-color: #27ae60;
    }
    .search-form {
      background-color: rgba(46, 204, 113, 0.1);
      padding: 20px;
      border-radius: 10px;
      margin-top: 20px;
    }
    .modal-header {
      background-color: #27ae60;
      color: white;
    }
    .new-icon {
      width: 20px;
      height: 20px;
      vertical-align: text-top;
    }
    select.form-control {
      border-color: #27ae60;
    }
    .badge-nature {
      background-color: #27ae60;
      color: white;
    }
  </style>
  <script>
    'use strict';
    
    function partCheck() {
      let part = $("#part").val();
      location.href = "boardList?pag=${pag}&pageSize=${pageSize}&part="+part;
    }
    
    function pageSizeCheck() {
      let pageSize = $("#pageSize").val();
      location.href = "boardList?pageSize="+pageSize;
    }
    
    function modalCheck(idx, hostIp, mid, nickName) {
      $("#myModal #modalHostIp").text(hostIp);
      $("#myModal #modalMid").text(mid);
      $("#myModal #modalNickName").text(nickName);
      $("#myModal #modalIdx").text(idx);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>🌿 산책로 이야기</h2>
  <div class="d-flex justify-content-between mb-3">
    <form name="partForm">
      <select name="part" id="part" onchange="partCheck()" class="form-control">
        <option ${part=="전체게시판" ? "selected" : ""}>전체게시판</option>
        <option ${part=="자유게시판" ? "selected" : ""}>자유게시판</option>
        <option ${part=="공지사항" ? "selected" : ""}>공지사항</option>
      </select>
    </form>
    <c:if test="${sLevel != 3}"><a href="boardInput" class="btn btn-nature">🖊️ 새 글 쓰기</a></c:if>
  </div>
  <div class="table-responsive">
    <table class="table table-hover">
      <thead>
        <tr>
          <th>번호</th>
          <th>분류</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>조회수(좋아요)</th>
        </tr>
      </thead>
      <tbody>
        <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
        <c:forEach var="vo" items="${vos}" varStatus="st">
          <tr>
            <td>${curScrStartNo}</td>
            <td><span class="badge badge-nature">${vo.part}</span></td>
            <td>
              <a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="text-dark">${vo.title}</a>
              <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" class="new-icon" alt="New" /></c:if>  
              <c:if test="${vo.replyCnt != 0}"><span class="badge badge-secondary">${vo.replyCnt}</span></c:if>
            </td>
            <td>
              ${vo.nickName}
              <c:if test="${sLevel == 0}">
                <a href="#" onclick="modalCheck('${vo.idx}','${vo.hostIp}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal" class="badge badge-info">상세</a>
              </c:if>
            </td>
            <td>
              ${vo.date_diff == 0 ? fn:substring(vo.WDate,11,16) : fn:substring(vo.WDate,0,10)}
            </td>
            <td>${vo.readNum}(${vo.good})</td>
          </tr>
          <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
        </c:forEach>
      </tbody>
    </table>
  </div>
  
  <!-- 페이지네이션 -->
  <div class="d-flex justify-content-center">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="boardList?pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
    </ul>
  </div>
  
  <!-- 검색 폼 -->
  <div class="search-form">
    <form name="searchForm" method="post" action="boardSearch" class="form-inline justify-content-center">
      <select name="search" id="search" class="form-control mr-2">
        <option value="title">제목</option>
        <option value="nickName">작성자</option>
        <option value="content">내용</option>
      </select>
      <input type="text" name="searchString" id="searchString" class="form-control mr-2" required />
      <input type="submit" value="🔍 검색" class="btn btn-nature"/>
      <input type="hidden" name="pag" value="${pageVO.pag}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div>
</div>
<!-- 모달 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">작성자 정보</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <p>고유번호: <span id="modalIdx"></span></p>
        <p>아이디: <span id="modalMid"></span></p>
        <p>닉네임: <span id="modalNickName"></span></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>