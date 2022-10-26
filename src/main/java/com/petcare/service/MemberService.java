package com.petcare.service;

import com.petcare.domain.Member;

public interface MemberService {
	void signupMS(Member member);
	String checkEmailS(String id);
	String checkNickS(String nick);
	String checkLoginS(String id);
	Member getMyinfoS(String id);
	void updateMS(Member member);
	void deleteMS(String id);
	String getNicknameS(String email);
}
