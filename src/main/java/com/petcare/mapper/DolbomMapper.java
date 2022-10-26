package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.PageVo;
import com.petcare.domain.SearchList;

public interface DolbomMapper {
	List<Dolbom> list();
	Dolbom content(String dol_seq);
	List<Dolbom> selectPerPage(PageVo pageVo);
	long selectCount();
	void insertDolbom(Dolbom dolbom);
	
	List<Dolbomlist> waitList(String email);
	
	//List<Dolbomlist> receiveList(@Param("email") String email, @Param("state")String state);
	//List<Dolbomlist> sendList(@Param("email") String email, @Param("state")String state);
	List<Dolbomlist> receiveList(String email);
	List<Dolbomlist> sendList(String email);
	List<Dolbomlist> selectDList(String email);
	void setStateContinue(long seq);
	void setStateFinish(long seq);
	void deleteList(long seq);
	
	void insertDolbomList(Dolbomlist dolbomlist);
	/* 1005 °Ë»ö*/
	List<Dolbom> searchOption(SearchList searchlist);
	List<Dolbom> searchOptionDate(SearchList searchlist);
	List<Dolbom> searchDong(List<String> region);
	List<Dolbom> searchAll();
	List<Dolbom> searchAllOption(SearchList searchlist);
	List<Dolbom> searchAllOptionDate(SearchList searchlist);
	
	String chatEmail(String dol_seq);
	List<Dolbom> selectTime(String email);
}

