package com.petcare.domain;

import java.util.List;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class InfoVo {
	private List<Info> list;
	private int cp;
	private int ps;
	private long totalCount;
	private long totalPageCount;
	private int currentRange = 1;
	private int rangeCount;
	private int startPage = 1;
	private int endPage = 1;
	private int startIndex = 0;
	private int prevPage;
	private int nextPage;
	private int rangeSize = 10;
	
	public InfoVo(int cp, int ps){
		this.cp = cp;
		this.ps = ps;
	}
	public int getStartRow() {
		return (cp-1)*ps; //ex) 0 * 5 = 0
	}
	public int getEndRow() {
		return cp*ps; //ex) 1 * 5 = 5
	}
	
	public InfoVo(int cp, long totalCount, int ps, List<Info> list){
		this.cp = cp;
		this.totalCount = totalCount;
		this.ps = ps;
		this.list = list;
		this.totalPageCount = calTotalPageCount();
		setRangeCount(totalPageCount);
	}
	private long calTotalPageCount() {
		long tpc = totalCount/ps;
		if(totalCount%ps !=0) tpc++;
		
		return tpc;
	}
	public void setPageCount(int totalcount) {
        this.totalPageCount = (int) Math.ceil(totalcount*1.0/ps);
    }
	
	private void setRangeCount(long totalPageCount2) {
		this.rangeCount = (int) Math.ceil(totalPageCount2*1.0/rangeSize);
	}
	
	public void setRange(int cp) {
		setCurRange(cp);
		this.startPage = (currentRange-1)*rangeSize+1;
		this.endPage = (int) (startPage + rangeSize -1);
		
		if(endPage>totalPageCount) {
			this.endPage = (int) totalPageCount;
		}
		
		this.prevPage = cp -1;
		this.nextPage = cp +1;
	}
	public void setCurRange(int cp) {
		this.currentRange = (int)((cp-1)/rangeSize)+1;
	}
	
}
