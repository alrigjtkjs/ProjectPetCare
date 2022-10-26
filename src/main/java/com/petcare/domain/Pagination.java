package com.petcare.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Pagination {
	// 현재 페이지 번호
	private long pageNum;
	// 현재 페이지 사이즈
	private long pageSize;
	// 전체 게시글 수
	private long totalRowCounts;
	// 전체 페이지 수
	private long totalPageCounts; //전체 게시글 수 / 현재 페이지 사이즈
	// 현재 페이지 첫 번째 번호
	private long firstPageScope;
	// 현재 페이지 마지막 번호
	private long lastPageScope;
	//처음 버튼, 마지막 버튼 표시 여부
	private boolean isPrev;
	private boolean isNext;
	
	public Pagination(ListVo listVo, long totalRowCounts) {
		setPageNum(listVo.getPageNum());
		setPageSize(listVo.getPageSize());
		setTotalRowCounts(totalRowCounts);
		calTotalPageCounts();
		calLastPageScope();
		calFirstPageScope();
		calIsPrev();
		calIsNext();
	}
	public void calTotalPageCounts() {
		long calResult = (long)(Math.ceil((double)getTotalRowCounts()/(double)getPageSize()));
		setTotalPageCounts(calResult);
	}
	public void calLastPageScope() {
		long calResult = (long)(Math.ceil((double)getPageNum()/(double)getPageSize())*getPageSize());
		setLastPageScope(calResult);
		if(getLastPageScope()>getTotalPageCounts()) {
			setLastPageScope(getTotalPageCounts());
		}
	}
	public void calFirstPageScope() {
		setFirstPageScope(getLastPageScope()-getPageSize()+1);
		if(getFirstPageScope()<=0) setFirstPageScope(1);
	}
	public void calIsPrev() {
		if(getPageNum() > 1) setPrev(true);
	}
	public void calIsNext() {
		if(getPageNum() < getTotalPageCounts()) setNext(true);
	}
}
