package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Address;
import com.petcare.domain.MyDong;
import com.petcare.domain.NearDong;
import com.petcare.mapper.AddressMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class AddressServiceImpl implements AddressService{
private AddressMapper addressmapper;
	
	@Override
	public List<Address> list(String addr){
		return addressmapper.selectByAddr(addr);
	}
	@Override
	public List<String> nearlist(Double y, Double x){
		log.info("@@@service");
		return addressmapper.nearAddr(y, x);
	}
	@Override
	public void settingDong(MyDong mydong) {
		addressmapper.settingDong(mydong);
	}
	@Override
	public void settingNearDong(NearDong neardong) {
		addressmapper.settingNearDong(neardong);
	}
	@Override
	public String selectMydong(String useremail) {
		return addressmapper.selectMydong(useremail);
	}
	@Override
	public List<String> selectNeardong(String useremail){
		return addressmapper.selectNeardong(useremail);
	}
	@Override
	public void cancelDong(String useremail) {
		addressmapper.cancelDong(useremail);
	}
}
