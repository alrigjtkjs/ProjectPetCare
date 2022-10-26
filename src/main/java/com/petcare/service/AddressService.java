package com.petcare.service;

import java.util.List;

import com.petcare.domain.Address;
import com.petcare.domain.MyDong;
import com.petcare.domain.NearDong;

public interface AddressService {
	List<Address> list(String addr);
	List<String> nearlist(Double lat, Double lon);
	void settingDong(MyDong mydong);
	void settingNearDong(NearDong neardong);
	
	String selectMydong(String useremail);
	List<String> selectNeardong(String useremail);
	
	void cancelDong(String useremail);
}
