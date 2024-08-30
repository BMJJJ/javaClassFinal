package com.spring.javaclassS6.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.GuestVO;

public interface GuestDAO {

	public ArrayList<GuestVO> getGuestList();

	public int setGuestInput(@Param("vo") GuestVO vo);

	public int getTotRecCnt();

	public ArrayList<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")  int pageSize);

	public int setGeustDelete(@Param("idx") int idx);

}
