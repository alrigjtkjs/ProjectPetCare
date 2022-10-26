package com.petcare.mapper;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.LikesList;

public interface LikesListMapper {
	boolean selectHasLike(@Param("b_seq")String b_seq, @Param("email")String email);
	void insertLike(LikesList likesList);
	void deleteLike(LikesList likesList);
}
