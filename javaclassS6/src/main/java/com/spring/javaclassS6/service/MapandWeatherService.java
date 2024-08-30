package com.spring.javaclassS6.service;

import java.util.List;

import com.spring.javaclassS6.vo.BicycleVO;
import com.spring.javaclassS6.vo.KakaoAddressVO;

public interface MapandWeatherService{

	public KakaoAddressVO getKakaoAddressSearch(String address);

	public int setKakaoAddressInput(KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public void imgCheck(String content);

	public List<BicycleVO> getBicycleData(int page);

	public List<BicycleVO> getBicycleData2();

	public void imgDelete(String content);

	public int setaddressDelete(String address);

}
