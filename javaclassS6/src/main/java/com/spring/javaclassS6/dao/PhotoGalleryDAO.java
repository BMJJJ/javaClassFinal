package com.spring.javaclassS6.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.PhotoGalleryVO;
import com.spring.javaclassS6.vo.PhotoGoodVO;
import com.spring.javaclassS6.vo.PhotoReplyVO;

public interface PhotoGalleryDAO {


	public ArrayList<PhotoGalleryVO> getPhotoGalleryList(@Param("startIndexNo") int startIndexNo, 
      @Param("pageSize") int pageSize, 
      @Param("part") String part, 
      @Param("choice") String choice);

	public int setPhotoGalleryInput(@Param("vo") PhotoGalleryVO vo);

	public int getLastInsertedPhotoGalleryIdx();

	public PhotoGalleryVO getPhotoGalleryIdxSearch(@Param("photoIdx") int photoIdx);

	public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(@Param("photoIdx") int photoIdx);

	public void incrementReadCount(@Param("photoIdx") int photoIdx);

	public PhotoGalleryVO getPhotoGalleryById(@Param("photoIdx") int photoIdx);

	public ArrayList<PhotoGalleryVO> getPhotoGalleryReplies(@Param("photoIdx") int photoIdx);

	public PhotoGoodVO findPhotoGood(@Param("photoIdx") int photoIdx,@Param("mid") String mid);

	public void incrementGoodCount(@Param("photoIdx") int photoIdx);

	public void deletePhotoGood(@Param("idx") int idx);

	public void decrementGoodCount(@Param("photoIdx") int photoIdx);

	public void insertPhotoGood(@Param("vo") PhotoGoodVO vo);

	public boolean isLikedMid(@Param("photoIdx") int photoIdx,@Param("mid") String mid);

	public PhotoReplyVO getPhotoParentReplyCheck(@Param("photoIdx") int photoIdx);

	public int setPhotoReplyInput(@Param("replyVO") PhotoReplyVO replyVO);

	public void setReplyOrderUpdate(@Param("photoIdx") int photoIdx,@Param("re_order") int re_order);

	public int getPhotoGalleryReplyCount(@Param("photoIdx") int photoIdx);

	public PhotoGalleryVO getPhotoContent(@Param("idx") int idx);

	public int setPhotoDelete(@Param("idx") int idx);

	public int setPhotoGalleryDelete(@Param("idx") int idx);

	public PhotoGalleryVO getPhotoIdxSearch(@Param("idx") int idx);

	public int deletePhotoReply(@Param("idx") int idx);

	//public List<PhotoGalleryVO> setPhotoGallerySingle(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int[] getPhotoGalleryIdxList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public PhotoGalleryVO setPhotoGallerySingle(@Param("idx") int idx);



}
