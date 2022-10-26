package com.petcare.service;

import java.util.List;

import com.petcare.domain.ListVo;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;

public interface ShareMarketService {
	List<ShareMarket> getShareMarketLists(ListVo listVo);
	long getTotalRowCounts();
	ShareMarket getShareMarketContents(String sm_seq);
	void setShareMarketContents(ShareMarket shareMarket);
	void renewShareMarketContents(ShareMarket shareMarket);
	void removeShareMarketContents(String sm_seq);
	PrevAndNext getPrevAndNext(String sm_seq);
	void renewShareMarketViews(String sm_seq);
}
