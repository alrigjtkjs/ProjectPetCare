package com.petcare.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcare.domain.Chatting;
import com.petcare.mapper.ChattingMapper;

import lombok.AllArgsConstructor;



@AllArgsConstructor
@Service
public class ChattingServiceImpl implements ChattingService {
	
	private ChattingMapper chattingmapper;
	@Override
	public List<Chatting> listS(String c_owner, String c_guest) {
		return chattingmapper.list(c_owner, c_guest);
	}
	@Override
	public List<Chatting> listallS() {
		return chattingmapper.listall();
	}

	@Override
	public void insertS(Chatting chatting) {
		chattingmapper.insert(chatting);

	}

	@Override
	public void deleteS(String c_number) {
		chattingmapper.delete(c_number);

	}

	@Override
	public void updateS(String c_number) {
		chattingmapper.update(c_number);

	}
	@Override
	public List<Chatting> listsearchS(String c_owner,String c_guest, String c_subject) {
		return chattingmapper.listsearch(c_owner, c_guest, c_subject);
	}

}
