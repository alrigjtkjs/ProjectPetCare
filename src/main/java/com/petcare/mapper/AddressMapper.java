package com.petcare.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.Address;
import com.petcare.domain.MyDong;
import com.petcare.domain.NearDong;

public interface AddressMapper {
	
	List<Address> selectByAddr(String addr);
	List<String> nearAddr(@Param("y")Double y, @Param("x")Double x);
	void settingDong(MyDong mydong);
	void settingNearDong(NearDong neardong);
	
	String selectMydong(String useremail);
	List<String> selectNeardong(String useremail);
	
	void cancelDong(String useremail);
}

