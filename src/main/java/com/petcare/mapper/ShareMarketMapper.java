package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.ListVo;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;

public interface ShareMarketMapper {
	List<ShareMarket> selectShareMarketLists(ListVo listVo);
	long selectTotalRowCounts();
	ShareMarket selectShareMarketContents(String sm_seq);
	void insertShareMarketContents(ShareMarket shareMarket);
	void updateShareMarketContents(ShareMarket shareMarket);
	void deleteShareMarketContents(String sm_seq);
	PrevAndNext selectPrevAndNext(String sm_seq);
	void updateShareMarketViews(String sm_seq);
}
