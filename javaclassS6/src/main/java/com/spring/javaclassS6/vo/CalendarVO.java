package com.spring.javaclassS6.vo;

import lombok.Data;

@Data
public class CalendarVO {
	 private int idx;
   private String title;
   private String startTime;
   private String endTime;
   private boolean allDay;
}
