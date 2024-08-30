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
	
	@ResponseBody
	@RequestMapping(value = "/srt", method = RequestMethod.POST)
	public List<HashMap<String, Object>> trainPost(HttpServletRequest request, String stationStart, String stationStop) {
		List<HashMap<String, Object>> array = new ArrayList<HashMap<String,Object>>();
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
			System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
			
			WebDriver driver = new ChromeDriver();
			driver.get("http://srtplay.com/train/schedule");

			WebElement btnMore = driver.findElement(By.xpath("//*[@id=\"station-start\"]/span"));
			btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
      
      btnMore = driver.findElement(By.xpath("//*[@id=\"station-pos-input\"]"));
      btnMore.sendKeys(stationStart);
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationListArea\"]/li/label/div/div[2]"));
      btnMore.click();
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationDiv\"]/div/div[3]/div/button"));
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
      
      btnMore = driver.findElement(By.xpath("//*[@id=\"station-arrive\"]/span"));
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
      btnMore = driver.findElement(By.id("station-pos-input"));
      
      btnMore.sendKeys(stationStop);
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationListArea\"]/li/label/div/div[2]"));
      btnMore.click();
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationDiv\"]/div/div[3]/div/button"));
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}

      btnMore = driver.findElement(By.xpath("//*[@id=\"sr-train-schedule-btn\"]/div/button"));
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
      
      List<WebElement> timeElements = driver.findElements(By.cssSelector(".table-body ul.time-list li"));
 			
      HashMap<String, Object> map = null;
      
			for(WebElement element : timeElements){
				map = new HashMap<String, Object>();
				String train=element.findElement(By.className("train")).getText();
				String start=element.findElement(By.className("start")).getText();
				String arrive=element.findElement(By.className("arrive")).getText();
				String time=element.findElement(By.className("time")).getText();
				String price=element.findElement(By.className("price")).getText();
				map.put("train", train);
				map.put("start", start);
				map.put("arrive", arrive);
				map.put("time", time);
				map.put("price", price);
				array.add(map);
			}
			
      // 요금조회하기 버튼을 클릭한다.(처리 안됨 - 스크린샷으로 대체)
      btnMore = driver.findElement(By.xpath("//*[@id=\"scheduleDiv\"]/div[2]/div/ul/li[1]/div/div[5]/button"));
      //System.out.println("요금 조회버튼클릭");
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
      
      // 지정경로에 브라우저 화면 스크린샷 저장처리
  		realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
      File scrFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
      FileUtils.copyFile(scrFile, new File(realPath + "screenshot.png"));
			
      driver.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return array;
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
	 
 
}