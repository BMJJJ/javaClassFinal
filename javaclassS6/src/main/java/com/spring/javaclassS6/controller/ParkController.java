package com.spring.javaclassS6.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS6.pagination.PageProcess;
import com.spring.javaclassS6.service.ParkService;
import com.spring.javaclassS6.service.ScheduleService;
import com.spring.javaclassS6.vo.NationalVO;
import com.spring.javaclassS6.vo.ScheduleVO;

@Controller
@RequestMapping("/park")
public class ParkController {

	@Autowired
	ParkService parkSerive;
	
	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	PageProcess pageProcess;
	
	 @RequestMapping(value = "/parkList", method = RequestMethod.GET)
	 public String parkGet(NationalVO vo, Model model, String ymd,
				@RequestParam(name="part", defaultValue = "전체보기", required = false) String part) {
		 List<NationalVO> vos = parkSerive.getParkList(part);
		 
		 List<ScheduleVO> visitVos = parkSerive.getAllVisit(ymd); 
		 
		 model.addAttribute("visitVos",visitVos);
		 model.addAttribute("vo", vo);
		 model.addAttribute("vos" , vos);
		 model.addAttribute("part" , part);
		 model.addAttribute("ymd" , ymd);
		 
	 	return "park/parkList";
	 }
	 
	 @RequestMapping(value = "/scheduleInput", method = RequestMethod.GET)
	 public String scheduleInputGet(Model model, String ymd, String mid, int idx) {
     NationalVO nationalVo = parkSerive.getNationalVisit(idx);
     ScheduleVO scheduleVo = parkSerive.getNationalVisitCnt(idx, ymd);
     int visitCnt = 0;
     if(scheduleVo != null) visitCnt = scheduleVo.getVisitCnt();
     
     model.addAttribute("nationalVo", nationalVo);
     model.addAttribute("visitCnt", visitCnt);
     model.addAttribute("ymd", ymd);
     return "park/scheduleInput";
	 }
	 
	 @RequestMapping(value = "/scheduleInput", method = RequestMethod.POST)
	 public String scheduleInputPost(@RequestParam("ymd") String visitDate, Model model,ScheduleVO vo) {
		 List<ScheduleVO> visitVos = parkSerive.getAllVisit(visitDate); 
		 model.addAttribute("visitVos",visitVos);
		 
		 vo.setVisitDate(visitDate);
		 
		 int res = parkSerive.scheduleInput(vo);
			
		 if(res != 0) return "redirect:/message/scheduleInputOk";
		 else  return "redirect:/message/scheduleInputNo";
	 }
	 
	 @RequestMapping(value = "/parkInput", method = RequestMethod.GET)
	 public String parkGet() {
		 
		 return "park/parkInput";
	 }
	 
	 @RequestMapping(value = "/parkInput", method = RequestMethod.POST)
	 public String parkPost(NationalVO vo) {
	// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/board'폴더로 복사처리)
			if(vo.getPhoto().indexOf("src=\"/") != -1) parkSerive.imgCheck(vo.getPhoto());
			
			// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 national폴더 경로로 변경처리한다.
			vo.setPhoto(vo.getPhoto().replace("/data/ckeditor/", "/data/park/"));
			
			// 3.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
			int res = parkSerive.setParkInput(vo);
			
			if(res != 0) return "redirect:/message/parkInputOk";
			else  return "redirect:/message/parkInputNo";
		}
   
	// 스케줄 달력 띄우기
		@RequestMapping(value = "/schedule", method=RequestMethod.GET)
		public String scheduleGet(Model model) {
			scheduleService.getSchedule();
			return "park/schedule";
		}
		
		// 일정내역들어가서 메뉴보기
		@RequestMapping(value = "/scheduleMenu", method=RequestMethod.GET)
		public String scheduleMenuGet(HttpSession session, String ymd, Model model) {
			String mid = (String) session.getAttribute("sMid");
			
			String mm = "", dd = "";
			String[] ymdArr = ymd.split("-");
			// 2024-8-5/2024-8-15/2024-10-5  ==> 2024-08-05
			if(ymd.length() != 10) {
				if(ymdArr[1].length() == 1) mm = "0" + ymdArr[1];
				else mm = ymdArr[1];
				if(ymdArr[2].length() == 1) dd = "0" + ymdArr[2];
				else dd = ymdArr[2];
				ymd = ymdArr[0] + "-" + mm + "-" + dd;
			}
			
			List<ScheduleVO> vos = scheduleService.getScheduleMenu(mid, ymd);
			
			model.addAttribute("vos",vos);
			model.addAttribute("ymd", ymd);
			model.addAttribute("scheduleCnt", vos.size());
	
			return "schedule/scheduleMenu";
		}
		
		// 스케줄 수정하기
		@ResponseBody
		@RequestMapping(value = "/scheduleUpdateOk", method=RequestMethod.POST)
		public String scheduleUpdateOkPost(ScheduleVO vo) {
			return scheduleService.setScheduleUpdateOk(vo) + "";
		}
		
		// 스케줄 삭제하기
		@ResponseBody
		@RequestMapping(value = "/scheduleDeleteOk", method=RequestMethod.POST)
		public String scheduleDeleteOkPost(int idx) {
			return scheduleService.setScheduleDeleteOk(idx) + "";
		}
		
		@RequestMapping(value = "/adminSchedule", method=RequestMethod.GET)
		public String adminScheduleGet() {
			scheduleService.getSchedule();
			return "admin/schedule/adminSchedule";
		}
	 
 
}