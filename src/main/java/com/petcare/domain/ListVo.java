package com.petcare.domain;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Log4j
@Data
public class ListVo {
	private long pageNum;
	private long pageSize;
	private long startRowPerPage;
	private long endRowPerPage;
	private String b_seq;
	
	public ListVo(long pageNum, long pageSize){
		setPageNum(pageNum);
		setPageSize(pageSize);
		calStartRowPerPage();
		calEndRowPerPage();
	}
	
	public void calStartRowPerPage() {
		setStartRowPerPage((getPageNum()-1) * getPageSize());
		log.info(getStartRowPerPage());
	}
	public void calEndRowPerPage() {
		setEndRowPerPage(getPageNum() * getPageSize());
		log.info(getEndRowPerPage());
	}
}
