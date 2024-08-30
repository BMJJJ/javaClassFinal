package com.spring.javaclassS6.service;

import java.util.ArrayList;

import com.spring.javaclassS6.vo.AdminVO;
import com.spring.javaclassS6.vo.BoardVO;
import com.spring.javaclassS6.vo.GuestVO;
import com.spring.javaclassS6.vo.MemberVO;

public interface AdminService {

	public int getMemberTotRecCnt(int level);

	public ArrayList<GuestVO> getMemberList(int startIndexNo, int pageSize, int level);

	public int setMemberLevelCheck(int idx, int level);

	public String setLevelSelectCheck(String idxSelectArray, int levelSelect);

	public int setMemberDeleteOk(int idx);

	public MemberVO getMemberLevelCheck(String mCount, String m99Count);

	public int setRboardComplaintInput(int idx);

	public int setboardComplaintInput(AdminVO vo);

	public ArrayList<BoardVO> getComplaintList(int startIndexNo, int pageSize, String complaint);




}
