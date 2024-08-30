package com.spring.javaclassS6.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS6.vo.KakaoAddressVO;

public interface MapandWeatherDAO {

	public KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);

	public int setKakaoAddressInput(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public KakaoAddressVO getAddressSearch(@Param("address") int address);

	public int setaddressDelete(@Param("address") String address);

}
