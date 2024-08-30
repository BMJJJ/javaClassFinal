package com.spring.javaclassS6.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS6.dao.MapandWeatherDAO;
import com.spring.javaclassS6.vo.BicycleVO;
import com.spring.javaclassS6.vo.KakaoAddressVO;

@Service
public class MapandWeatherServiceImpl implements MapandWeatherService {

	@Autowired
	MapandWeatherDAO mapandweatherDAO;

	@Override
	public KakaoAddressVO getKakaoAddressSearch(String address) {
		return mapandweatherDAO.getKakaoAddressSearch(address);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return mapandweatherDAO.getKakaoAddressList();
	}

	@Override
	public int setKakaoAddressInput(KakaoAddressVO vo) {
		return mapandweatherDAO.setKakaoAddressInput(vo);
	}

	@Override
	public void imgCheck(String content) {
//  0         1         2         3
//                01234567890123456789012345678901234567890
// <p><img alt="" src="/javaclassS/data/map/240626093722_5.jpg" style="height:433px; width:700px" /></p>
// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "map/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<BicycleVO> getBicycleData(int page) {
		List<BicycleVO> vos = new ArrayList<BicycleVO>();
		StringBuilder sb = new StringBuilder();
		try {
	    StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_bcycl_lend_api"); /*URL*/
	    //urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=서비스키"); /*Service Key*/
	    urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=7WMGwpEENfXvFnxY1efwZ4263gPHczyuehE7RyufhGeO4SZPOKxDisyWglB%2BjylPIXZJu8Xxs8BCWVbLqr9PdA%3D%3D"); /*Service Key*/
	    //urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("2", "UTF-8")); /*페이지 번호*/
	    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + page); /*페이지 번호*/
	    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("300", "UTF-8")); /*한 페이지 결과 수*/
	    urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*XML/JSON 여부*/
//	    urlBuilder.append("&" + URLEncoder.encode("bcyclLendNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*자전거대여소명*/
//	    urlBuilder.append("&" + URLEncoder.encode("bcyclLendSe","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*자전거대여소구분*/
//	    urlBuilder.append("&" + URLEncoder.encode("rdnmadr","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*소재지도로명주소*/
//	    urlBuilder.append("&" + URLEncoder.encode("lnmadr","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*소재지지번주소*/
//	    urlBuilder.append("&" + URLEncoder.encode("latitude","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*위도*/
//	    urlBuilder.append("&" + URLEncoder.encode("longitude","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*경도*/
//	    urlBuilder.append("&" + URLEncoder.encode("operOpenHm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*운영시작시각*/
//	    urlBuilder.append("&" + URLEncoder.encode("operCloseHm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*운영종료시각*/
//	    urlBuilder.append("&" + URLEncoder.encode("rstde","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*휴무일*/
//	    urlBuilder.append("&" + URLEncoder.encode("chrgeSe","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*요금구분*/
//	    urlBuilder.append("&" + URLEncoder.encode("bcyclUseCharge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*자전거이용요금*/
//	    urlBuilder.append("&" + URLEncoder.encode("bcyclHoldCharge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*자전거보유대수*/
//	    urlBuilder.append("&" + URLEncoder.encode("holderCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*거치대수*/
//	    urlBuilder.append("&" + URLEncoder.encode("airInjectorYn","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*공기주입기비치여부*/
//	    urlBuilder.append("&" + URLEncoder.encode("airInjectorType","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*공기주입기유형*/
//	    urlBuilder.append("&" + URLEncoder.encode("repairStandYn","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*수리대설치여부*/
//	    urlBuilder.append("&" + URLEncoder.encode("phoneNumber","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*관리기관전화번호*/
//	    urlBuilder.append("&" + URLEncoder.encode("institutionNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*관리기관명*/
//	    urlBuilder.append("&" + URLEncoder.encode("referenceDate","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터기준일자*/
//	    urlBuilder.append("&" + URLEncoder.encode("instt_code","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*제공기관코드*/
	    URL url = new URL(urlBuilder.toString());
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Content-type", "application/json");
	    //System.out.println("Response code: " + conn.getResponseCode());
	    BufferedReader rd;
	    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    } else {
	        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	    }
	    
	    String line;
	    while ((line = rd.readLine()) != null) {
	        sb.append(line);
	    }
	    rd.close();
	    conn.disconnect();
	    //System.out.println("응답 : " + sb.toString());
	    
	    // 배열 내의 각 JSON 객체 처리
	    // (방법2) vo객체 활용
			
			String str = sb.substring(sb.indexOf("["));		// 실제 JSON형식의 값만 추출([])
			
	    JSONArray jsonArray = new JSONArray(str);			// 넘어오는 값들을 JSON배열로 담기위해 선언
	    for (int i = 0; i < jsonArray.length(); i++) {// 배열안의 개수만큼 vos객체에 담아준다.
	      JSONObject jsonObject = jsonArray.getJSONObject(i);	// json자료를 개별객체로 변환
	      BicycleVO vo = new BicycleVO();
	      vo.setBcyclLendNm(jsonObject.getString("bcyclLendNm"));
	      vo.setBcyclLendSe(jsonObject.getString("bcyclLendSe"));
	      vo.setRdnmadr(jsonObject.getString("rdnmadr"));
	      vo.setLnmadr(jsonObject.getString("lnmadr"));
	      vo.setLatitude(jsonObject.getString("latitude"));
	      vo.setLongitude(jsonObject.getString("longitude"));
	      vo.setOperOpenHm(jsonObject.getString("operOpenHm"));
	      vo.setOperCloseHm(jsonObject.getString("operCloseHm"));
	      vo.setRstde(jsonObject.getString("rstde"));
	      vo.setChrgeSe(jsonObject.getString("chrgeSe"));
	      vo.setBcyclUseCharge(jsonObject.getString("bcyclUseCharge"));
	      vo.setBcyclHoldCharge(jsonObject.getString("bcyclHoldCharge"));
	      vo.setHolderCo(jsonObject.getString("holderCo"));
	      vo.setAirInjectorYn(jsonObject.getString("airInjectorYn"));
	      vo.setAirInjectorType(jsonObject.getString("airInjectorType"));
	      vo.setRepairStandYn(jsonObject.getString("repairStandYn"));
	      vo.setPhoneNumber(jsonObject.getString("phoneNumber"));
	      vo.setInstitutionNm(jsonObject.getString("institutionNm"));
	      vo.setReferenceDate(jsonObject.getString("referenceDate"));
	      vo.setInsttCode(jsonObject.getString("insttCode"));
	      //if(vo.getStationName() == null) vo.setStationName("등록정보없음");
	      vos.add(vo);
	    }
		} catch (UnsupportedEncodingException e) {e.printStackTrace();
		} catch (MalformedURLException e) {e.printStackTrace();
		} catch (IOException e) {e.printStackTrace();} catch (ParseException e) {e.printStackTrace();}
		return vos;
	}

	@Override
	public List<BicycleVO> getBicycleData2() {
		List<BicycleVO> vos = new ArrayList<BicycleVO>();
		StringBuilder sb = new StringBuilder();	// JSON데이터로 들어오는 값들을 vos객체로 담아주기위한 준비
		try {
			// 샘플URL http://openapi.seoul.go.kr:8088/인증키/json/bikeList/1/5/
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /*URL*/
			//urlBuilder.append("/" +  URLEncoder.encode("sample","UTF-8") ); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
			urlBuilder.append("/" +  URLEncoder.encode("6c4a54744d636a7332354d6e6a6164","UTF-8") ); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
			urlBuilder.append("/" +  URLEncoder.encode("json","UTF-8") ); /*요청파일타입 (xml,xmlf,xls,json) */
			urlBuilder.append("/" + URLEncoder.encode("bikeList","UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
			urlBuilder.append("/" + URLEncoder.encode("1","UTF-8")); /*요청시작위치 (sample인증키 사용시 5이내 숫자)*/
			urlBuilder.append("/" + URLEncoder.encode("200","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			//System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다.*/
			BufferedReader rd;
	
			// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			String line;
			while ((line = rd.readLine()) != null) {
					sb.append(line);
			}
			rd.close();
			conn.disconnect();
			//System.out.println(sb.toString());
			
	    // 배열 내의 각 JSON 객체 처리
	    // (방법2) vo객체 활용
			
			String str = sb.substring(sb.indexOf("["));		// 실제 JSON형식의 값만 추출([])
			
	    JSONArray jsonArray = new JSONArray(str);			// 넘어오는 값들을 JSON배열로 담기위해 선언
	    for (int i = 0; i < jsonArray.length(); i++) {// 배열안의 개수만큼 vos객체에 담아준다.
	      JSONObject jsonObject = jsonArray.getJSONObject(i);	// json자료를 개별객체로 변환
	      BicycleVO vo = new BicycleVO();
	      vo.setRackTotCnt(jsonObject.getString("rackTotCnt"));
	      vo.setStationId(jsonObject.getString("stationName"));
	      vo.setParkingBikeTotCnt(jsonObject.getString("parkingBikeTotCnt"));
	      vo.setShared(jsonObject.getString("shared"));
	      vo.setStationLatitude(jsonObject.getString("stationLatitude"));
	      vo.setStationLongitude(jsonObject.getString("stationLongitude"));
	      vo.setStationId(jsonObject.getString("stationId"));
	      if(vo.getStationName() == null) vo.setStationName("등록정보없음");
	      vos.add(vo);
	    }
	    //System.out.println("vos: " + vos);
		} catch (UnsupportedEncodingException e) {e.printStackTrace();
		} catch (MalformedURLException e) {e.printStackTrace();
		} catch (IOException e) {e.printStackTrace();
		} catch (ParseException e) {e.printStackTrace();}
		return vos;
	}

	@Override
	public void imgDelete(String content) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 26;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "map/" + imgFile;
			
			fileDelete(origFilePath);	// board폴더의 그림파일 삭제한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setaddressDelete(String address) {
		return mapandweatherDAO.setaddressDelete(address);
	}

	
}
