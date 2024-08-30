package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class ScheduleVO {
	
	private int idx;
	private int nationalIdx;
	private String course;
	private String mid;
	private String visitDate;
	private int visitCnt;
	private String content;
	private String visitCheck;
	
	
	private String ymd;
	private int partCnt;
	
	
	private String part;
	
	private int allVisitCnt;
}
