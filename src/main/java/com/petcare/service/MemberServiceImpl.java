package com.petcare.service;

import org.springframework.stereotype.Service;

import com.petcare.domain.Member;
import com.petcare.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper;	
	@Override
	public void signupMS(Member member) {
		mapper.signupM(member);
	}
	@Override
	public String checkEmailS(String id) {
		return mapper.checkEmail(id);
	}
	@Override
	public String checkNickS(String nick) {
		return mapper.checkNick(nick);
	}
	@Override
	public String checkLoginS(String id) {
		return mapper.checkLogin(id);
	}
	@Override
	public Member getMyinfoS(String id) {
		return mapper.getMyinfo(id);
	}
	@Override
	public void updateMS(Member member) {
		mapper.updateM(member);
	}
	@Override
	public void deleteMS(String id) {
		mapper.deleteM(id);
	}
	@Override
	public String getNicknameS(String email) {
		return mapper.getNickname(email);
	}
}
