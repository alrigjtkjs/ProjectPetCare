package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Comnt;
import com.petcare.domain.ListVo;
import com.petcare.mapper.ComntMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class ComntServiceImpl implements ComntService {
	private ComntMapper mapper;
	
	@Override
	public void setComnt(Comnt comment) {
		mapper.insertComnt(comment);
	}
	
	@Override
	public List<Comnt> getComntLists(ListVo listVo){
		return mapper.selectComntLists(listVo);
	}
	
	@Override
	public long getTotalRowCounts(String b_seq) {
		return mapper.selectTotalRowCounts(b_seq);
	}
	
	@Override
	public void setReply(Comnt comment) {
		mapper.insertReply(comment);
	}
	
	@Override
	public void renewComnt(Comnt comment) {
		mapper.updateComnt(comment);
	}
	
	@Override
	public void removeComnt(Comnt comment) {
		mapper.deleteComnt(comment);
	}
	
	@Override
	public void renewChildComnt(Comnt comment) {
		mapper.updateChildComnt(comment);
	}
}
