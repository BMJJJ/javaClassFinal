package com.spring.javaclassS6.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS6.dao.GuestDAO;
import com.spring.javaclassS6.vo.GuestVO;

@Service
public class GuestServiceImpl implements GuestService {
	
	@Autowired
	private GuestDAO guestDAO;

	@Override
	public ArrayList<GuestVO> getGuestList() {
		return guestDAO.getGuestList();
	}

	@Override
	public int setGuestInput(GuestVO vo) {
		return guestDAO.setGuestInput(vo);
	}

	@Override
	public int getTotRecCnt() {
		return guestDAO.getTotRecCnt();
	}

	@Override
	public ArrayList<GuestVO> getGuestList(int startIndexNo, int pageSize) {
		return guestDAO.getGuestList(startIndexNo, pageSize);
	}

	@Override
	public int setGeustDelete(int idx) {
		return guestDAO.setGeustDelete(idx);
	}
	
}
