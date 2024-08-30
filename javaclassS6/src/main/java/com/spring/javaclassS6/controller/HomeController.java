package com.spring.javaclassS6.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS6.service.HomeService;
import com.spring.javaclassS6.vo.WebChattingVO;

@Controller
public class HomeController {
	
	
	@Autowired
	HomeService homeService;
	
	@RequestMapping(value = {"/","/h","/main","/index"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String formattedDate = sdf.format(date);
		
		model.addAttribute("serverTime", formattedDate);
		
		return "home";
	}
	
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		// 파일명 중복방지를 위한 이름 설정하기(날짜로 분류처리...)
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(upload.getBytes());
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}
	
	@RequestMapping(value = "/fileDownAction", method = RequestMethod.GET)
	public void fileDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getParameter("path");
		String file = request.getParameter("file");
		
		if(path.equals("pds")) path += "/temp/";
		
		String realPathFile = request.getSession().getServletContext().getRealPath("/resources/data/" + path) + file;
		
		File downFile = new File(realPathFile);
		String downFileName = new String(file.getBytes("UTF-8"), "8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + downFileName);
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] bytes = new byte[2048];
		int data;
		while((data = fis.read(bytes, 0, bytes.length)) != -1) {
			sos.write(bytes, 0, data);
		}
		sos.flush();
		sos.close();
		fis.close();
		
		// 다운로드 완료후에 서버에 저장된 zip파일을 삭제처리한다.
		downFile.delete();
	}
	
//채팅창 띄우기
	@RequestMapping(value = "/webSocket/webSocket", method = RequestMethod.GET)
	public String webSocketGet() {
   return "webSocket/webSocket";
	}
	
	// 채팅메세지 DB에 저장하기
	@ResponseBody
	@RequestMapping(value = "/webSocket/msgInput", method = RequestMethod.POST)
	public String msgInputPost(WebChattingVO vo) {
		return homeService.setMsgInput(vo) + "";
	}
	
	// 1대1 채팅폼
	@RequestMapping(value = "/webSocket/endPoint", method = RequestMethod.GET)
	public String endPointGet() {
		return "webSocket/endPoint";
	}
	
}
	
