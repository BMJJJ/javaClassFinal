package com.spring.javaclassS6.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.NationalVO;
import com.spring.javaclassS6.vo.ScheduleVO;

public interface NationalDAO {

	public int setParkInput(@Param("vo") NationalVO vo);

	public List<NationalVO> getParkList(@Param("part") String part);

	public List<ScheduleVO> getAllVisit(@Param("ymd") String ymd);

	public NationalVO getNationalVisit(@Param("idx") int idx);

	public ScheduleVO getNationalVisitCnt(@Param("idx") int idx, @Param("ymd") String ymd);

	public int scheduleInput(@Param("vo") ScheduleVO vo);



}
