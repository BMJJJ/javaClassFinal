package com.spring.javaclassS6.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.WebChattingVO;

public interface HomeDAO {

	public int setMsgInput(@Param("vo") WebChattingVO vo);

}
