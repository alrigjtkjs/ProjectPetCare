package com.petcare.service;

import java.util.List;
import com.petcare.domain.CareReview;


public interface CareReviewService {
	List<CareReview> selectperpageS();

	void insertS(CareReview carereview);

	/* void insertS(float cr_seq); */
	void deleteS(String cr_seq);
	void editS(CareReview carereview);//controller���� service.[xx()]�밡�ΰ�����
	//���񽺿� �������ִ� ����  �Ķ���͵� �״�ΰ����;��� 
	
	CareReview getcarereviewS(String cr_seq); 
	CareReview selectBySeqS(String cr_seq); // CareReview= ���� selectBySeqS=Id(Table)

	
}
