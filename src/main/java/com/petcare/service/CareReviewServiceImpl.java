package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.petcare.domain.CareReview;
import com.petcare.mapper.CareReviewMapper;
import lombok.AllArgsConstructor;

/*import lombok.extern.log4j.Log4j;
@Log4j*/
@AllArgsConstructor
@Service
public class CareReviewServiceImpl implements CareReviewService {
	private CareReviewMapper carereviewmapper;

	@Override
	public List<CareReview> selectperpageS() {
		return carereviewmapper.selectPerPage();
	}

	@Override
	public void insertS(CareReview carereview) {
		carereviewmapper.insert(carereview);
	}

	@Override
	public void deleteS(String cr_seq) {// 서비스와 메소드는 꼭 동일하게!!
		carereviewmapper.delete(cr_seq); // void가 있으면 return은 없음!
	}
	
	@Override
	public CareReview selectBySeqS(String cr_seq) {
		return carereviewmapper.selectBySeq(cr_seq);
	}
	
	@Override
	public CareReview getcarereviewS(String cr_seq) {
		return carereviewmapper.getcarereview(cr_seq); 
	}
	
	 @Override
	 public void editS(CareReview carereview) { 
		 carereviewmapper.edit(carereview);
		 }
	 
}