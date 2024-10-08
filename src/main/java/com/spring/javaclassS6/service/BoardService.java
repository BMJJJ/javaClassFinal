package com.spring.javaclassS6.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS6.vo.BoardReply2VO;
import com.spring.javaclassS6.vo.BoardVO;

public interface BoardService {
	
	public ArrayList<BoardVO> getBoardList();

	public int setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize, String part);

	public void setReadNumPlus(int idx);

	public BoardVO getPreNextSearch(int idx, String str);

	public void imgCheck(String content);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setBoardUpdate(BoardVO vo);

	public int setBoardDelete(int idx);

	public BoardReply2VO getBoardParentReplyCheck(int boardIdx);

	public int setBoardReplyInput(BoardReply2VO replyVO);

	public List<BoardReply2VO> getBoardReply(int idx);

	public void setReplyOrderUpdate(int boardIdx, int re_order);

	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String search, String searchString);

	public int deleteBoardReply(int idx);

	public String toggleGood(int idx, String mid);

	public boolean isLikedMid(int idx, String sMid);

	public int setComplaint(int idx);

	public int setRboardComplaintInput(int idx);



}
