package com.petcare.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.Chatting;

public interface ChattingService {
	List<Chatting> listS(String c_owner, String c_guest);
	List<Chatting> listallS();
	List<Chatting> listsearchS(String c_owner,String c_guest, String c_subject);
	void insertS(Chatting chatting);
	void deleteS(String c_number);
	void updateS(String c_number);
}
