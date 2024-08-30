package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class PhotoGalleryVO {
	// photoGallery.sql
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String expl;
	private int readNum;
	private String pDate;
	private String thumbnail;
	private int good;
	private String part;
	private int photoCount;
	private int replyCnt;	// 댓글 개수
	
	
	private int replyIdx;
	private String replyMid;
	private int replyPhotoIdx;
	private String prDate;
	
}
