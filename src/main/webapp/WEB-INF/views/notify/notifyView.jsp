<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항(notifyView.jsp)</title>
  <style>
    body {
      background-color: #e8f5e9;
    }
    .modal-content {
      background-color: #f1f8e9;
      border: 1px solid #a5d6a7;
    }
    .modal-header {
      background-color: #c8e6c9;
      color: #1b5e20;
    }
    .modal-body {
      color: #2e7d32;
    }
    .modal-footer {
      background-color: #c8e6c9;
    }
    input[type="button"] {
      background-color: #4caf50;
      color: white;
      border: none;
      padding: 5px 10px;
      cursor: pointer;
    }
    input[type="button"]:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
<p><br/></p>
<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
  
    <div class="modal-header">
      <h4>${vo.title}</h4>
      <button type="button" class="close" data-dismiss="modal" onclick="window.close()">&times;</button>
    </div>
    
    <div class="modal-body">
      ${fn:replace(vo.content, newLine, "<br/>")}
    </div>
    <hr size="5"/>
    <div style="padding:0px 20px">
      <p>공지사항 게시기간</p>
      <p>${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</p>
    </div>
    <hr/>
    <div class="modal-footer">
      <input type="button" value="닫기" onclick="window.close()"/>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>