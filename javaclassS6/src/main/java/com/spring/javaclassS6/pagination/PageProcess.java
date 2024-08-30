package com.spring.javaclassS6.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS6.dao.AdminDAO;
import com.spring.javaclassS6.dao.BoardDAO;
import com.spring.javaclassS6.dao.NationalDAO;
import com.spring.javaclassS6.dao.PdsDAO;
import com.spring.javaclassS6.vo.PageVO;

@Service
public class PageProcess {

	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	PdsDAO pdsDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("board")) {
			if(searchString.equals(""))	{
				totRecCnt = boardDAO.totRecCnt(part);
			}
			else {
				search = part;
				totRecCnt = boardDAO.totRecCntSearch(search, searchString);
			}
		}
		else if(section.equals("complaint")) totRecCnt = adminDAO.totRecCnt();
		else if(section.equals("pds")) totRecCnt = pdsDAO.totRecCnt(part);
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearh(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
				
		return pageVO;
	}

	
	
}
