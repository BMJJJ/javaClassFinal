package com.spring.javaclassS6.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS6.dao.BoardDAO;
import com.spring.javaclassS6.vo.BoardGoodVO;
import com.spring.javaclassS6.vo.BoardReply2VO;
import com.spring.javaclassS6.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public ArrayList<BoardVO> getBoardList() {
		return boardDAO.getBoardList();
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public void setReadNumPlus(int idx) {
		boardDAO.setReadNumPlus(idx);
	}

	@Override
	public BoardVO getPreNextSearch(int idx, String str) {
		return boardDAO.getPreNextSearch(idx, str);
	}

	//content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'board'폴더에 복사
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/board/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "board/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void imgBackup(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/board/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public void imgDelete(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/map/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/board/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			
			fileDelete(origFilePath);	// board폴더의 그림파일 삭제한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 서버에 존재하는 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}

	@Override
	public BoardReply2VO getBoardParentReplyCheck(int boardIdx) {
		return boardDAO.getBoardParentReplyCheck(boardIdx);
	}

	@Override
	public int setBoardReplyInput(BoardReply2VO replyVO) {
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public List<BoardReply2VO> getBoardReply(int idx) {
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) {
		boardDAO.setReplyOrderUpdate(boardIdx,  re_order);
	}

	@Override
	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		return boardDAO.getBoardSearchList(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize, String part) {
		return boardDAO.getBoardList(startIndexNo, pageSize, part);
	}

	@Override
	public int deleteBoardReply(int idx) {
		return boardDAO.deleteBoardReply(idx);
	}

	@Override
	public String toggleGood(int boardIdx, String mid) {
		BoardGoodVO vo = boardDAO.findBoardGood(boardIdx, mid);
		System.out.println("vo :" + vo);
    if (vo == null) {
      // 좋아요가 없으면 추가
    	vo = new BoardGoodVO();
    	vo.setBoardIdx(boardIdx);
    	vo.setMidIdx(mid);
    	boardDAO.insertBoardGood(vo);
    	System.out.println("+1");
    	boardDAO.processGoodCount(boardIdx, 1);
      return "1"; // 좋아요 추가
  } else {
      // 좋아요가 있으면 취소
  	boardDAO.deletePhotoGood(vo.getIdx());
  	boardDAO.processGoodCount(boardIdx, -1);
  	System.out.println("-1");
    return "2"; // 좋아요 취소
  }
}

	@Override
	public boolean isLikedMid(int idx, String sMid) {
		return boardDAO.isLikedMid(idx, sMid);
	}

	@Override
	public int setComplaint(int idx) {
		return boardDAO.setComplaint(idx);
	}

	@Override
	public int setRboardComplaintInput(int idx) {
		return boardDAO.setRboardComplaintInput(idx);
	}


}