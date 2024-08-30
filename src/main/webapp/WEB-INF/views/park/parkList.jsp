<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>산책로 예약</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  body {
    color: #333;
    background-color: #f0f4f8; /* 연한 하늘색 배경 */
    font-family: 'Nanum Gothic', sans-serif;
  }
  .container {
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
    padding: 30px;
    margin-top: 50px;
  }
  h2 {
    color: #2e7d32; /* 깊은 녹색 */
    margin-bottom: 20px;
  }
  #td1,#td8,#td15,#td22,#td29,#td36 {color:#ff6b6b;}
  #td7,#td14,#td21,#td28,#td35 {color:#4caf50;} /* 녹색으로 변경 */
  .today {
    background-color: #81c784; /* 연한 녹색으로 변경 */
    color: #fff;
    font-weight: bolder;
  }
  .card {
    margin: 10px;
    width: 18rem;
    border: none;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: all 0.3s;
    background-color: #e8f5e9; /* 매우 연한 녹색 배경 */
  }
  .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
  }
  .card-body {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    border-radius: 0 0 8px 8px;
  }
  .card-img-top {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 8px 8px 0 0;
  }
  .card-title {
    font-weight: bold;
    margin-bottom: 10px;
    color: #1b5e20; /* 진한 녹색 */
  }
  .btn-nature {
    background-color: #4caf50; /* 녹색 */
    color: white;
    border: none;
    transition: all 0.3s;
  }
  .btn-nature:hover {
    background-color: #45a049;
  }
  .btn-primary {
    background-color: #66bb6a; /* 연한 녹색 */
    border: none;
  }
  .btn-primary:hover {
    background-color: #57a85a;
  }
  .btn-success {
    background-color: #c5e1a5; /* 매우 연한 녹색 */
    border: none;
    color: #333;
  }
  .btn-success:hover {
    background-color: #aed581;
    color: #333;
  }
  .modal-content {
    border-radius: 12px;
    border: none;
  }
  .modal-header {
    background-color: #e8f5e9;
    border-bottom: none;
    border-radius: 12px 12px 0 0;
  }
  .modal-body {
    padding: 2rem;
    background-color: #fff;
  }
  select.form-control {
    border-color: #a5d6a7;
    color: #2e7d32;
  }
  @media (max-width: 768px) {
    .card {
      width: 100%;
    }
  }
  .modal-dialog {
    max-width: 80%;
    margin: 1.75rem auto;
  }
  .modal-img-container {
    width: 100%;
    max-height: 60vh;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .modal-img-container img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
  }
  .modal-info {
    margin-top: 1rem;
    width: 100%;
    text-align: left;
  }
  @media (max-width: 768px) {
    .modal-dialog {
      max-width: 95%;
    }
  }
  </style>
  <script>
    'use strict';
    
    function partCheck() {
      let part = $("#part").val();
      let ymd = "${ymd}";
      location.href = "parkList?part=" + part + "&ymd=" + ymd; 
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<hr/>
<p><br/><p>
<div class="container">
  <h2 class="text-center">산책로 예약 (${ymd})</h2>
  <div class="d-flex justify-content-between mb-3">
    <form name="partForm">
      <select name="part" id="part" onchange="partCheck()" class="form-control">
        <option ${part=="전체보기" ? "selected" : ""}>전체보기</option>
        <option ${part=="산책로" ? "selected" : ""}>산책로</option>
        <option ${part=="탐방로(산)" ? "selected" : ""}>탐방로(산)</option>
        <option ${part=="탐방로(해안)" ? "selected" : ""}>탐방로(해안)</option>
      </select>
    </form>
  </div>
  <c:if test="${sLevel == 0}"><a href="parkUpdate" class="btn btn-nature">장소 수정하기</a></c:if>
  <a href="mySchedule" class="btn btn-info">나의 예약보기</a>
  <div class="row mt-4">
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <c:set var="visitCnt" value="0" />
      <c:if test="${!empty visitVos}">
        <c:forEach var="i" begin="0" end="${fn:length(visitVos)-1}">
          <c:if test="${vo.course == visitVos[i].course}"><c:set var="visitCnt" value="${visitVos[i].allVisitCnt}"/></c:if>
        </c:forEach>
      </c:if>
      <div class="card">
        <div class="card-body position-relative text-center">
          <h5 class="card-title">${vo.course}</h5>
          <p class="card-text">${vo.title}</p>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#photoModal${st.index}">
            사진 및 설명 보기
          </button>
          <div>
            현재 예약 현황 : ${visitCnt} / 방문정원 : ${vo.NPeople}
          </div>
          <c:set var="sw" value="0"/>
          <c:forEach var="course" items="${courseVos}">
            <c:if test="${vo.course == course}"><c:set var="sw" value="1"/></c:if>
          </c:forEach>
          <c:if test="${sw == 0}"><input type="button" value="예약하기" onclick="location.href='scheduleInput?mid=${sMid}&ymd=${ymd}&idx=${vo.idx}'" class="btn btn-success mt-2"/></c:if>
          <br/>
          <c:if test="${sw != 0}"><font color="red">탐방불가입니다.</font></c:if>
        </div>
      </div>
      
      <div class="modal fade" id="photoModal${st.index}" tabindex="-1" role="dialog" aria-labelledby="photoModalLabel${st.index}" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="photoModalLabel${st.index}">${vo.title}</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="modal-img-container">
                ${vo.photo}
              </div>
              <div class="modal-info">
                <h6>코스</h6>
                <p>${vo.course}</p>
                <h6>상세 정보</h6>
                <p>${vo.content}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
<p><br/><p>
</body>
</html>