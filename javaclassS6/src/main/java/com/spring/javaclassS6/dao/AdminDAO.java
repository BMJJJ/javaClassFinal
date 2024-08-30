package com.spring.javaclassS6.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.AdminVO;
import com.spring.javaclassS6.vo.BoardVO;
import com.spring.javaclassS6.vo.GuestVO;
import com.spring.javaclassS6.vo.MemberVO;

public interface AdminDAO {

	public int getMemberTotRecCnt(@Param("level") int level);

	public ArrayList<GuestVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int levelSelect);

	public int setMemberDeleteOk(@Param("idx") int idx);

	public MemberVO getMemberLevelCheck(@Param("mCount") String mCount,@Param("m99Count") String m99Count);

	public int setRboardComplaintInput(@Param("idx") int idx);

	public int setboardComplaintInput(@Param("vo") AdminVO vo);

	public ArrayList<BoardVO> getComplaintList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize,@Param("complaint") String complaint);

	public int totRecCnt();



}
