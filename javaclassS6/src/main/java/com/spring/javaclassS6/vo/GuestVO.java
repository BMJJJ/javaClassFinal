package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class GuestVO {
	private int idx;
	private String name;
	private String content;
	private String email;
	private String homePage;
	private String visitDate;
	private String hostIp;
}
