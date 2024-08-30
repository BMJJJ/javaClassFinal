<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 대시보드</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body, html { 
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa; 
        }
        .main-container {
            width: 100%;
            min-height: 100vh;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .card { border: none; box-shadow: 0 0 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .chart-container { height: 300px; }
    </style>
</head>
<body>
<div class="main-container">
    <h1 class="mb-4">관리자 대시보드</h1>

    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">사용자 관리</h5>
                    <ul class="list-group">
                        <li class="list-group-item"><a href="${ctp}/admin/member/memberList" target="adminContent">회원 목록</a></li>
                        <li class="list-group-item"><a href="${ctp}/admin/board/complaintList" target="adminContent">게시판 신고</a></li>
                        <li class="list-group-item"><a href="${ctp}/webSocket/webSocket" target="adminContent">1대1 문의 채팅방</a></li>
                        <li class="list-group-item"><a href="${ctp}/qna/qnaList" target="adminContent">QnA</a></li>
                        <li class="list-group-item"><a href="${ctp}/notify/notifyList" target="adminContent">공지 사항</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">산책로 관리</h5>
                    <ul class="list-group">
                        <li class="list-group-item"><a href="${ctp}/mapandweather/mapPlus" target="adminContent">추천 장소 올리기</a></li>
                        <li class="list-group-item"><a href="${ctp}/park/parkInput" target="adminContent">산책로 장소 올리기</a></li>
                        <li class="list-group-item"><a href="${ctp}/park/parkList" target="adminContent">산책로 장소 보기</a></li>
                        <li class="list-group-item"><a href="${ctp}/park/parkUpdate" target="adminContent">산책로 장소 수정하기</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">방문자 통계</h5>
            <div class="chart-container">
                <!-- 여기에 방문자 통계 차트를 추가할 수 있습니다 -->
                <p>방문자 통계 차트가 이 곳에 표시됩니다.</p>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">최근 활동</h5>
            <ul class="list-group">
                <li class="list-group-item">새로운 회원 가입: 3명</li>
                <li class="list-group-item">새로운 게시글: 10개</li>
                <li class="list-group-item">새로운 댓글: 25개</li>
                <li class="list-group-item">새로운 문의: 5개</li>
            </ul>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>