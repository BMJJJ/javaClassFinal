<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>포토 갤러리</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
  <style>
    body {
    	font-family: "Karma", sans-serif !important;
      background-color: #f8f9fa;
    }
    .container {
      max-width: 1200px;
      padding: 2rem;
    }
    h2 {
      color: #343a40;
      margin-bottom: 2rem;
      font-weight: 700;
    }
    .card {
      transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
      border: none;
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 2rem;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .card-body {
		  padding: 0;
		  position: relative;
		}
		.multiple-indicator {
		  position: absolute;
		  top: 10px;
		  right: 10px;
		  background-color: rgba(255, 255, 255, 0.7);
		  border-radius: 50%;
		  width: 30px;
		  height: 30px;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		}
		.multiple-indicator i {
		  color: #3cb371;
		  font-size: 1.2rem;
		}
    .card-body img {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }
    .card-footer {
      background-color: #fff;
      border-top: none;
      padding: 1rem;
    }
    .card-footer .row {
      font-size: 0.9rem;
    }
    .btn-custom {
     background-color: #A98467; 
     color: white;
     border: none;
     padding: 0.5rem 1rem 0.1rem;
     border-radius: 20px;
     transition: background-color 0.3s ease;
     display: inline-block; /* 요소를 인라인 블록으로 만듦 */
     text-align: center; /* 텍스트를 중앙으로 정렬 */
     vertical-align: middle; /* 요소를 수직으로 가운데 정렬 */
     line-height: 1.5; /* 버튼 높이와 일치하는 줄 높이 설정 */
		}
    .btn-custom:hover {
      background-color: #6C584C;
      color: white;
    }
    #list-wrap {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 1.5rem;
    }
    .search-container {
      background-color: white;
      padding: 1rem;
      border-radius: 20px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      margin-bottom: 2rem;
    }
    .search-options {
      display: flex;
      align-items: center;
    }
    .search-options select {
      margin-right: 10px;
    }
  </style>
  <script>
  'use strict';
  function photoSearch() {
  	let part = $("#part").val();
  	let choice = $("#choice").val();
  	
  	location.href = "photoGalleryList?part="+part+"&choice="+choice;
  }
  
  
  // 무한 스크롤 구현(aJax처리)
  let lastScroll = 0;
  let curPage = 1;
  
  $(document).scroll(function(){
  	let currentScroll = $(this).scrollTop();			// 스크롤바 위쪽시작 위치, 처음은 0이다.
  	let documentHeight = $(document).height();		// 화면에 표시되는 전체 문서의 높이
  	let nowHeight = $(this).scrollTop() + $(window).height();	// 현재 화면상단 + 현재 화면높이
  	
  	// 스크롤이 아래로 내려갔을때 이벤트 처리..
  	if(currentScroll > lastScroll) {
  		if(documentHeight < (nowHeight + (documentHeight*0.1))) {
  			console.log("다음페이지 가져오기");
  			curPage++;
  			$.ajax({
	    		url  : "${ctp}/photoGallery/photoGalleryPaging",
	    		type : "post",
	    		data : {pag : curPage},
	    		success:function(res) {
	    			$("#list-wrap").append(res);
	    		}
	    	});
  		}
  	}
  	lastScroll = currentScroll;
  });
  
  // 리스트 불러오기 함수(ajax처리)
  function getList(curPage) {
  	$.ajax({
  		url  : "${ctp}/photoGallery/photoGalleryList",
  		type : "post",
  		data : {pag : curPage},
  		success:function(res) {
  			$("#list-wrap").append(res);
  		}
  	});
  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center">Moments</h2>
  
  <div class="search-container">
    <div class="row align-items-center">
      <div class="col-md-8">
        <div class="input-group">
          <select name="part" id="part" class="form-control">
            <option value="전체" ${part == '전체' ? 'selected' : ''}>전체</option>
            <option value="풍경" ${part == '풍경' ? 'selected' : ''}>풍경</option>
            <option value="인물" ${part == '인물' ? 'selected' : ''}>인물</option>
            <option value="음식" ${part == '음식' ? 'selected' : ''}>음식</option>
            <option value="여행" ${part == '여행' ? 'selected' : ''}>여행</option>
            <option value="사물" ${part == '사물' ? 'selected' : ''}>사물</option>
            <option value="기타" ${part == '기타' ? 'selected' : ''}>기타</option>
          </select>
          <select name="choice" id="choice" class="form-control ml-2">
            <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
            <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
            <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
            <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
          </select>
          <div class="input-group-append">
            <button onclick="photoSearch()" class="btn btn-custom">조건검색</button>
          </div>
        </div>
      </div>
      <div class="col-md-4 text-right">
        	<button onclick="location.href='photoGalleryInput';" class="btn btn-custom">사진올리기</button>
        <button onclick="location.href='photoGallerySingle';" class="btn btn-custom ml-2">한장씩보기</button>
      </div>
    </div>
  </div>

  <section id="list-wrap">
  <c:forEach var="vo" items="${vos}" varStatus="st">
    <div class="card">
      <div class="card-body position-relative">
        <a href="photoGallerContent?idx=${vo.idx}">
          <img src="${ctp}/thumbnail/${vo.thumbnail}" alt="${vo.title}" class="img-fluid" />
        </a>
        <c:if test="${vo.photoCount > 1}">
          <div class="multiple-indicator">
            <i class="far fa-clone"></i>
          </div>
        </c:if>
      </div> 
      <div class="card-footer">
        <div class="row text-center">
          <div class="col"><i class="fas fa-comments"></i> ${vo.replyCnt}</div>
          <div class="col"><i class="fas fa-moon"></i> ${vo.good}</div>
          <div class="col"><i class="far fa-eye"></i> ${vo.readNum}</div>
          <div class="col"><i class="fas fa-images"></i> ${vo.photoCount}</div>
        </div>
      </div>
    </div>
  </c:forEach>
</section>
</div>
</body>
</html>