<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나의 예약 목록</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      color: #333;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 50px;
    }
    h2 {
      color: #0c7b93; /* 깊은 바다색 */
      margin-bottom: 20px;
    }
    .table {
      background-color: #fff;
      border-radius: 8px;
      overflow: hidden;
    }
    .table thead {
      background-color: #00b4d8; /* 밝은 하늘색 */
      color: #fff;
    }
    .table-bordered {
      border: 1px solid #a2d2ff;
    }
    .table-bordered th,
    .table-bordered td {
      border: 1px solid #a2d2ff;
    }
    .btn-warning {
      background-color: #ffd166; /* 밝은 노란색 */
      border: none;
      color: #333;
    }
    .btn-warning:hover {
      background-color: #ffc300;
      color: #333;
    }
    .btn-danger {
      background-color: #ff6b6b; /* 밝은 빨간색 */
      border: none;
    }
    .btn-danger:hover {
      background-color: #ff4757;
    }
  </style>
  <script>
    'use strict';
    
    // 예약 삭제하기
    function scheduleDelete(idx) {
      let ans = confirm("선택한 예약을 삭제하시겠습니까?");
      if (!ans) return false;
      $.ajax({
        url: "${ctp}/park/scheduleDelete",
        type: "post",
        data: { idx: idx },
        success: function(res) {
          if (res != "0") {
            alert("예약이 삭제되었습니다.");
            location.reload();
          } else {
            alert("삭제 실패~~");
          }
        },
        error: function() {
          alert("전송 오류!");
        }
      });
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container mt-5">
  <h2 class="text-center mb-4">나의 예약 목록</h2>
  <table class="table table-bordered table-hover">
    <thead>
      <tr class="text-center">
        <th>코스</th>
        <th>방문일자</th>
        <th>인원</th>
        <th>수정/삭제</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="vo" items="${vos}">
        <tr class="text-center">
          <td>${vo.course}</td>
          <td>${fn:substring(vo.visitDate, 0, 10)}</td>
          <td>${vo.visitCnt}</td>
          <td>
            <a href="${ctp}/park/scheduleUpdate?idx=${vo.idx}" class="btn btn-sm btn-warning">수정</a>
            <a href="javascript:scheduleDelete(${vo.idx})" class="btn btn-sm btn-danger">삭제</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>