package com.spring.javaclassS6.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS6.service.MapandWeatherService;
import com.spring.javaclassS6.vo.BicycleVO;
import com.spring.javaclassS6.vo.KakaoAddressVO;

@Controller
@RequestMapping("mapandweather")
public class MapController {

	@Autowired
	MapandWeatherService mapandweatherService;
	
	@RequestMapping(value = "/mapandweather1", method = RequestMethod.GET)
	public String mapandweather1(Model model,
			@RequestParam(name="address1", defaultValue = "", required = false) String address1,
			@RequestParam(name="address2", defaultValue = "", required = false) String address2
	) {
		KakaoAddressVO vo = mapandweatherService.getKakaoAddressSearch(address1);
		List<KakaoAddressVO> addressVos = mapandweatherService.getKakaoAddressList();
		model.addAttribute("address1", address1);
		model.addAttribute("address2", address2);
		model.addAttribute("addressVos", addressVos);
		model.addAttribute("vo", vo);
		
		return "mapandweather/mapandweather1";
	}
	
	@RequestMapping(value = "/mapPlus", method = RequestMethod.GET)
	public String MapPlusGet(Model model,
			@RequestParam(name="address1", defaultValue = "", required = false) String address1,
			@RequestParam(name="address", defaultValue = "", required = false) String address
	) {
		List<KakaoAddressVO> addressVos = mapandweatherService.getKakaoAddressList();
		//KakaoAddressVO vo = mapandweatherService.getKakaoAddressSearch(address1);
		//model.addAttribute("vo", vo);
		model.addAttribute("address", address);
		model.addAttribute("addressVos", addressVos);

		return "mapandweather/mapPlus";
	}
	
//카카오맵 마커표시/저장 처리
	@ResponseBody
	@RequestMapping(value = "/mapPlus", method = RequestMethod.POST)
	public String mapPlusPost(KakaoAddressVO vo, Model model) {
		KakaoAddressVO searchVO = mapandweatherService.getKakaoAddressSearch(vo.getAddress());
		if(searchVO != null) return "0";

		// 1. content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 map 폴더에 따로 보관
		if(vo.getContent().indexOf("src=\"/") != -1) mapandweatherService.imgCheck(vo.getContent());

		// 2. 이미지 작업(복사작업)을 마치면, ckeditor 폴더 경로를 map 폴더 경로로 변경
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/map/"));

		// 3. content 내용 정리가 끝나면 변경된 내용을 vo에 담아 DB에 저장
		int res = mapandweatherService.setKakaoAddressInput(vo);
		if(res != 0) return "1";
		else return "0";
	}
	
	
	//전국 자전거 대여소(공공API) 폼보기
	 @RequestMapping(value = "/bicycle", method = RequestMethod.GET)
	 public String bicycleGet() {
	 	return "mapandweather/bicycle";
	 }
	 
	 // 전국 자전거 대여소 조회 처리1
	 @ResponseBody
	 @RequestMapping(value = "/bicycle", method = RequestMethod.POST)
	 public List<BicycleVO> bicyclePost(int page) {
	 	return mapandweatherService.getBicycleData(page);
	 }
	 
	 // 서울시 공공자전거 실시간 대여정보 처리
	 @ResponseBody
	 @RequestMapping(value = "/bicycle2", method = RequestMethod.POST)
	 public List<BicycleVO> bicycle2Post() {
	 	return mapandweatherService.getBicycleData2();
	 }
	 
	 //맵제거
	 @RequestMapping(value = "/addressDelete", method = RequestMethod.GET)
	 public String addressDeleteGet(String address, Model model) {
		 KakaoAddressVO vo = mapandweatherService.getKakaoAddressSearch(address);
		 if(vo.getContent().indexOf("src=\"/") != -1) mapandweatherService.imgDelete(vo.getContent());
		 
		 int res = mapandweatherService.setaddressDelete(address);
		 
		 if(res != 0) return "redirect:/message/addressDeleteOk";
		 else return "redirect:/message/addressDeleteNo";
 	}
	
	 @RequestMapping(value = "/mapUpdate", method = RequestMethod.GET)
	 public String mapUpdateGet(Model model) {
	     List<KakaoAddressVO> addressVos = mapandweatherService.getKakaoAddressList();
	     model.addAttribute("addressVos", addressVos);
	     return "mapandweather/mapUpdate";
	 }

	 @RequestMapping(value = "/mapUpdateForm", method = RequestMethod.GET)
	 public String mapUpdateFormGet(@RequestParam("address") String address, Model model) {
	     KakaoAddressVO vo = mapandweatherService.getKakaoAddressSearch(address);
	     model.addAttribute("vo", vo);
	     return "mapandweather/mapUpdateForm";
	 }

	 @RequestMapping(value = "/mapUpdateForm", method = RequestMethod.POST)
	 @ResponseBody
	 public String mapUpdateFormPost(KakaoAddressVO vo) {
	     // 이미지 처리 로직
	     if(vo.getContent().indexOf("src=\"/") != -1) mapandweatherService.imgCheck(vo.getContent());
	     vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/map/"));
	     
	     int res = mapandweatherService.setKakaoAddressUpdate(vo);
	     
	     return res + "";
	 }
	 
	 
 
}