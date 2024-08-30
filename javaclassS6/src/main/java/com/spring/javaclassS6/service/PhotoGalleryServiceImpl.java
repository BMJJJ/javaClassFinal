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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS6.common.JavaclassProvide;
import com.spring.javaclassS6.dao.PhotoGalleryDAO;
import com.spring.javaclassS6.vo.PhotoGalleryVO;
import com.spring.javaclassS6.vo.PhotoGoodVO;
import com.spring.javaclassS6.vo.PhotoReplyVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class PhotoGalleryServiceImpl implements PhotoGalleryService {

	@Autowired
	PhotoGalleryDAO photoGalleryDAO;

	@Autowired
	JavaclassProvide javaclassProvide;

	
	@Override
	public ArrayList<PhotoGalleryVO> getPhotoGalleryList(int startIndexNo, int pageSize, String part, String imsiChoice) {
		return photoGalleryDAO.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);
	}

	@Override
	public int setPhotoGalleryInput(PhotoGalleryVO vo) {
		return photoGalleryDAO.setPhotoGalleryInput(vo);
	}

	@Override
	public int getLastInsertedPhotoGalleryIdx() {
		return photoGalleryDAO.getLastInsertedPhotoGalleryIdx();
	}

	@Override
	public void imgCheck(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "photoGallery/" + imgFile;
			
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
	public String setThumbnail(String content) {
		String res = "";
		try {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
			// 썸네일 파일이 저장될 경로설정
			File realFileName = new File(realPath + content);
			
			// 썸메일 이미지 생성 저장하기
			realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
			String thumbnailSaveName = "s_" + content;
			File thumbnailFile = new File(realPath + thumbnailSaveName);
			
			int width = 270;
			int height = 200;
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);
			
			res = thumbnailSaveName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	  @Override
	  public void setPhotoGalleryReadNumPlus(int photoIdx) {
	  	photoGalleryDAO.incrementReadCount(photoIdx);
	  }
	  
	  @Override
	  public PhotoGalleryVO getPhotoGalleryIdxSearch(int photoIdx) {
		  PhotoGalleryVO vo = photoGalleryDAO.getPhotoGalleryById(photoIdx); 
		  return vo; 
	  }
	  
	  @Override
	  public ArrayList<PhotoGalleryVO> getPhotoGalleryReply(int photoIdx) {
	  	return photoGalleryDAO.getPhotoGalleryReplies(photoIdx);
	  }

		@Override
    public String toggleGood(int photoIdx, String mid) {
      PhotoGoodVO vo = photoGalleryDAO.findPhotoGood(photoIdx, mid);
      if (vo == null) {
        // 좋아요가 없으면 추가
      	vo = new PhotoGoodVO();
      	vo.setPhotoIdx(photoIdx);
      	vo.setMidIdx(mid);
        photoGalleryDAO.insertPhotoGood(vo);
        photoGalleryDAO.incrementGoodCount(photoIdx);
        return "1"; // 좋아요 추가
    } else {
        // 좋아요가 있으면 취소
        photoGalleryDAO.deletePhotoGood(vo.getIdx());
        photoGalleryDAO.decrementGoodCount(photoIdx);
        return "2"; // 좋아요 취소
    }
	}

		@Override
		public boolean isLikedMid(int photoIdx, String sMid) {
			return photoGalleryDAO.isLikedMid(photoIdx, sMid);
		}

		@Override
		public PhotoReplyVO getPhotoParentReplyCheck(int photoIdx) {
			return photoGalleryDAO.getPhotoParentReplyCheck(photoIdx);
		}

		@Override
		public int setPhotoReplyInput(PhotoReplyVO replyVO) {
			return photoGalleryDAO.setPhotoReplyInput(replyVO);
		}

		@Override
		public void setReplyOrderUpdate(int photoIdx, int re_order) {
			photoGalleryDAO.setReplyOrderUpdate(photoIdx,re_order);
		}

		@Override
		public int getPhotoGalleryReplyCount(int photoIdx) {
			return photoGalleryDAO.getPhotoGalleryReplyCount(photoIdx);
		}

		@Override
		public PhotoGalleryVO getPhotoContent(int idx) {
			return photoGalleryDAO.getPhotoContent(idx);
		}

		@Override
		public void imgDelete(String content) {
			//				0					1					2					3
			//				0123456789012345678901234567890123456
			//<p><img src="/javaclassS6/data/photoGallery/240716194802_127.jpg" style="height:852px; width:1280px" /><img src="/javaclassS6/data/photoGallery/240716194802_143.jpg" style="height:1040px; width:1387px" /></p>

			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
			
			int position = 36;
			String nextImg = content.substring(content.indexOf("src=\"/") + position);
			boolean sw = true;
			while(sw) {
				String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
				
				String origFilePath = realPath + "photoGallery/" + imgFile;
				
				fileDelete(origFilePath);	
				
				if(nextImg.indexOf("src=\"/") == -1) sw = false;
				else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}

		private void fileDelete(String origFilePath) {
			File delFile = new File(origFilePath);
			if(delFile.exists()) delFile.delete();
		}

		/*@Override
		public int setPhotoDelete(int idx) {
			
			return photoGalleryDAO.setPhotoDelete(idx);
		}*/
		@Transactional
		@Override
		public int setPhotoDelete(int idx) {
			PhotoGalleryVO vo = photoGalleryDAO.getPhotoIdxSearch(idx);
			
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");

			int position = 36;	// photoCount는 그림파일 개수
			
			String nextImg = vo.getContent().substring(vo.getContent().indexOf("src=\"/")+position);
			
			while(true) {
				String imgFile = nextImg.substring(0, nextImg.indexOf("\""));  // 순수한 그림파일만 가져온다.
				
				// 서버에 존재하는 파일을 삭제한다.
				new File(realPath + imgFile).delete();
				
				if(nextImg.indexOf("src=\"/") == -1) break;
				else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
			// 서버의 그림파일을 모두 삭제하였으면 현재 내역을 DB에서 포토갤러리의 정보를 삭제한다.
			return photoGalleryDAO.setPhotoGalleryDelete(idx);
		}

		@Override
		public int deletePhotoReply(int idx) {
			return photoGalleryDAO.deletePhotoReply(idx);
		}

		@Override
		public List<PhotoGalleryVO> setPhotoGallerySingle(int startIndexNo, int pageSize) {
			List<PhotoGalleryVO> vos = new ArrayList<PhotoGalleryVO>();
			int[] idxs = photoGalleryDAO.getPhotoGalleryIdxList(startIndexNo, pageSize);
			
			PhotoGalleryVO photoVo = null;
			PhotoGalleryVO vo = null;
			for(int idx : idxs) {
				photoVo = photoGalleryDAO.setPhotoGallerySingle(idx);
				
				vo = new PhotoGalleryVO();
				vo.setIdx(photoVo.getIdx());
				vo.setPart(photoVo.getPart());
				vo.setTitle(photoVo.getTitle());
				vo.setPhotoCount(photoVo.getPhotoCount());
				vo.setContent(photoVo.getContent());
				vos.add(vo);
			}
			//System.out.println("vos : " + vos.get(0));
			return vos;
		}
		
	}
