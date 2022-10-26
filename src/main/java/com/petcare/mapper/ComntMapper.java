package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.Comnt;
import com.petcare.domain.ListVo;

public interface ComntMapper {
	void insertComnt(Comnt comment);
	List<Comnt> selectComntLists(ListVo listVo);
	long selectTotalRowCounts(String b_seq);
	void insertReply(Comnt comment);
	void updateComnt(Comnt comment);
	void deleteComnt(Comnt comment);
	void updateChildComnt(Comnt comment);
}
