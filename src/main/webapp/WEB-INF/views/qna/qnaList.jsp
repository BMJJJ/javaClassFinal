<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>bList.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link rel="stylesheet" href="/path/to/your/new-styles.css">
  <style>
 body {
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
  color: #3e4e50;
  font-family: 'Nanum Gothic', sans-serif;
}
.container {
  max-width: 935px;
  padding: 20px;
  margin: auto;
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
h2 {
  color: #2f4858;
  font-weight: 600;
  text-align: center;
  margin-bottom: 20px;
}
.table {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}
.table th {
  background-color: #e9ecef;
  color: #495057;
  border: none;
}
.btn-secondary {
  background-color: #6c757d;
  border: none;
  color: #FFFFFF;
  transition: all 0.3s ease;
}
.btn-secondary:hover {
  background-color: #5a6268;
  transform: translateY(-2px);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
.badge-success {
  background-color: #28a745;
}
.badge-danger {
  background-color: #dc3545;
}
.pagination .page-link {
  color: #6c757d;
  background-color: #FFFFFF;
  border-color: #dee2e6;
}
.pagination .page-item.active .page-link {
  background-color: #6c757d;
  border-color: #6c757d;
  color: #FFFFFF;
}
.fas.fa-lock {
  color: #adb5bd;
}
input[type="text"], select {
  border: 1px solid #ced4da;
  border-radius: 5px;
  padding: 8px 12px;
  margin: 5px;
  transition: all 0.3s ease;
}
input[type="text"]:focus, select:focus {
  border-color: #80bdff;
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}
input[type="button"] {
  background-color: #6c757d;
  color: #FFFFFF;
  border: none;
  border-radius: 5px;
  padding: 8px 15px;
  cursor: pointer;
  transition: all 0.3s ease;
}
input[type="button"]:hover {
  background-color: #5a6268;
  transform: translateY(-2px);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
td {
  text-align: center;
}
a {
  color: #6c757d;
  text-decoration: none;
  transition: color 0.3s ease;
}
a:hover {
  color: #495057;
}
.table-hover tbody tr:hover {
  background-color: #f1f3f5;
}
</style>
  <script>
    'use strict';
    
    function sChange() {
      document.searchForm.searchString.focus();
    }
    
    function sCheck() {
      var searchString = document.searchForm.searchString.value;
      if (searchString == "") {
        alert("검색어를 입력하세요");
        document.searchForm.searchString.focus();
      } else {
        document.searchForm.submit();
      }
    }
    
    function contentCheck(idx, title, pwd) {
      if (pwd == '') {
        location.href = "qnaContent?pag=${pageVO.pag}&idx=" + idx + "&title=" + title;
      } else {
        let tempStr = `
          <div style="text-align: center;">
            <label>비밀번호 :</label>
            <input type="password" name="pwd" style="margin-bottom: 10px;"/>
            <br/>
            <input type="button" value="확인" onclick="movingCheck(${idx})" style="margin-right: 10px;"/>
            <input type="button" value="닫기" onclick="location.reload()"/>
          </div>`;
        $("#qna" + idx).html(tempStr);
      }
    }
  </script>
  
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/nav.jsp"/>
  <div class="container">
    <p><br/></p>
    <form name="tempForm">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>QnA 게시판 리스트</h2>
        <input type="button" value="글올리기" onclick="location.href='qnaInput?qnaFlag=q';" class="btn btn-secondary"/>
      </div>
      <table class="table table-hover">
        <thead class="thead-light text-center">
          <tr>
            <th>글번호</th>
            <th></th>
            <th>글제목</th>
            <th>글쓴이</th>
            <th>글쓴날자</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
          <c:forEach var="vo" items="${vos}">
            <tr>
              <td>${curScrStartNo}</td>
              <td class="text-right">
                <c:choose>
                  <c:when test="${vo.qnaAnswer == '답변완료'}">
                    <span class="badge badge-success">${vo.qnaAnswer}</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge badge-danger">
                      <c:choose>
                        <c:when test="${sLevel == 0}">
                          <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.qnaAnswer}</a>
                        </c:when>
                        <c:otherwise>${vo.qnaAnswer}</c:otherwise>
                      </c:choose>
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="text-left">
                <c:if test="${vo.qnaSw == 'a'}">&nbsp;&nbsp; └</c:if>
                <c:choose>
                  <c:when test="${!empty vo.pwd}">
                    <i class="fas fa-lock"></i>
                  </c:when>
                  <c:otherwise>
                    <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
                  </c:otherwise>
                </c:choose>
                <c:if test="${vo.pwd != '' && (sLevel == 0 || sNickName == vo.nickName)}">
                  <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
                </c:if>
                <c:if test="${vo.pwd != '' && sNickName != vo.nickName && sLevel != 0}">
                  ${vo.title}
                </c:if>
                <c:if test="${vo.diffTime <= 24}">
                  <img src="${ctp}/images/new.gif" alt="new"/>
                </c:if>
              </td>
              <td>${vo.nickName}</td>
              <td>
                <c:choose>
                  <c:when test="${vo.diffTime <= 24}">
                    ${fn:substring(vo.WDate, 11, 19)}
                  </c:when>
                  <c:otherwise>
                    ${fn:substring(vo.WDate, 0, 10)}
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
            <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
          </c:forEach>
          <tr>
            <td colspan="5" class="p-0"></td>
          </tr>
        </tbody>
      </table>
    </form>
    <br/>
    <!-- Pagination -->
    <div class="d-flex justify-content-center">
      <c:if test="${pageVO.totPage == 0}">
        <p class="text-center text-danger"><b>자료가 없습니다.</b></p>
      </c:if>
      <c:if test="${pageVO.totPage != 0}">
        <ul class="pagination">
          <c:set var="startPageNum" value="${pageVO.pag - (pageVO.pag-1)%pageVO.blockSize}"/>
          <c:if test="${pageVO.pag != 1}">
            <li class="page-item"><a href="qnaList?pag=1&pageSize=${pageVO.pageSize}" class="page-link">◁◁</a></li>
            <li class="page-item"><a href="qnaList?pag=${pageVO.pag-1}&pageSize=${pageVO.pageSize}" class="page-link">◀</a></li>
          </c:if>
          <c:forEach var="i" begin="0" end="${pageVO.blockSize-1}">
            <c:if test="${(startPageNum+i) <= pageVO.totPage}">
              <c:choose>
                <c:when test="${pageVO.pag == (startPageNum+i)}">
                  <li class="page-item active"><a href="qnaList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}" class="page-link">${startPageNum+i}</a></li>
                </c:when>
                <c:otherwise>
                  <li class="page-item"><a href="qnaList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}" class="page-link">${startPageNum+i}</a></li>
                </c:otherwise>
              </c:choose>
            </c:if>
          </c:forEach>
          <c:if test="${pageVO.pag != pageVO.totPage}">
            <li class="page-item"><a href="qnaList?pag=${pageVO.pag+1}&pageSize=${pageVO.pageSize}" class="page-link">▶</a></li>
            <li class="page-item"><a href="qnaList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link">▷▷</a></li>
          </c:if>
        </ul>
      </c:if>
    </div>
    <br/>
    <!-- Search Form -->
    <div class="d-flex justify-content-center">
      <form name="searchForm" method="get" action="qnaSearch" class="form-inline">
        <b>검색 : </b>
        <select name="search" onchange="sChange()" class="form-control mx-2">
          <option value="title" selected>글제목</option>
          <option value="nickName">글쓴이</option>
          <option value="content">글내용</option>
        </select>
        <input type="text" name="searchString" class="form-control mx-2"/>
        <input type="button" value="검색" onclick="sCheck()" class="btn btn-secondary"/>
        <input type="hidden" name="pag" value="${pageVO.pag}"/>
        <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
      </form>
    </div>
    <p><br/></p>
  </div>
</body>
</html>
