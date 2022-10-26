package com.petcare.service;

import java.util.List;

import com.petcare.domain.Info;
import com.petcare.domain.InfoVo;

public interface InfoService {
	List<Info> listS();
	void insertS(Info info);
	void deleteS(String n_seq);
	void updateS(Info info);
	Info contentS(String n_seq);
	InfoVo getInfoVo(int cp, int ps);
}
