package com.spring.javaclassS6.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS6.vo.PdsVO;

public interface PdsService {

	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	public int setPdsUpload(MultipartHttpServletRequest mFile, PdsVO vo);

	public int setPdsDownNumPlus(int idx);

	public int setPdsDelete(int idx, String fSName, HttpServletRequest request);

	public PdsVO getPdsContent(int idx);

}
