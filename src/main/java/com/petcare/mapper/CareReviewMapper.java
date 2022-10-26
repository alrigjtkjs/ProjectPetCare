package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.CareReview;

public interface CareReviewMapper {
	List<CareReview> selectPerPage(); // CareReview에서 전체를 쓰면서 전체를 띄울꺼라서 list에 담아서

	CareReview selectBySeq(String cr_seq);// content은 list에서 1개의 SEQ선택 후 들어오는것	 맨 앞 파란 CareReview가 return타입에
											// selectBySeq가 ID CareReview가 ResultType
	void insert(CareReview carereview);
	CareReview getcarereview(String cr_seq);
	void delete(String cr_seq);
	void edit(CareReview carereview);
}
 