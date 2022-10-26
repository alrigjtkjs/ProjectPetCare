package com.petcare.mapper;

import com.petcare.domain.Member;

public interface MemberMapper {
	void signupM(Member member); //C
	String checkEmail(String id);
	String checkNick(String nick);
	String checkLogin(String id); //login
	Member getMyinfo(String id); //R
	void updateM(Member member); //U
	void deleteM(String id); //D
	String getNickname(String email);
}
