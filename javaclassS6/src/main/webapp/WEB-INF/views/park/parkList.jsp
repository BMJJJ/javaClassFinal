<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>탐방로 예약</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    #td1,#td8,#td15,#td22,#td29,#td36 {color:red}
    #td7,#td14,#td21,#td28,#td35 {color:blue}
  
    .today {
      background-color: pink;
      color: #fff;
      font-weight: bolder;
    }
    .card {
      margin: 10px;
      width: 18rem;
    }
    .card-body {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
    .card-img-top {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }
    .card-title {
      font-weight: bold;
      margin-bottom: 10px;
    }
    .row {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
    }
    .btn-nature {
      background-color: #28a745;
      color: white;
      border: none;
      transition: all 0.3s;
    }
    .modal-img {
      max-width: 100%;
      max-height: 50vh;
      object-fit: contain;
    }
    .modal-dialog {
      max-width: 90%;
      margin: 1.75rem auto;
    }
    .modal-content {
      border-radius: 0.5rem;
    }
    .modal-header {
      border-bottom: none;
    }
    .modal-body {
      padding: 2rem;
    }
    .modal-info {
      margin-top: 1rem;
      text-align: left;
    }
    .modal-info h6 {
      margin-bottom: 0.5rem;
      color: #6c757d;
    }
    .modal-info p {
      margin-bottom: 1rem;
    }
    @media (max-width: 768px) {
      .card {
        width: 100%;
      }
      .modal-dialog {
        max-width: 95%;
      }
    }
  </style>
  <script>
  	'use strict';
  	
  	function partCheck() {
    	let part = $("#part").val();
    	location.href = "parkList?part="+part;
    }
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<hr/>
<p><br/><p>
<div class="container">
  <h2 class="text-center">산책로 예약</h2>
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
  <a href="parkInput" class="btn btn-nature">새장소 올리기</a>
  <a href="parkUpdate" class="btn btn-nature">장소 수정하기</a>
<!--   <form method="post" name="myform" action="scheduleInput"> -->
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
              사진 보기
            </button>
            <div>
            	현재 예약 현황 : ${visitCnt} / 방문정원 : ${vo.NPeople}
            </div> 
            <input type="button" value="예약하기" onclick="location.href='scheduleInput?mid=${sMid}&ymd=${ymd}&idx=${vo.idx}'" class="btn btn-success mt-2"/>
          </div>
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="photoModal${st.index}" tabindex="-1" role="dialog" aria-labelledby="photoModalLabel${st.index}" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="photoModalLabel${st.index}">${vo.title}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="modal-img-container text-center">
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
    <%-- 
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="ymd" value="${ymd}">
  </form> --%>
</div>
<p><br/><p>
</body>
</html>