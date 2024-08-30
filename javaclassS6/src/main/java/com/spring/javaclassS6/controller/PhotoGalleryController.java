package com.spring.javaclassS6.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS6.service.PhotoGalleryService;
import com.spring.javaclassS6.vo.PhotoGalleryVO;
import com.spring.javaclassS6.vo.PhotoReplyVO;

@Controller
@RequestMapping("/photoGallery")
public class PhotoGalleryController {

    @Autowired
    PhotoGalleryService photoGalleryService;

    @RequestMapping(value = "/photoGalleryList", method = RequestMethod.GET)
    public String getPhotoGalleryList(PhotoGalleryVO vo,
            @RequestParam(value = "pag", defaultValue = "1") int pag,
            @RequestParam(value = "pageSize", defaultValue = "16") int pageSize,
            @RequestParam(value = "part", defaultValue = "전체") String part,
            @RequestParam(value = "choice", defaultValue = "최신순") String choice,
            Model model) {

        int startIndexNo = (pag - 1) * pageSize;

        String imsiChoice;
        switch (choice) {
            case "추천순":
                imsiChoice = "goodCount";
                break;
            case "조회순":
                imsiChoice = "readNum";
                break;
            case "댓글순":
                imsiChoice = "replyCnt";
                break;
            default:
                imsiChoice = choice;
        }

        List<PhotoGalleryVO> vos = photoGalleryService.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);

        model.addAttribute("vo", vo);
        model.addAttribute("vos", vos);
        model.addAttribute("part", part);
        model.addAttribute("choice", choice);

