<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항 리스트</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Noto Sans KR', sans-serif;
    }
    .container {
      max-width: 800px;
      margin: 30px auto;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      padding: 30px;
    }
    h2 {
      color: #343a40;
      text-align: center;
      margin-bottom: 30px;
    }
    .btn-custom {
      background-color: #6c757d;
      color: #fff;
      border: none;
      border-radius: 5px;
      padding: 10px 20px;
      transition: all 0.3s ease;
    }
    .btn-custom:hover {
      background-color: #5a6268;
      transform: translateY(-2px);
    }
    .notify-item {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      margin-bottom: 20px;
      overflow: hidden;
    }
    .notify-header {
      background-color: #e9ecef;
      padding: 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .notify-title {
      font-weight: bold;
      color: #495057;
    }
    .notify-content {
      padding: 20px;
      background-color: #fff5ee;
    }
    .notify-date {
      font-size: 0.9em;
      color: #6c757d;
    }
    .custom-control-input:checked ~ .custom-control-label::before {
      border-color: #28a745;
      background-color: #28a745;
    }
  </style>
  <script>
    $(document).ready(function() {
      $(".popupSw").change(function() {
        var popupCheck = $(this).is(":checked");
        var popupSw = popupCheck ? "Y" : "N";
        var idx = $(this).data('idx');
        var query = {
          idx : idx,
          popupSw : popupSw
        };
        
        $.ajax({
          url : "${ctp}/notify/popupCheck",
          type : "get",
          data : query,
          success : function(data) {
            Swal.fire({
              icon: 'success',
              title: popupSw == "Y" ? '팝업창으로 열립니다.' : '팝업창에서 닫힙니다.',
              text: data.idx + "번 공지사항이 변경되었습니다.",
            });
            $("#notifyContent").load("${ctp}/notify/notifyList #notifyContent");
          },
          error : function() {
            Swal.fire('오류', '작업 수행 중 오류가 발생했습니다.', 'error');
          }
        });
      });
    });
  
    function notifyDelCheck(idx) {
      Swal.fire({
        title: '공지사항 삭제',
        text: "정말로 이 공지사항을 삭제하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '네, 삭제합니다',
        cancelButtonText: '취소'
      }).then((result) => {
        if (result.isConfirmed) {
          $.ajax({
            url : "${ctp}/notify/notifyDelete",
            type : "get",
            data : {idx : idx},
            success : function(data) {
              if(data == "1") {
                Swal.fire('삭제 완료', '공지사항이 삭제되었습니다.', 'success');
                $("#notifyContent").load("${ctp}/notify/notifyList #notifyContent");
              }
              else {
                Swal.fire('삭제 실패', '공지사항 삭제에 실패했습니다.', 'error');
              }
            },
            error : function() {
              Swal.fire('서버 오류', '서버 오류로 인해 삭제에 실패했습니다.', 'error');
            }
          });
        }
      });
    }
  </script>
</head>
<body>
<div class="container">
  <h2>공지사항 리스트</h2>
  <div class="text-right mb-4">
    <button type="button" class="btn btn-custom" onClick="location.href='${ctp}/notify/notifyInput'">공지사항 작성</button>
  </div>
  <div id="notifyContent">
    <c:forEach var="vo" items="${vos}">
      <div class="notify-item">
        <div class="notify-header">
          <span class="notify-title">[${vo.idx}.공지] ${vo.title}</span>
          <div>
            <button type="button" class="btn btn-sm btn-custom" onclick="location.href='${ctp}/notify/notifyUpdate?idx=${vo.idx}';">수정</button>
            <button type="button" class="btn btn-sm btn-custom" onclick="notifyDelCheck('${vo.idx}')">삭제</button>
            <div class="custom-control custom-switch d-inline-block ml-2">
              <input type="checkbox" class="custom-control-input popupSw" id="popupSw${vo.idx}" 
                     ${vo.popupSw eq 'Y' ? 'checked' : ''} data-idx="${vo.idx}">
              <label class="custom-control-label" for="popupSw${vo.idx}">팝업</label>
            </div>
          </div>
        </div>
        <div class="notify-content">
          <p>${fn:replace(vo.content,newLine,'<br/>')}</p>
          <p class="notify-date">게시일 : ${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</p>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
</body>
</html>