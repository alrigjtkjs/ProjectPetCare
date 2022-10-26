package com.petcare.service;

import java.util.List;
import com.petcare.domain.CareReview;


public interface CareReviewService {
	List<CareReview> selectperpageS();

	void insertS(CareReview carereview);

	/* void insertS(float cr_seq); */
	void deleteS(String cr_seq);
	void editS(CareReview carereview);//controller에서 service.[xx()]대가로가져옴
	//서비스와 연결해주는 거임  파라미터도 그대로가져와야함 
	
	CareReview getcarereviewS(String cr_seq); 
	CareReview selectBySeqS(String cr_seq); // CareReview= 리턴 selectBySeqS=Id(Table)

	
}
