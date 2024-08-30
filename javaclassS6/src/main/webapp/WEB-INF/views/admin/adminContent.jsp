<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GLOSHOPPER 관리자 대시보드</title>
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
        .card { border: none; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .status-card { background-color: #f8f9fa; }
        .chart-container { height: 200px; }
        .table-responsive { height: 300px; overflow-y: auto; }
        .btn-group-toggle .btn { margin-right: 5px; }
    </style>
</head>
<body>
<div class="main-container">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">GLOSHOPPER</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <button type="button" class="btn btn-sm btn-danger mr-2">언어/단위설정</button>
            <button type="button" class="btn btn-sm btn-secondary">설치</button>
        </div>
    </div>

    <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card status-card">
                        <div class="card-body">
                            <h5 class="card-title">기본설정</h5>
                            <p class="card-text">1/4개 완료</p>
                            <ul class="list-unstyled">
                                <li><i class="fas fa-check-circle text-success"></i> 사이트 정보 설정하기</li>
                                <li><i class="far fa-circle"></i> 디자인 변경하기</li>
                                <li><i class="far fa-circle"></i> 작업 설정하기</li>
                                <li><i class="far fa-circle"></i> 도메인 연결하기</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 추가 상태 카드들 -->
                <div class="col-md-3">
                    <div class="card status-card">
                        <div class="card-body">
                            <h5 class="card-title">판매하기</h5>
                            <p class="card-text">2/8개 완료</p>
                            <!-- 세부 항목들 -->
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card status-card">
                        <div class="card-body">
                            <h5 class="card-title">성장하기</h5>
                            <p class="card-text">0/7개 완료</p>
                            <!-- 세부 항목들 -->
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card status-card">
                        <div class="card-body">
                            <h5 class="card-title">추천작업</h5>
                            <p class="card-text">0/5개 완료</p>
                            <!-- 세부 항목들 -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">오늘의 할일 <span class="badge badge-danger">1</span></h5>
                    <div class="row">
                        <div class="col-md-2">
                            <p>신규주문 <span class="badge badge-primary">1</span></p>
                        </div>
                        <div class="col-md-2">
                            <p>취소관리 <span class="badge badge-secondary">0</span></p>
                        </div>
                        <!-- 추가 할일 항목들 -->
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">방문자 현황</h5>
                            <div class="btn-group btn-group-toggle mb-3" data-toggle="buttons">
                                <label class="btn btn-sm btn-outline-secondary active">
                                    <input type="radio" name="options" id="option1" checked> 방문자뷰
                                </label>
                                <label class="btn btn-sm btn-outline-secondary">
                                    <input type="radio" name="options" id="option2"> 방문자
                                </label>
                            </div>
                            <div class="chart-container">
                                <!-- 차트가 들어갈 자리 -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">일자별 요약</h5>
                            <div class="table-responsive">
                                <table class="table table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>일자</th>
                                            <th>주문수</th>
                                            <th>매출액</th>
                                            <th>방문자</th>
                                            <th>가입</th>
                                            <th>문의</th>
                                            <th>후기</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>2020-11-23</td>
                                            <td>0</td>
                                            <td>0원</td>
                                            <td>0</td>
                                            <td>0</td>
                                            <td>0</td>
                                            <td>0</td>
                                        </tr>
                                        <!-- 추가 행들 -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
//방문자 현황 차트
var ctx = document.createElement('canvas').getContext('2d');
$('.chart-container').append(ctx.canvas);
new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['11-17', '11-18', '11-19', '11-20', '11-21', '11-22', '11-23'],
        datasets: [{
            label: '방문자 수',
            data: [7, 8, 10, 11, 13, 15, 17],
            borderColor: 'rgb(255, 99, 132)',
            tension: 0.1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
</script>
</body>
</html>