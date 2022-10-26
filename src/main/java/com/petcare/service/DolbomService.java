package com.petcare.service;

import java.util.List;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.SearchList;

public interface DolbomService {
	List<Dolbom> listS();
	Dolbom contentS(String dol_seq);	
	List<Dolbom> selectPerPageS(int currentPage, int pageSize);
	long selectCountS();
	void insertDolbomS(Dolbom dolbom);
	
	List<Dolbomlist> waitList(String email);
	
	//List<Dolbomlist> receiveList(String email, String state);
	//List<Dolbomlist> sendList(String email, String state);
	List<Dolbomlist> receiveList(String email);
	List<Dolbomlist> sendList(String email);
	List<Dolbomlist> selectDList(String email);
	void setStateContinue(long seq);
	void setStateFinish(long seq);
	void deleteList(long seq);
	
	void insertDolbomListS(Dolbomlist dolbomlist);
	//°Ë»ö
	List<Dolbom> searchOption(SearchList searchlist);
	List<Dolbom> searchOptionDate(SearchList searchlist);
	List<Dolbom> searchDong(List<String> region);
	List<Dolbom> searchAll();
	List<Dolbom> searchAllOption(SearchList searchlist);
	List<Dolbom> searchAllOptionDate(SearchList searchlist);
	
	String chatEmail(String dol_seq);
	List<Dolbom> selectTime(String email);
}
