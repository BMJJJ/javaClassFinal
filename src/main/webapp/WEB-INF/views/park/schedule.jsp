<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>산책로 일정</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <style>
    body {
      background-color: #e8f5e9; /* 연한 초록색 배경 */
      font-family: 'Nanum Gothic', sans-serif;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 20px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    #td1,#td8,#td15,#td22,#td29,#td36 {color:#ff6b6b;} /* 일요일 색상 */
    #td7,#td14,#td21,#td28,#td35 {color:#4dabf7;} /* 토요일 색상 */
    .today {
      background-color: #81c784; /* 초록색 계열로 변경 */
      color: #fff;
      font-weight: bolder;
    }
    td {
      text-align: left;
      vertical-align: top;
      transition: background-color 0.3s;
    }
    td:hover {
      background-color: #c8e6c9; /* 연한 초록색 호버 효과 */
    }
    .btn-secondary {
      background-color: #66bb6a; /* 버튼 색상 변경 */
      border-color: #66bb6a;
    }
    .btn-secondary:hover {
      background-color: #4caf50;
      border-color: #4caf50;
    }
    .table-bordered {
      border: 2px solid #81c784;
    }
    .table th {
      background-color: #66bb6a !important;
      color: white !important;
    }
    .month-title {
      color: #2e7d32;
      font-weight: bold;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="text-center">
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도">◁◁</button>
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월">◀</button>
    <span class="month-title">${yy}년 ${mm+1}월 산책로 일정</span>
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월">▶</button>
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도">▷▷</button>
    &nbsp;&nbsp;
    <button type="button" onclick="location.href='${ctp}/park/schedule';" class="btn btn-secondary btn-sm" title="오늘날짜"><i class="fa fa-leaf"></i></button>
  </div>
  <br/>
  <div class="text-center">
    <table class="table table-bordered" style="height:450px">
      <tr class="text-center" style="background-color:#e8f5e9">
        <th style="width:13%; color:red; vertical-align:middle">일</th>
        <th style="width:13%; vertical-align:middle">월</th>
        <th style="width:13%; vertical-align:middle">화</th>
        <th style="width:13%; vertical-align:middle">수</th>
        <th style="width:13%; vertical-align:middle">목</th>
        <th style="width:13%; vertical-align:middle">금</th>
        <th style="width:13%; color:blue; vertical-align:middle">토</th>
      </tr>
      <tr>
        <c:set var="cnt" value="${1}"/>
        <c:forEach var="preDay" begin="${preLastDay-(startWeek-2)}" end="${preLastDay}">
          <td style="color:#ccc;font-size:0.6em">${prevYear}-${prevMonth+1}-${preDay}</td>
          <c:set var="cnt" value="${cnt+1}"/>
        </c:forEach>
        <br/>
        <c:forEach var="i" begin="0" end="${fn:length(nationalVos)-1}">
          ${nationalVos[i].part}(${nationalVos[i].partCnt}) /
        </c:forEach>(날짜를 클릭하면 산책로를 예약할 수 있습니다.)
        <c:forEach begin="1" end="${lastDay}" varStatus="st">
          <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
          <td id="td${cnt}" ${todaySw==1 ? 'class=today' : ''} style="font-size:0.9em">
            <c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/>
            <a href="${ctp}/park/parkList?ymd=${ymd}">${st.count}<br/><br/>
              <c:if test="${!empty noneVos}">
                <c:forEach var="j" begin="0" end="${fn:length(noneVos)-1}">
                  <c:set var="nalja" value="${fn:substring(noneVos[j].noneDate,8,10)}"/>
                  <c:set var="no" value="${nalja}"/>
                  <c:if test="${fn:substring(nalja,0,1)=='0'}"><c:set var="no" value="${fn:substring(nalja,1,2)}"/></c:if>
                  <c:if test="${st.count == no}">폐쇄 구간 : ${noneVos[j].partCnt}</c:if>
                </c:forEach>
              </c:if>
            </a>
          </td>
          <c:if test="${cnt % 7 == 0}"></tr><tr></c:if>
          <c:set var="cnt" value="${cnt + 1}"/>
        </c:forEach>
        
        <c:if test="${nextStartWeek != 1}">
          <c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
            <td style="color:#ccc;font-size:0.6em">${nextYear}-${nextMonth+1}-${nextDay.count}</td>
          </c:forEach>
        </c:if>
      </tr>
    </table>
  </div>
</div>
<p><br/></p>
</body>
</html>