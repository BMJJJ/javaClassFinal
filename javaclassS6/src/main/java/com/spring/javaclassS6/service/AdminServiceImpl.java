package com.spring.javaclassS6.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS6.dao.AdminDAO;
import com.spring.javaclassS6.vo.AdminVO;
import com.spring.javaclassS6.vo.BoardVO;
import com.spring.javaclassS6.vo.GuestVO;
import com.spring.javaclassS6.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int getMemberTotRecCnt(int level) {
		return adminDAO.getMemberTotRecCnt(level);
	}

	@Override
	public ArrayList<GuestVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public int setMemberLevelCheck(int idx, int level) {
		return adminDAO.setMemberLevelCheck(idx, level);
	}

	@Override
	public String setLevelSelectCheck(String idxSelectArray, int levelSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		String str = "0";
		for(String idx : idxSelectArrays) {
			adminDAO.setMemberLevelCheck(Integer.parseInt(idx), levelSelect);
			str = "1";
		}
		return str;
	}

	@Override
	public int setMemberDeleteOk(int idx) {
		return adminDAO.setMemberDeleteOk(idx);
	}

	@Override
	public MemberVO getMemberLevelCheck(String mCount, String m99Count) {
		return adminDAO.getMemberLevelCheck(mCount,m99Count);
	}

	@Override
	public int setRboardComplaintInput(int idx) {
		return adminDAO.setRboardComplaintInput(idx);
	}

	@Override
	public int setboardComplaintInput(AdminVO vo) {
		return adminDAO.setboardComplaintInput(vo);
	}

	@Override
	public ArrayList<BoardVO> getComplaintList(int startIndexNo, int pageSize, String complaint) {
		return adminDAO.getComplaintList(startIndexNo, pageSize, complaint);
	}

	
	
}
