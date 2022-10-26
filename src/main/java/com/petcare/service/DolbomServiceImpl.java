package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.PageVo;
import com.petcare.domain.SearchList;
import com.petcare.mapper.DolbomMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class DolbomServiceImpl implements DolbomService{
	private DolbomMapper dolbommapper;
	
	@Override
	public List<Dolbom> listS(){
		return dolbommapper.list();
	}
	@Override
	public Dolbom contentS(String dol_seq){
		return dolbommapper.content(dol_seq);
	}
	@Override
	public List<Dolbom> selectPerPageS(int currentPage, int pageSize){
		long totalCount = dolbommapper.selectCount();
		PageVo pageVo = new PageVo(currentPage,pageSize,totalCount);
		List<Dolbom> dolbomlist = dolbommapper.selectPerPage(pageVo);
		return dolbomlist;
	}
	@Override
	public long selectCountS() {
		long totalCount = dolbommapper.selectCount();
		return totalCount;
	}
	@Override
	public void insertDolbomS(Dolbom dolbom) {
		dolbommapper.insertDolbom(dolbom);
	}
	@Override
	public List<Dolbomlist> waitList(String email){
		List<Dolbomlist> waitlist = dolbommapper.waitList(email);
		return waitlist;
	}
	@Override
	public List<Dolbomlist> receiveList(String email){
		List<Dolbomlist> receivelist = dolbommapper.receiveList(email);
		return receivelist;	
	}
	@Override
	public List<Dolbomlist> sendList(String email){
		List<Dolbomlist> sendlist = dolbommapper.sendList(email);
		return sendlist;	
	}
	@Override
	public List<Dolbomlist> selectDList(String email){
		List<Dolbomlist> dlist = dolbommapper.selectDList(email);
		return dlist;
	}
	@Override
	public void setStateContinue(long seq) {
		dolbommapper.setStateContinue(seq);
	}
	@Override
	public void setStateFinish(long seq) {
		dolbommapper.setStateFinish(seq);
	}
	@Override
	public void deleteList(long seq) {
		dolbommapper.deleteList(seq);
	}
	@Override
	public void insertDolbomListS(Dolbomlist dolbomlist){
		 dolbommapper.insertDolbomList(dolbomlist);
	}
	@Override
	public List<Dolbom> searchOption(SearchList searchlist){
		List<Dolbom> dolbomlist = dolbommapper.searchOption(searchlist);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchOptionDate(SearchList searchlist){
		List<Dolbom> dolbomlist = dolbommapper.searchOptionDate(searchlist);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchDong(List<String> region){
		List<Dolbom> dolbomlist = dolbommapper.searchDong(region);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchAll(){
		List<Dolbom> dolbomlist = dolbommapper.searchAll();
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchAllOption(SearchList searchlist){
		List<Dolbom> dolbomlist = dolbommapper.searchAllOption(searchlist);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchAllOptionDate(SearchList searchlist){
		List<Dolbom> dolbomlist = dolbommapper.searchAllOptionDate(searchlist);
		return dolbomlist;
	}
	@Override
	public String chatEmail(String dol_seq) {
		String gemail = dolbommapper.chatEmail(dol_seq);
		return gemail;
	}
	@Override
	public List<Dolbom> selectTime(String email) {
		List<Dolbom> times = dolbommapper.selectTime(email);
		return times;
	}
}
