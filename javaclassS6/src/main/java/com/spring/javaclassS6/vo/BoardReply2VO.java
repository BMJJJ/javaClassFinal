package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class BoardReply2VO {
	private int idx;
	private int boardIdx;
	private int re_step;
	private int re_order;
	private String mid;
	private String nickName;
	private String wDate;
	private String hostIp;
	private String content;
	private String openSw;
}
