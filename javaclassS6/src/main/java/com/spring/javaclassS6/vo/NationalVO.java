package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class NationalVO {
	
	//national
	private int idx;
	private String title;
	private int nPeople;
	private String content;
	private String photo;
	private String course;
	private String part;
	private String searchNearby;
	
	private int partCnt;
	
	private int nationalIdx;
	private String noneDate;
	
	private int hour_diff;	// 게시글을 24시간 경과유무 체크변수
	private int date_diff;	// 게시글을 일자 경과유무 체크변수
	private int replyCnt;		// 부모글의 댓글수를 저장하는 변수
	
}
