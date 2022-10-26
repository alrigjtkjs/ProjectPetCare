package com.petcare.service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import com.petcare.domain.LikesList;
import com.petcare.mapper.LikesListMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class LikesListServiceImpl implements LikesListService {
	private LikesListMapper mapper;
	
	@Override
	public boolean getHasLike(String b_seq, String email) {
		return mapper.selectHasLike(b_seq, email);
	}
	
	@Override
	public void setLike(LikesList likesList) {
		mapper.insertLike(likesList);
	}
	
	@Override
	public void removeLike(LikesList likesList) {
		mapper.deleteLike(likesList);
	}
}
