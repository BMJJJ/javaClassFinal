<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>popup.jsp(여름 공지사항 팝업창)</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      background-image: url('${ctp}/resources/images/summer_bg.jpg');
      background-size: cover;
      font-family: 'Arial', sans-serif;
    }
    .modal-content {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }
    .modal-header {
      background-color: #87CEEB;
      color: white;
      border-top-left-radius: 15px;
      border-top-right-radius: 15px;
    }
    .modal-body {
      color: #00008B;
    }
    .modal-footer {
      background-color: #87CEEB;
      border-bottom-left-radius: 15px;
      border-bottom-right-radius: 15px;
    }
    .btn-summer {
      background-color: #FF6347;
      color: white;
      border: none;
      padding: 5px 10px;
      border-radius: 5px;
      cursor: pointer;
    }
    .btn-summer:hover {
      background-color: #FF4500;
    }
  </style>
  <script>
  function closePopup() {
  	if(document.getElementById("check").value) {
  		setCookie("popupYN${vo.idx}","N",1);
  		self.close();
  	}
  }
  
  // 유효시간 1일 : todayDate.setTime(todayDate.getTim() + (expiredays * 24 * 60 * 60 * 1000))
  // 유효시간 1분 : todayDate.setMinutes(todayDate.getMinutes() + expiredays)
  // setCookie(쿠키명, 쿠키값, 쿠키유효시간)
  function setCookie(name, value, expiredays) {		// (popupYN고유번호,Y또는N,1일)
  	var date = new Date();
  	date.setDate(date.getDate() + expiredays);
  	document.cookie = escape(name) + "=" + escape(value) + "; expires="+date.toUTCString()+"; path=${ctp}";	// 쿠키에 편집한 값들을 저장한다.
  }
  
  //공지사항 전체 보기
  function notifyView() {
  	opener.location.href = "${ctp}/notify/topNoticeList";
  	window.close();
  }
  </script>
</head>
<body>
<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <!-- Modal Header -->
    <div class="modal-header">
      <h4 class="modal-title"><b>🌴 ${vo.title} 🌞</b></h4>
      <button type="button" class="close" onclick="window.close()">&times;</button>
    </div>
    <!-- Modal body -->
    <div class="modal-body">
      ${fn:replace(vo.content, newLine, '<br/>')}
    </div>
    <hr/>
    <div class="pl-2">
      <p><b>🏖️ 여름 공지사항 게시기간 🏖️</b></p>
      <p>${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</p>
    </div>
    <hr/>
    <!-- Modal footer -->
    <div class="modal-footer">
      <input type="checkbox" id="check" onclick="closePopup()">
      <font size="3"><b>하루에 한번만 보기</b></font>
      <b>☞ <a href="javascript:notifyView()" class="btn-summer">공지사항</a></b>
    </div>
  </div>
</div>
</body>
</html>