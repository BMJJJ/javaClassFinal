package com.spring.javaclassS6.service;

import java.util.List;

import com.spring.javaclassS6.vo.ScheduleVO;

public interface ScheduleService {

	public void getSchedule();

	public List<ScheduleVO> getScheduleMenu(String mid, String ymd);

	public int setScheduleInputOk(ScheduleVO vo);

	public int setScheduleUpdateOk(ScheduleVO vo);

	public int setScheduleDeleteOk(int idx);

}
