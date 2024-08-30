package com.spring.javaclassS6.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize
			) {
		
		if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일이 전송되었습니다.");
			model.addAttribute("url", "/study/mail/mailForm");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글이 등록되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록 글 등록 실패");
			model.addAttribute("url", "/guest/guestInput");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "방명록이 삭제되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 아이디 입니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 닉네임 입니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원에 가입 되셨습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원에 가입 실패.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 만나서 반갑습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNewOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.\\n신규 비밀번호가 발급되었습니다. 점검후 회원정보를 변경해주세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인에 실패 하셨습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 다시 만나요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("kakaoLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되셨습니다.(kakao)");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일이 업로드 실패.");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원 수정을 완료하였습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원 수정이 실패하였습니다.");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", "탈퇴 신청을 완료하였습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg", "탈퇴 신청이 실패하였습니다.");
			model.addAttribute("url", "/member/memberPwdDeleteCheck");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접속하실수 있습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "회원 로그인후 사용하세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("midSameSearch")) {
			model.addAttribute("msg", "같은 아이디를 가진 회원이 존재합니다.\\n 아이디 확인후 다시 로그인해 주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글 등록 실패~~.");
			model.addAttribute("url", "/board/boardInput");
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정 되었습니다.");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg", "게시글이 수정 실패.");
			model.addAttribute("url", "/board/boardUpdate?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제 되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "게시글이 삭제 실패.");
			model.addAttribute("url", "/board/boardcontent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("pdsUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "/pds/pdsList");
		}
		else if(msgFlag.equals("pdsUploadNo")) {
			model.addAttribute("msg", "파일이 업로드 실패.");
			model.addAttribute("url", "/pds/pdsInput");
		}
		else if(msgFlag.equals("photoGalleryInputOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "/photoGallery/photoGalleryList");
		}
		else if(msgFlag.equals("photoGalleryInputNo")) {
			model.addAttribute("msg", "파일이 업로드 실패.");
			model.addAttribute("url", "/photoGallery/photoGalleryInput");
		}
		else if(msgFlag.equals("photoDeleteOk")) {
			model.addAttribute("msg", "사진이 삭제 되었습니다.");
			model.addAttribute("url", "/photoGallery/photoGalleryList");
		}
		else if(msgFlag.equals("photoDeleteNo")) {
			model.addAttribute("msg", "사진 삭제 실패.");
			model.addAttribute("url", "/photoGallery/photoGalleryList");
		}
		else if(msgFlag.equals("addressDeleteOk")) {
			model.addAttribute("msg", "지점이 삭제 되었습니다.");
			model.addAttribute("url", "/mapandweather/mapPlus");
		}
		else if(msgFlag.equals("addressDeleteNo")) {
			model.addAttribute("msg", "지점 삭제 실패.");
			model.addAttribute("url", "/mapandweather/mapPlus");
		}
		else if(msgFlag.equals("parkInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/park/parkList");
		}
		else if(msgFlag.equals("parkInputNo")) {
			model.addAttribute("msg", "등록 실패.");
			model.addAttribute("url", "/park/parkList");
		}
		else if(msgFlag.equals("scheduleInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/park/parkList");
		}
		else if(msgFlag.equals("scheduleInputNo")) {
			model.addAttribute("msg", "등록 실패.");
			model.addAttribute("url", "/park/parkList");
		}
		
		return "include/message";
	}
	
}
