package com.petcare.service;
import java.util.List;

import com.petcare.domain.Comnt;
import com.petcare.domain.ListVo;

public interface ComntService {
	void setComnt(Comnt comment);
	List<Comnt> getComntLists(ListVo listVo);
	long getTotalRowCounts(String b_seq);
	void setReply(Comnt comment);
	void renewComnt(Comnt comment);
	void removeComnt(Comnt comment);
	void renewChildComnt(Comnt comment);
}
