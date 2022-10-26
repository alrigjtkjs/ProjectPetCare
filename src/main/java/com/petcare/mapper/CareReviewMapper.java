package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.CareReview;

public interface CareReviewMapper {
	List<CareReview> selectPerPage(); // CareReview���� ��ü�� ���鼭 ��ü�� ��ﲨ�� list�� ��Ƽ�

	CareReview selectBySeq(String cr_seq);// content�� list���� 1���� SEQ���� �� �����°�	 �� �� �Ķ� CareReview�� returnŸ�Կ�
											// selectBySeq�� ID CareReview�� ResultType
	void insert(CareReview carereview);
	CareReview getcarereview(String cr_seq);
	void delete(String cr_seq);
	void edit(CareReview carereview);
}
 