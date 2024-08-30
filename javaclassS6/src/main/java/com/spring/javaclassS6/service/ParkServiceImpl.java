package com.spring.javaclassS6.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS6.dao.NationalDAO;
import com.spring.javaclassS6.vo.NationalVO;
import com.spring.javaclassS6.vo.PhotoGalleryVO;
import com.spring.javaclassS6.vo.ScheduleVO;

@Service
public class ParkServiceImpl implements ParkService {

	@Autowired
	NationalDAO parkDAO;


	@Override
	public void imgCheck(String photo) {
		//  							0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS6/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS6/data/park/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = photo.substring(photo.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
		String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
		
		String origFilePath = realPath + "ckeditor/" + imgFile;
		String copyFilePath = realPath + "park/" + imgFile;
		
		fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
		
		if(nextImg.indexOf("src=\"/") == -1) sw = false;
		else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
}

	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setParkInput(NationalVO vo) {
		return parkDAO.setParkInput(vo);
	}

	@Override
	public List<NationalVO> getParkList(String part) {
		return parkDAO.getParkList(part);
	}

	@Override
	public List<ScheduleVO> getAllVisit(String ymd) {
		return parkDAO.getAllVisit(ymd);
	}

	@Override
	public NationalVO getNationalVisit(int idx) {
		return parkDAO.getNationalVisit(idx);
	}

	@Override
	public ScheduleVO getNationalVisitCnt(int idx, String ymd) {
		return parkDAO.getNationalVisitCnt(idx, ymd);
	}

	@Override
	public int scheduleInput(ScheduleVO vo) {
		return parkDAO.scheduleInput(vo);
	}
	
}