        return "photoGallery/photoGalleryList"; 
    }
    @RequestMapping(value = "/photoGalleryInput", method = RequestMethod.GET)
    public String photoGalleryInputGet(Model model,
            @RequestParam(name="part", defaultValue = "전체", required = false) String part) {
        model.addAttribute("part", part);
        return "photoGallery/photoGalleryInput";
    }
    
    @RequestMapping(value = "/photoGalleryInput", method = RequestMethod.POST)
    public String photoGalleryInputPost(PhotoGalleryVO vo) {
  		// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/board'폴더로 복사처리)
  		if(vo.getContent().indexOf("src=\"/") != -1) photoGalleryService.imgCheck(vo.getContent());
  		
  		// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 photo폴더 경로로 변경처리한다.
  		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/photoGallery/"));

  		vo.setPhotoCount(vo.getContent().split("<img ").length - 1);
  		
  		//<p><img src="/javaclassS6/data/photoGallery/240716153428_flower.png" style="height:503px; width:512px" /></p>
  		//01234567890123456789012345678901234567890123456789
  		String temp = vo.getContent().substring(44);
  		temp = temp.substring(0,temp.indexOf("\""));
  		// 3. 썸네일 추출
  		vo.setThumbnail(photoGalleryService.setThumbnail(temp));
  		
  		// 4.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
  		int res = photoGalleryService.setPhotoGalleryInput(vo);
  		
  		if(res != 0) return "redirect:/message/photoGalleryInputOk";
  		else  return "redirect:/message/photoGalleryInputNo";
  	}
    
    @RequestMapping(value = "/photoGallerContent", method = RequestMethod.GET)
    public String photoGalleryContent(
        @RequestParam(name = "idx", defaultValue = "0") int photoIdx,
        PhotoGalleryVO vo,
        HttpSession session,
        Model model) {
        // 게시글 조회수 1씩 증가시키기(중복방지)
        ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
        if (contentReadNum == null) {
            contentReadNum = new ArrayList<>();
        }
        String imsiContentReadNum = "photoGallery" + photoIdx;
        if (!contentReadNum.contains(imsiContentReadNum)) {
            photoGalleryService.setPhotoGalleryReadNumPlus(photoIdx);
            contentReadNum.add(imsiContentReadNum);
        }
        session.setAttribute("sContentIdx", contentReadNum);
        
        // 조회자료 1건 담아서 내용보기로 보낼 준비
        vo = photoGalleryService.getPhotoGalleryIdxSearch(photoIdx);
        int replyCount = photoGalleryService.getPhotoGalleryReplyCount(photoIdx);
        vo.setReplyCnt(replyCount);
        model.addAttribute("vo", vo);
        
        // 댓글 처리
        ArrayList<PhotoGalleryVO> replyVos = photoGalleryService.getPhotoGalleryReply(photoIdx);
        model.addAttribute("replyVos", replyVos);
        
        // 세션에서 필요한 정보 가져오기
        String sMid = (String) session.getAttribute("sMid");
        String sNickName = (String) session.getAttribute("sNickName");
        int sLevel = (int) session.getAttribute("sLevel");
        
        // 좋아요 상태 확인
        boolean isLiked = photoGalleryService.isLikedMid(photoIdx, sMid);
        
        
        model.addAttribute("sMid", sMid);
        model.addAttribute("sNickName", sNickName);
        model.addAttribute("sLevel", sLevel);
        model.addAttribute("isLiked", isLiked);  // 좋아요 상태를 모델에 추가
        
        return "photoGallery/photoGallerContent";
    }
    @ResponseBody
    @RequestMapping(value = "/photoGalleryGoodCheck", method = RequestMethod.POST)
    public String photoGalleryGoodCheck(@RequestParam int idx, HttpSession session) {
      String mid = (String) session.getAttribute("sMid");
      
      if (mid == null) {
          return "0"; // 로그인되지 않은 경우
      }
      
      try {
          String result = photoGalleryService.toggleGood(idx, mid);
          return result; // "1": 좋아요 추가, "2": 좋아요 취소, "0": 오류 발생
      } catch (Exception e) {
          return "0"; // 오류 발생
      }
    }
    
    @ResponseBody
  	@RequestMapping(value = "/photoGalleryReplyInput", method = RequestMethod.POST)
  	public String photoGalleryReplyInputPost(PhotoReplyVO replyVO) {
    	PhotoReplyVO replyParentVO = photoGalleryService.getPhotoParentReplyCheck(replyVO.getPhotoIdx());
  		if(replyParentVO == null) {
  			replyVO.setRe_order(1);
  		}
  		else {
  			replyVO.setRe_order(replyParentVO.getRe_order() + 1);
  		}
  		replyVO.setRe_step(0);
  		
  		int res = photoGalleryService.setPhotoReplyInput(replyVO);
  		
  		
  		return res + "";
  	}
    @ResponseBody
  	@RequestMapping(value = "/photoGalleryReplyInputRe", method = RequestMethod.POST)
  	public String photoGalleryReplyInputRePost(PhotoReplyVO replyVO) {
  		// 대댓글(답변글)의 1.re_step은 부모댓글의 re_step+1, 2.re_order는 부모의 re_order보다 큰 댓글은 모두 +1처리후, 3.자신의 re_order+1시켜준다.
  		
  		replyVO.setRe_step(replyVO.getRe_step() + 1);		// 1번처리
  		
  		photoGalleryService.setReplyOrderUpdate(replyVO.getPhotoIdx(), replyVO.getRe_order());  // 2번 처리
  		
  		replyVO.setRe_order(replyVO.getRe_order() + 1);
  		
  		int res = photoGalleryService.setPhotoReplyInput(replyVO);
  		
  		return res + "";
  	}
    /*@RequestMapping(value = "/photoDelete", method = RequestMethod.GET)
  	public String photoDeleteGet(int idx) {
  		// 게시글의 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
  		PhotoGalleryVO vo = photoGalleryService.getPhotoContent(idx);
  		if(vo.getContent().indexOf("src=\"/") != -1) photoGalleryService.imgDelete(vo.getContent());
  		
  		//사진작업이 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
  		int res = photoGalleryService.setPhotoDelete(idx);
  		
  		if(res != 0) return "redirect:/message/photoDeleteOk";
  		else return "redirect:/message/photoDeleteNo";
  	}*/
    // 내용 삭제하기
  	@RequestMapping(value = "/photoDelete", method = RequestMethod.GET)
  	public String photoDeleteGet(int idx) {
  		int res = photoGalleryService.setPhotoDelete(idx);
  	  if(res != 0) return "redirect:/message/photoDeleteOk";
  	  else return "redirect:/message/photoDeleteNo";
  	}
    
 // 사진 여러장보기에서, 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
  	@ResponseBody
  	@RequestMapping(value = "/photoGalleryListPaging", method = RequestMethod.POST)
  	public ModelAndView photoGalleryPagingPost(Model model,
  			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
  			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
  			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
  			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
  		) {
  		int startIndexNo = (pag - 1) * pageSize;
  		
  		String imsiChoice = "";
  		if(choice.equals("최신순")) imsiChoice = "idx";
  		else if(choice.equals("추천순")) imsiChoice = "goodCount";
  		else if(choice.equals("조회순")) imsiChoice = "readNum";
  		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
  		else imsiChoice = choice;
  		
  		//PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "photoGallery", part, choice);
  		List<PhotoGalleryVO> vos = photoGalleryService.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);
  		model.addAttribute("vos", vos);
  		model.addAttribute("part", part);
  		model.addAttribute("choice", choice);
  		
  		// ModelAndView에 담아서 return
  		ModelAndView mv = new ModelAndView();
  		mv.setViewName("photoGallery/photoGalleryListPaging");
  		return mv;
  	}
  	
  	
    
  	@ResponseBody
  	@RequestMapping(value = "/photoGalleryReplyDelete", method = RequestMethod.POST)
  	public String photoGalleryReplyDeletePost(int idx) {
  		int res = photoGalleryService.deletePhotoReply(idx);
  		
  		return res + "";
  	}
  	
  	// 사진 한장씩 전체 보기(나중에 올린순으로 보기)
  	@RequestMapping(value = "/photoGallerySingle", method = RequestMethod.GET)
  	public String photoGallerySingleGet(Model modelModel, Model model,
  			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
  			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
  		) {
  		int startIndexNo = (pag - 1) * pageSize;
  		List<PhotoGalleryVO> vos = photoGalleryService.setPhotoGallerySingle(startIndexNo, pageSize);
  		model.addAttribute("vos", vos);
  		System.out.println("vos : " + vos);
  		return "photoGallery/photoGallerySingle";
  	}
  	
  	// 사진 한장씩 전체 보기(나중에 올린순으로 보기) - 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
  	@ResponseBody
  	@RequestMapping(value = "/photoGallerySinglePaging", method = RequestMethod.POST)
  	public ModelAndView photoGallerySinglePagingPost(Model modelModel, Model model,
  			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
  			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
  			) {
  		int startIndexNo = (pag - 1) * pageSize;
  		List<PhotoGalleryVO> vos = photoGalleryService.setPhotoGallerySingle(startIndexNo, pageSize);
  		model.addAttribute("vos", vos);
  		
  	  // ModelAndView에 담아서 return
  		ModelAndView mv = new ModelAndView();
  		mv.setViewName("photoGallery/photoGallerySinglePaging");
  		return mv;
  	}
  	
}
