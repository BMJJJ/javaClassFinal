<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
  /* a:active, a:focus, a:hover{
   /*  text-decoration: none; 
  }*/
	  .small-font {
	    font-size: 0.65em; 
	  }
	  .small-font1 {
	    font-size: 0.8em; 
	  }
	  .small-font2 {
	    font-size: 0.8em; 
	  }
	  .middle-font1 {
	    font-size: 1.2em;
	  }
	  .w3-button {
	    color: black;
	  }
	  .w3-bar-item {
	    color: black;
	  }
	  .w3-dropdown-content .w3-bar-item:hover {
	    background-color: #ddd;
	    text-decoration: none;
	  }
	  .w3-top{
	  	position : relative;
	  }
		.accordion {
		 background-color: #eee;
		 color: #444;
		 cursor: pointer;
		 padding: 18px;
		 width: 100%;
		 border: none;
		 text-align: left;
		 outline: none;
		 font-size: 15px;
		 transition: 0.4s;
		}
		.active, .accordion:hover {
			background-color: #ccc;
		}
		
		.panel {
		  padding: 0 18px;
		  background-color: white;
		  display: none;
		  overflow: hidden;
		  transition: max-height 0.2s ease-out;
		}
</style>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		  var acc = document.getElementsByClassName("accordion");
		  var i;
	
		  for (i = 0; i < acc.length; i++) {
		    acc[i].addEventListener("click", function() {
		      this.classList.toggle("active");
		      var panel = this.nextElementSibling;
		      if (panel.style.maxHeight) {
		        panel.style.maxHeight = null;
		      } else {
		        panel.style.maxHeight = panel.scrollHeight + "px";
		      }
		    });
		  }
		});

  function userDelCheck() {
    let ans = confirm("회원 탈퇴하시겠습니까?");
    if(ans) {
      ans = confirm("탈퇴하시면 1개월간 같은 아이디로 다시 가입하실 수 없습니다.\n그래도 탈퇴 하시겠습니까?");
      if(ans) {
        $.ajax({
          type: "post",
          url: "${ctp}/member/userDel",
          success:function(res) {
            if(res == "1") {
              alert("회원에서 탈퇴 되셨습니다.");
              location.href = '${ctp}/member/memberLogin';
            } else {
              alert("회원 탈퇴신청 실패~~");
            }
          },
          error: function() {
            alert("전송오류!");
          }
        });
      }
    }
  }
  
  function w3_open() {
	  document.getElementById("mySidebar").style.display = "block";
	  initializeAccordion();
	}

	function initializeAccordion() {
	  var acc = document.getElementsByClassName("accordion");
	  for (var i = 0; i < acc.length; i++) {
	    acc[i].addEventListener("click", function() {
	      this.classList.toggle("active");
	      var panel = this.nextElementSibling;
	      if (panel.style.maxHeight) {
	        panel.style.maxHeight = null;
	      } else {
	        panel.style.maxHeight = panel.scrollHeight + "px";
	      }
	    });
	  }
	}
   
  function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
  }
  
  
</script>
<!-- Sidebar (hidden by default) -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:20%;min-width:250px;background-color:#f0f4f0" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">Close Menu</a>
  <a href="${ctp}/member/memberMain" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">MyPage</a>
  <a href="${ctp}/guest/guestList" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">방명록</a>
 	<%-- <a href="${ctp}/board/fixboardList" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">공지사항</a> --%>
  <a href="${ctp}/board/boardList" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">게시판</a>
  <a href="${ctp}/pds/pdsList" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">사진공유실</a>
	<a href="${ctp}/mapandweather/mapandweather1" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">지도와날씨</a>
	<a href="${ctp}/park/parkList" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">국립공원</a>
	<a href="${ctp}/park/schedule" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">예약</a>
  <a href="${ctp}/photoGallery/photoGalleryList" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">사진 갤러리</a>
  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button w3-medium">About</a>
</nav>
<!-- Top menu -->
<div class="w3-top">
  <div class="w3-xlarge" style="max-width:1200px;margin:auto; display: flex; align-items: center; justify-content: space-between; position:relative;">
    <!-- Left section for the menu button -->
    <div class="w3-button w3-padding-16" style="position:absolute; left:0;" onclick="w3_open()">☰</div>

    <!-- Center section for the Home link -->
    <div style="flex-grow: 1; text-align: center;">
      <!-- <div class="w3-center w3-padding-16"><a href="http://192.168.50.69:9090/javaclassS6/">Home</a></div> -->
      <%-- <div class="w3-center w3-padding-16 middle-font1"><a href="${ctp}/"><img src="${ctp}/images/logo.png" width="200px" height="100px"></a></div> --%>
      <div class="w3-center w3-padding-16 middle-font1"><a href="${ctp}/"><img src="${ctp}/images/logo2.jpg" width="200px" height="100px"></a></div>
    </div>

    <!-- Right section for login/logout and other links -->
    <div style="position:absolute; right:0; align-items: center;">
      <c:if test="${empty sLevel}">
        <span class="w3-padding-16 small-font1"><a href="${ctp}/member/memberLogin">Login</a></span>
        <span class="w3-padding-16 small-font1" style="margin-left: 10px;"><a href="${ctp}/member/memberJoin">Join</a></span>
      </c:if>
      <c:if test="${!empty sLevel}">
        <div class="w3-right w3-padding-16 small-font2"><a href="${ctp}/member/memberLogout">Logout</a></div>
        <div class="w3-dropdown-hover w3-hide-small">
          <button onclick="location.href='${ctp}/member/memberMain';" class="w3-padding-16 w3-button small-font1" title="More">MyPage <i class="fa fa-caret-down"></i></button>
          <div class="w3-dropdown-content w3-bar-block w3-card-4 small-font" style="background-color:#f0f4f0;">
            <a href="${ctp}/webSocket/webSocket" class="w3-bar-item w3-button">1대1 문의</a>
            <a href="${ctp}/member/memberList" class="w3-bar-item w3-button">회원리스트</a>
            <a href="${ctp}/member/memberPwdCheck/p" class="w3-bar-item w3-button">비밀번호변경</a>
            <a href="${ctp}/member/memberPwdCheck/i" class="w3-bar-item w3-button">회원정보수정</a>
            <a href="javascript:userDelCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
            <c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자메뉴</a></c:if>
          </div>
        </div>
      </c:if>
    </div>
  </div>
</div>
