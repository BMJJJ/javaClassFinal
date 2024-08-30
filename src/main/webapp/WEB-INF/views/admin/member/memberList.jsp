<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberList.jsp</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <style>
    body { background-color: #f8f9fa; }
    .card { border-radius: 15px; }
    .table { font-size: 0.9rem; }
    .btn-sm { font-size: 0.8rem; }
  </style>
  <script>
    'use strict';
    
    $(function(){
    	$("#userDispaly").hide();
    	
    	$("#userInfor").on("click", function(){
    		if($("#userInfor").is(':checked')) {
    			$("#totalList").hide();
    			$("#userDispaly").show();
    		}
    		else {
    			$("#totalList").show();
    			$("#userDispaly").hide();
    		}
    	});
    });
    
    // 각 레벨(등급)별 회원 보기...
    function levelItemCheck() {
    	let level = $("#levelItem").val();
    	location.href = "memberList?level="+level;
    }
    
    // 회원별 각각의 등급 변경처리(ajax처리)
    function levelChange(e) {
    	let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
    	
    	let items = e.value.split("/");
    	let query = {
    			level : items[0],
    			idx   : items[1]
    	}
    	
    	$.ajax({
    		url  : "${ctp}/admin/member/memberLevelChange",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("등급 수정 완료!");
    				location.reload();
    			}
    			else alert("등급 수정 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 30일 경과회원 삭제처리
    function memberDeleteOk(idx, photo) {
    	let ans = confirm("선택하신 회원을 영구 삭제 하시겠습니까?");
    	if(ans) {
    		$.ajax({
    			url  : "${ctp}/admin/member/memberDeleteOk",
    			type : "post",
    			data : {
    				idx : idx,
    				photo : photo
    			},
    			success:function(res) {
    				if(res != "0") {
    					alert("영구 삭제 되었습니다.");
    					location.reload();
    				}
    				else alert("삭제 실패~~");
    			}
    		});
    	}
    }
    
    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
    }

    // 선택반전
    function reverseCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
      }
    }
    
    // 선택항목 등급변경처리
    function levelSelectCheck() {
    	let select = document.getElementById("levelSelect");
    	let levelSelectText = select.options[select.selectedIndex].text;
    	let levelSelect = select.options[select.selectedIndex].value;
    	// let levelSelect = document.getElementById("levelSelect").value;
    	let idxSelectArray = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
      }
    	if(idxSelectArray == '') {
    		alert("등급을 변경할 항목을 1개 이상 선택하세요");
    		return false;
    	}
    	
      idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
      let query = {
    		  idxSelectArray : idxSelectArray,
    		  levelSelect : levelSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/admin/member/memberLevelSelectCheck",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택한 항목들이 "+levelSelectText+"(으)로 변경되었습니다.");
    		  else alert("등급변경 실패~");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    }
  </script>
