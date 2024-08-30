package com.spring.javaclassS6.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.NationalVO;
import com.spring.javaclassS6.vo.ScheduleVO;

public interface ScheduleDAO {

	public List<NationalVO> getScheduleList(@Param("mid") String mid, @Param("ym") String ym, @Param("level") int level);

	public List<ScheduleVO> getScheduleMenu(@Param("mid") String mid, @Param("ymd") String ymd);

	public int setScheduleInputOk(@Param("vo") ScheduleVO vo);

	public int setScheduleUpdateOk(@Param("vo") ScheduleVO vo);

	public int setScheduleDeleteOk(@Param("idx") int idx);

	public List<NationalVO> getNationTotalList();

	public List<NationalVO> getNationNoneList(@Param("ym") String ym);

	public List<ScheduleVO> getMySchedule(@Param("mid") String mid);

	public ScheduleVO getScheduleById(@Param("idx") int idx);

	public int setScheduleUpdate(@Param("vo") ScheduleVO vo);

	public int setScheduleDelete(@Param("idx") int idx);

	public List<String> getNationNoneCourseList(@Param("ymd") String ymd);

}
