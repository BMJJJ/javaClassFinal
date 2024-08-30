<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>지점 수정/삭제</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function mapUpdate(address) {
      let ans = confirm("선택한 지점을 수정하시겠습니까?");
      if (!ans) return false;
      
      location.href = "${ctp}/mapandweather/mapUpdateForm?address=" + encodeURIComponent(address);
    }
    
    function mapDelete(address) {
      let ans = confirm("선택한 지점을 삭제하시겠습니까?");
      if (!ans) return false;
      
      $.ajax({
        url: "${ctp}/mapandweather/addressDelete",
        type: "post",
        data: { address: address },
        success: function(res) {
          if (res == "1") {
            alert("지점이 삭제되었습니다.");
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
  <h2 class="text-center">지점 수정/삭제</h2>
  <table class="table table-hover">
    <thead>
      <tr>
        <th>번호</th>
        <th>지점명</th>
        <th>위도</th>
        <th>경도</th>
        <th>수정</th>
        <th>삭제</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="vo" items="${addressVos}" varStatus="st">
        <tr>
          <td>${st.count}</td>
          <td>${vo.address}</td>
          <td>${vo.latitude}</td>
          <td>${vo.longitude}</td>
          <td><a href="javascript:mapUpdate('${vo.address}')" class="btn btn-warning btn-sm">수정</a></td>
          <td><a href="javascript:mapDelete('${vo.address}')" class="btn btn-danger btn-sm">삭제</a></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
<p><br/></p>
</body>
</html>