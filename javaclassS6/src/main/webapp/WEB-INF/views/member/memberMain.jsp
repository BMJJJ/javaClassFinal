<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Page</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <!-- <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet"> -->
  <style>
    body {
      background-color: #f0f4f0;
      color: #343a40;
    }
    .container {
      background-color: #ffffff;
      padding: 40px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-radius: 12px;
      margin-top: 50px;
    }
    h2 {
      font-weight: 700;
      margin-bottom: 30px;
    }
    h5 {
      color: #6c757d;
      font-weight: 600;
    }
    .profile-img {
      transition: transform 0.3s ease;
      border: 2px solid black;
      width: 100%; /* Ensure image width matches the table width */
      max-width: 250px; /* Optionally set a max-width to keep it from getting too large */
      border-radius: 5px;
    }
    .profile-img:hover {
      transform: scale(1.05);
    }
    .stats p {
      font-size: 1.1rem;
      margin-bottom: 15px;
    }
    .table {
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }
    .table thead {
      background-color: #f1f3f5;
    }
    .activity-icon {
      font-size: 1.5rem;
      margin-right: 10px;
      color: #007bff;
    }
    .footer {
      margin-top: 40px;
      padding-top: 20px;
      border-top: 1px solid #dee2e6;
    }
    .badge {
      padding-top: 10px;
    }
  </style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/nav.jsp" />
  <div class="container">
    <h2 class="text-center mb-4">My Page</h2>
    <c:if test="${!empty sLogin}">
      <div class="alert alert-warning text-center" role="alert">
        <i class="fas fa-exclamation-triangle mr-2"></i>
        현재 임시비밀번호를 발급하여 메일로 전송처리 되어 있습니다.<br/>
        개인정보를 확인하시고, 비밀번호를 새로 변경해 주세요
      </div>
    </c:if>
    <div class="row align-items-center mb-4">
      <div class="col-md-4 text-center mb-3 mb-md-0">
        <img src="${ctp}/member/${mVo.photo}" class="profile-img" alt="Profile Image"/>
      </div>
      <div class="col-md-8">
        <h4 class="mb-3"><b>${sNickName}</b>님의 등급은 <span class="badge badge-pill badge-dark">${strLevel}</span> 입니다.</h4>
        <table class="table table-bordered table-hover">
          <tbody>
            <tr>
              <th scope="row" width="40%">회원가입일</th>
              <td>${fn:substring(mVo.startDate, 0, 10)}</td>
            </tr>
            <tr>
              <th scope="row">총 방문횟수</th>
              <td>${mVo.visitCnt} 회</td>
            </tr>
            <tr>
              <th scope="row">총 보유 포인트</th>
              <td>${mVo.point} 점</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="mb-4">
      <h5 class="mb-3">활동 내역</h5>
      <div class="row">
        <div class="col-md-4 mb-2">
          <a href="${ctp}/guest/guestList"><p><i class="fas fa-book activity-icon"></i>방명록에 올린 글 수: <b>${guestCnt}</b> 건</p></a>
        </div>
        <div class="col-md-4 mb-2">
          <a href="${ctp}/board/boardList"><p><i class="fas fa-clipboard activity-icon"></i>게시판에 올린 글 수: <b>${boardCnt}</b> 건</p></a>
        </div>
        <div class="col-md-4 mb-2">
          <a href="${ctp}/pds/pdsList"><p><i class="fas fa-file-alt activity-icon"></i>자료실에 올린 글 수: <b>${pdsCnt}</b> 건</p></a>
        </div>
      </div>
    </div>
    <div class="footer text-center">
      <jsp:include page="/WEB-INF/views/include/footer.jsp" />
    </div>
  </div>
</body>
</html>
