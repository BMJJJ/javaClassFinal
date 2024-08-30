package com.spring.javaclassS6.service;

import java.util.ArrayList;

import com.spring.javaclassS6.vo.GuestVO;

public interface GuestService {

	public ArrayList<GuestVO> getGuestList();

	public int setGuestInput(GuestVO vo);

	public int getTotRecCnt();

	public ArrayList<GuestVO> getGuestList(int startIndexNo, int pageSize);

	public int setGeustDelete(int idx);

}
