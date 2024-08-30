<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>장소 수정</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function parkDelete(idx) {
      let ans = confirm("선택한 장소를 삭제하시겠습니까?");
      if (!ans) return false;
      
      $.ajax({
        url: "${ctp}/park/parkDelete",
        type: "post",
        data: { idx: idx },
        success: function(res) {
          if (res != "0") {
            alert("장소가 삭제되었습니다.");
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
<p><br/></p>
<div class="container">
  <h2 class="text-center">장소 수정</h2>
  <table class="table table-hover">
    <thead>
      <tr>
        <th>번호</th>
        <th>코스</th>
        <th>제목</th>
        <th>수정</th>
        <th>삭제</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr>
          <td>${st.count}</td>
          <td>${vo.course}</td>
          <td>${vo.title}</td>
          <td><a href="${ctp}/park/parkUpdateForm?idx=${vo.idx}" class="btn btn-warning btn-sm">수정</a></td>
          <td><a href="javascript:parkDelete(${vo.idx})" class="btn btn-danger btn-sm">삭제</a></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
<p><br/></p>
</body>
</html>