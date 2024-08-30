<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminLeft.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #343a40;
      color: #ffffff;
      font-family: Arial, sans-serif;
    }
    .sidebar {
      width: 250px;
      height: 100vh;
      padding: 20px 0;
    }
    .menu-item {
      padding: 10px 20px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .menu-item:hover, .menu-item.active {
      background-color: #495057;
    }
    .menu-item i {
      margin-right: 10px;
    }
    .submenu {
      padding-left: 40px;
      display: none;
    }
    .submenu a {
      color: #adb5bd;
      text-decoration: none;
      display: block;
      padding: 5px 0;
    }
    .submenu a:hover {
      color: #ffffff;
    }
    .badge {
      float: right;
      background-color: #007bff;
    }
    a:hover{
      text-decoration: none;
      color: inherit;
    }
  </style>
</head>
<body>
<div class="sidebar">
  <a href="${ctp}/admin/adminMain" target="_top"><div class="menu-item">
    <i class="fas fa-store"></i> 관리자메인화면
  </div></a>
  <div class="menu-item active">
    <i class="fas fa-th"></i> 대시보드
  </div>
  <a href="${ctp}/" target="_top"><div class="menu-item">
    <i class="fas fa-paint-brush"></i> 홈으로
  </div></a>
  <div class="menu-item">
    <i class="fas fa-users"></i> 사용자 관리 <span class="badge"></span>
  </div>
  <div class="submenu">
    <a href="${ctp}/admin/member/memberList"target="adminContent">회원 목록</a>
    <a href="${ctp}/admin/board/complaintList"target="adminContent">게시판 신고</a>
    <a href="${ctp}/webSocket/webSocket"target="adminContent">1대1 문의 채팅방</a>
  </div>
  <a href="${ctp}/mapandweather/mapPlus" target="adminContent"><div class="menu-item">
    <i class="fas fa-map"></i> 맵추가
  </div></a>
  <div class="menu-item">
    <i class="fas fa-question-circle"></i> 고객지원
  </div>
</div>
<script>
  document.querySelectorAll('.menu-item').forEach(item => {
    item.addEventListener('click', function() {
      this.classList.toggle('active');
      let submenu = this.nextElementSibling;
      if(submenu && submenu.classList.contains('submenu')) {
        if (submenu.style.display === "block") {
          submenu.style.display = "none";
        } else {
          submenu.style.display = "block";
        }
      }
    });
  });
</script>
</body>
</html>