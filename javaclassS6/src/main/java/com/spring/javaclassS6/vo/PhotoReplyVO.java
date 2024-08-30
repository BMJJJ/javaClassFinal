package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class PhotoReplyVO {
	private int idx;
	private int photoIdx;
	private int re_step;
	private int re_order;
	private String mid;
	private String prDate;
	private String content;
	private String openSw;
	
	private String replyCnt;
}
