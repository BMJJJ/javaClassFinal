package com.spring.javaclassS6.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS6.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public void setMemberInforUpdate(String mid,int point);

	public int setPwdChangeOk(String mid, String pwd);

	public String fileUpload(MultipartFile fName, String mid, String photo);

	public ArrayList<MemberVO> getMemberList(int level);

	public int setMemberUpdateOk(MemberVO vo);

	public int setUserDel(String mid);

	public MemberVO getMemberNameCheck(String name);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInput(String mid, String encode, String nickName, String email);

	public void setMemberUpgrade(MemberVO vo);

	public int getBoardCount(String mid);

	public int getGuestCount(String nickName);

	public int getPdsCount(String mid);

}