</head>
<body>
<div class="container py-5">
  <div class="card shadow">
    <div class="card-body">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <div class="form-check">
          <input type="checkbox" class="form-check-input" name="userInfor" id="userInfor">
          <label class="form-check-label" for="userInfor">비공개회원만보기/전체보기</label>
        </div>
        <select name="levelItem" id="levelItem" class="form-select" style="width: auto;" onchange="levelItemCheck()">
          <option value="99"   ${level >= 4  ? "selected" : ""}>전체보기</option>
          <option value="1"    ${level == 1 ? "selected"  : ""}>우수회원</option>
          <option value="2"    ${level == 2 ? "selected"  : ""}>정회원</option>
          <option value="3"    ${level == 3 ? "selected"  : ""}>준회원</option>
          <option value="999"  ${level == 999 ? "selected": ""}>탈퇴신청회원</option>
          <option value="0"    ${level == 0 ? "selected"  : ""}>관리자</option>
        </select>
      </div>
      
      <div id="totalList">
        <h3 class="text-center mb-4">전체 회원 리스트</h3>
        <div class="d-flex justify-content-between align-items-center mb-3">
          <div class="btn-group">
            <button type="button" class="btn btn-outline-primary btn-sm" onclick="allCheck()">전체선택</button>
            <button type="button" class="btn btn-outline-primary btn-sm" onclick="allReset()">전체취소</button>
            <button type="button" class="btn btn-outline-primary btn-sm" onclick="reverseCheck()">선택반전</button>
          </div>
          <div class="d-flex align-items-center">
            <select name="levelSelect" id="levelSelect" class="form-select me-2" style="width: auto;">
              <option value="2">정회원</option>
              <option value="3">준회원</option>
              <option value="1">우수회원</option>
            </select>
            <button type="button" class="btn btn-warning btn-sm" onclick="levelSelectCheck()">선택항목등급변경</button>
          </div>
        </div>
        
        <form name="myform">
          <div class="table-responsive">
            <table class="table table-hover align-middle">
              <thead class="table-light">
                <tr>
                  <th>번호</th>
                  <th>아이디</th>
                  <th>닉네임</th>
                  <th>성명</th>
                  <th>생일</th>
                  <th>성별</th>
                  <th>최종방문일</th>
                  <th>오늘방문횟수</th>
                  <th>활동여부</th>
                  <th>현재레벨</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="vo" items="${vos}" varStatus="st">
                  <c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
                    <c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"/></c:if>
                    <c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"/></c:if>
                    <tr>
                      <td>
                        <c:if test="${vo.level != 0}"><input type="checkbox" class="form-check-input" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
                        <c:if test="${vo.level == 0}"><input type="checkbox" class="form-check-input" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled /></c:if>
                        ${curScrStartNo}
                      </td>
                      <td><a href="MemberSearch.mem?mid=${vo.mid}" class="text-decoration-none">${vo.mid}</a></td>
                      <td>${vo.nickName}</td>
                      <td>${vo.name}</td>
                      <td>${fn:substring(vo.birthday,0,10)}</td>
                      <td>${vo.gender}</td>
                      <td>${fn:substring(vo.lastDate,0,10)}</td>
                      <td>${vo.todayCnt}</td>
                      <td>
                        <c:if test="${vo.userDel == 'OK'}"><span class="text-danger fw-bold">${active}</span></c:if>
                        <c:if test="${vo.userDel != 'OK'}">${active}</c:if>
                        <c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
                          (<a href="javascript:memberDeleteOk('${vo.idx}','${vo.photo}')" class="text-danger">30일경과</a>)
                        </c:if>
                      </td>
                      <td>
                        <c:if test="${vo.level != 0}">
                          <select name="level" class="form-select form-select-sm" onchange="levelChange(this)">
                            <option value="1/${vo.idx}"  ${vo.level == 1  ? "selected" : ""}>우수회원</option>
                            <option value="2/${vo.idx}"  ${vo.level == 2  ? "selected" : ""}>정회원</option>
                            <option value="3/${vo.idx}"  ${vo.level == 3  ? "selected" : ""}>준회원</option>
                            <option value="0/${vo.idx}"  ${vo.level == 0  ? "selected" : ""}>관리자</option>
                            <option value="999/${vo.idx}" ${vo.level == 999 ? "selected" : ""}>탈퇴신청회원</option>
                          </select>
                        </c:if>
                        <c:if test="${vo.level == 0}">관리자</c:if>
                      </td>
                    </tr>
                  </c:if>
                  <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </form>
      </div>
      
      <div id="userDispaly">
        <c:if test="${sLevel == 0}">
          <h3 class="text-center mb-4">비공개 회원 리스트</h3>
          <div class="table-responsive">
            <table class="table table-hover align-middle">
              <thead class="table-light">
                <tr>
                  <th>번호</th>
                  <th>아이디</th>
                  <th>닉네임</th>
                  <th>성명</th>
                  <th>생일</th>
                  <th>성별</th>
                  <th>최종방문일</th>
                  <th>오늘방문횟수</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="no" value="1"/>
                <c:forEach var="vo" items="${vos}" varStatus="st">
                  <c:if test="${vo.userInfor == '비공개'}">
                    <tr>
                      <td>${no}</td>
                      <td>${vo.mid}</td>
                      <td>${vo.nickName}</td>
                      <td>${vo.name}</td>
                      <td>${fn:substring(vo.birthday,0,10)}</td>
                      <td>${vo.gender}</td>
                      <td>${fn:substring(vo.lastDate,0,10)}</td>
                      <td>${vo.todayCnt}</td>
                    </tr>
                    <c:set var="no" value="${no + 1}"/>
                  </c:if>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
      </div>
      
      <!-- 페이지네이션 -->
      <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
          <c:if test="${pag > 1}">
            <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=1&pageSize=${pageSize}">처음</a></li>
            <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${pag-1}&pageSize=${pageSize}">이전</a></li>
          </c:if>
          <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
            <c:if test="${i <= totPage && i == pag}">
              <li class="page-item active"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${i}&pageSize=${pageSize}">${i}</a></li>
            </c:if>
            <c:if test="${i <= totPage && i != pag}">
              <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${i}&pageSize=${pageSize}">${i}</a></li>
            </c:if>
          </c:forEach>
          <c:if test="${pag < totPage}">
            <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${pag+1}&pageSize=${pageSize}">다음</a></li>
            <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${totPage}&pageSize=${pageSize}">마지막</a></li>
          </c:if>
        </ul>
      </nav>
    </div>
  </div>
</div>
</body>
</html>