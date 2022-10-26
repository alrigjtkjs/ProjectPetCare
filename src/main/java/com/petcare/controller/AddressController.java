package com.petcare.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Address;
import com.petcare.domain.MyDong;
import com.petcare.domain.NearDong;
import com.petcare.service.AddressService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor

@Controller
public class AddressController {
	public AddressService addressservice;
	
	@RequestMapping(value="/autoData",method=RequestMethod.POST)
	public @ResponseBody List<Address> getAddressList(String addr){
		log.info("@@@addr:"+addr);
		List<Address> list = addressservice.list(addr);
		log.info("@List:"+list);
		return list;
	}
	@RequestMapping(value="/addressdo",method=RequestMethod.GET)
	public @ResponseBody JSONObject loadLocation(Double x,Double y,HttpSession session) throws ParseException{
		String email = (String)session.getAttribute("email");
		log.info("@@x:"+x);
		log.info("@@y:"+y);
		
	    Double lat = y;
	    Double lon = x;
	    String apiUrl = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=" + lon + "&y=" + lat;
	    String addr = "";
	    
	    try {
	    	addr = getRegionAddress(getJSONData(apiUrl));
	    }catch (Exception e) {
	        e.printStackTrace();
	    }
	    addr = addr.substring(addr.indexOf(" ")+1);//00구 00동
	    MyDong mydong = new MyDong();
	    mydong.setUseremail(email);
	    mydong.setDongname(addr);
	    addressservice.settingDong(mydong);
	    //근처동네설정
	    List<String> nearlist = addressservice.nearlist(y, x);	    
	    for(int i=0;i<nearlist.size();i++) {
	    	NearDong neardong = new NearDong();
	    	String neardname = nearlist.get(i);
	    	neardname = neardname.substring(neardname.indexOf(" ")+1);
		    neardong.setUseremail(email);
		    neardong.setNeardname(neardname);
	    	addressservice.settingNearDong(neardong);
	    }
		String mydongname = addressservice.selectMydong(email);
		mydongname = "{\"mydong\":\""+mydongname+"\"}";
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(mydongname);//throws ParseException
	    return jsonObject;
	}
	public String getJSONData(String apiUrl) throws Exception{
		URL url = new URL(apiUrl);
		URLConnection conn = url.openConnection();
		String REST_KEY = "208aff43d6dd9838178996b10b9b52e1";
		conn.setRequestProperty("Authorization", "KakaoAK " + REST_KEY);
		StringBuffer response = new StringBuffer();
		BufferedReader br = null;
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
		String line="";
		while((line=br.readLine())!=null) {
			response.append(line);
		}
		return response.toString();
	}
	public String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
        JSONObject meta = (JSONObject) jObj.get("meta");
        long size = (long) meta.get("total_count");
        log.info("@@size"+size);
        String addressName="";
        String addressName2="";
        if(size>0){
        	JSONArray jArray = (JSONArray) jObj.get("documents");
        	for(int i=0;i<jArray.size();i++) {
        		JSONObject subJobj = (JSONObject) jArray.get(i);
        		if(subJobj.get("region_type").equals("H")) {//행정동:H, 법정동:B
        			addressName = (String)subJobj.get("address_name");
        		}else {
        			addressName2 = (String)subJobj.get("address_name");
        		}
        	}
        }
        return addressName;	
	}
	    
	@GetMapping("/address/setting")
	public ModelAndView checkMyDong(HttpSession session) {
		String email = (String)session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		List<String> nearlist = addressservice.selectNeardong(email);
		ModelAndView mv = new ModelAndView();
		log.info("@@@mydong"+mydong);
		mv.setViewName("address");
		mv.addObject("mydong", mydong);
		mv.addObject("nearlist", nearlist);
		return mv;	
	}
	@RequestMapping(value="/addressCancel",method=RequestMethod.GET)
	public @ResponseBody void cancelDong(HttpSession session) {
		String email = (String)session.getAttribute("email");
		addressservice.cancelDong(email);
	}
	
}