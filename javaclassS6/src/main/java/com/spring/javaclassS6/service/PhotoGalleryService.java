package com.spring.javaclassS6.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS6.vo.BoardVO;
import com.spring.javaclassS6.vo.PhotoGalleryVO;
import com.spring.javaclassS6.vo.PhotoReplyVO;

public interface PhotoGalleryService {

	public ArrayList<PhotoGalleryVO> getPhotoGalleryList(int startIndexNo, int pageSize, String part, String imsiChoice);

	public int setPhotoGalleryInput(PhotoGalleryVO vo);

	public int getLastInsertedPhotoGalleryIdx();

	public void imgCheck(String content);

	public String setThumbnail(String content);


	public void setPhotoGalleryReadNumPlus(int photoIdx);
	  
	public PhotoGalleryVO getPhotoGalleryIdxSearch(int photoIdx);
	  
	public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(int photoIdx);

	public String toggleGood(int idx, String mid);

	public boolean isLikedMid(int photoIdx, String sMid);

	public PhotoReplyVO getPhotoParentReplyCheck(int photoIdx);

	public int setPhotoReplyInput(PhotoReplyVO replyVO);

	public void setReplyOrderUpdate(int photoIdx, int re_order);

	public int getPhotoGalleryReplyCount(int photoIdx);

	public PhotoGalleryVO getPhotoContent(int idx);

	public void imgDelete(String content);

	public int setPhotoDelete(int idx);

	public int deletePhotoReply(int idx);

	public List<PhotoGalleryVO> setPhotoGallerySingle(int startIndexNo, int pageSize);






}
