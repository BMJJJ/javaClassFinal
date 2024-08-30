<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberLogin.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script src="http://developers.kakao.com/sdk/js/kakao.js"></script>
  <style>
  
  .spinner-container {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      display: none;
      z-index: 9999;
    }
  	
     .form {
      position: relative;
      z-index: 1;
      background: #FFFFFF;
      border-radius: 10px;
      max-width: 600px;
      margin: 0 auto 100px;
      padding: 45px;
      text-align: center;
      border-radius: 50px;
      background: #e0e0e0;
      box-shadow: -11px 11px 22px #bebebe, 11px -11px 22px #ffffff;
    } 


     .table-container {
      display: flex;
      justify-content: center;
    } 

     table {
      border: none;
    }

    .table-borderless td, .table-borderless th {
      border: none;
    } 
  </style>
  <script>
    'use strict';

    $(function() {
        $("#searchPassword").hide();
        $("#searchMid").hide();
    });

    function pwdSearch() {
        if ($("#searchPassword").is(":visible")) {
            $("#searchPassword").hide();
        } else {
            $("#searchPassword").show();
            $("#searchMid").hide();
        }
    }

    function midSearch() {
        if ($("#searchMid").is(":visible")) {
            $("#searchMid").hide();
        } else {
            $("#searchMid").show();
            $("#searchPassword").hide();
        }
    }

    // 임시비밀번호 등록시켜주기
    function newPassword() {
    	let mid = $("#midSearch").val().trim();
    	let email = $("#emailSearch2").val().trim();
    	if(mid == "" || email == "") {
    		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
    		$("#midSearch").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberNewPassword",
    		type : "post",
    		data : {
    			mid   : mid,
    			email : email
    		},
        beforeSend: function() {
          // AJAX 요청이 시작되기 전에 스핀 태그 표시
        	$("#spinner-password").css("display", "inline-block");
        },
    		success:function(res) {
    			$("#spinner-password").css("display", "none");
    			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
    			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
    		},
    		error : function() {
    			$("#spinner-password").css("display", "none");
    			alert("전송오류!!")
    		}
    	});
    	
   	  $(function(){
        	$("#searchMid").hide();
        });
        
        // 아이디 찾기
        function midSearch() {
        	$("#searchMid").show();
        } 
    }	
    // 아이디 알려주기
    function newMid() {
    	let name = $("#nameSearch").val().trim();
    	let email = $("#emailSearch3").val().trim();
    	if(name == "" || email == "") {
    		alert("가입시 등록한 이름과 메일주소를 입력하세요");
    		$("#nameSearch").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberNewMid",
    		type : "post",
    		data : {
    			name   : name,
    			email : email
    		},
    		beforeSend: function() {
        	$("#spinner-mid").css("display", "inline-block");
        },
    		success:function(res) {
    			$("#spinner-mid").css("display", "none");
    			if(res != "0") alert("아이디가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
    			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
    		},
    		error : function() {
    			$("#spinner-mid").css("display", "none");
    			alert("전송오류!!")
    		}
    	});
    }
    
    //카카오 로그인(자바스크립트 앱키 등록)
    window.Kakao.init("25842eaa8d7542aca1b754697717a5ab");
    
    function kakaoLogin() {
    	window.Kakao.Auth.login({
				scope:'profile_nickname, account_email',
				success:function(autoObj) {
					console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨...")
					window.Kakao.API.request({
						url:'/v2/user/me',
						success:function(res){
							const kakao_account = res.kakao_account;
							console.log(kakao_account);
							location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
						}
					});
				}
    	});
		}
    
    // 비밀번호 표시 토글 기능
    $(document).ready(function() {
      $('#togglePassword').click(function() {
        const passwordField = $('#password');
        const type = passwordField.attr('type') === 'password' ? 'text' : 'password';
        passwordField.attr('type', type);
      });
    });

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<br/>
<br/>
<div class="container mt-5">
<p><br/></p>
  <form name="myform" method="post">
    <div class="table-container">
      <table class="table table-borderless text-center"> 
        <tr>
          <td colspan="2"><font size="5">Login</font></td>
        </tr>
        <tr>
          <th>UserID</th>
          <td><input type="text" name="mid" value="${mid}" autofocus required class="form-control" style="width: 75%;"/></td>
        </tr>
        <tr>
          <th>Password</th>
          <td>
            <input type="password" name="pwd" id="password" value="1234" required class="form-control" style="width: 75%;"/>
            <label style="display: inline-flex; align-items: center;">
              <input type="checkbox" id="togglePassword" style="margin-right: 10px;"> 비밀번호 보이기
            </label>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="submit" value="로그인" class="btn btn-dark mr-2"/>
            <input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-dark mr-4"/>
            <a href="javascript:kakaoLogin()"><img src="${ctp}/images/kakao_login_medium_narrow.png" width="150px"/></a>
          </td>
        </tr>
      </table>
    </div>
    <table class="table table-borderless p-0">
      <tr>
        <td class="text-center">
	    		<input type="checkbox" name="idSave" checked /> 아이디 저장 &nbsp;&nbsp;&nbsp;
          <a href="javascript:midSearch()">아이디 찾기</a> /
          <a href="javascript:pwdSearch()">비밀번호 찾기</a>
        </td>
      </tr>
    </table>
  </form>
  <div id="searchPassword">
    <hr/>
  	<table class="table table-borderless p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>비밀번호 찾기</b></font>
  	      (가입시 입력한 아이디와 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>아이디</th>
  	    <td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="새비밀번호발급" onclick="newPassword()" class="btn btn-secondary form-control" placeholder="메일주소를 입력하세요"/>
  	      <div id="spinner-password" class="spinner-container">
           	<div id="spinner" class="spinner-border text-muted"></div>
          </div>
  	    </td>
  	  </tr>
  	</table>
  </div>
  <div id="searchMid">
    <hr/>
  	<table class="table table-borderless p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>아이디 찾기</b></font>
  	      (가입시 입력한 이름과 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>이름</th>
  	    <td><input type="text" name="nameSearch" id="nameSearch" class="form-control" placeholder="이름을 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch3" id="emailSearch3" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="아이디알려주기" onclick="newMid()" class="form-control" placeholder="메일주소를 입력하세요"/>
  	      <div id="spinner-mid" class="spinner-container">
          	<div id="spinner" class="spinner-border text-muted"></div>
          </div>
  	    </td>
  	  </tr>
  	</table>
  </div>
<p><br/></p>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>
