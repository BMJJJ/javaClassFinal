package com.spring.javaclassS6.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.javaclassS6.vo.NationalVO;
import com.spring.javaclassS6.vo.ScheduleVO;

@Service
public interface ParkService {

	public void imgCheck(String photo);

	public int setParkInput(NationalVO vo);

	public List<NationalVO> getParkList(String part);

	public List<ScheduleVO> getAllVisit(String ymd);

	public NationalVO getNationalVisit(int idx);

	public ScheduleVO getNationalVisitCnt(int idx, String ymd);

	public int scheduleInput(ScheduleVO vo);


}
