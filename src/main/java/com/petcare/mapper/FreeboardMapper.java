package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.Freeboard;

public interface FreeboardMapper {
	List<Freeboard> list();
	void write(Freeboard freeboard);
	Freeboard content(String fb_seq);
	void delete(String fb_seq);
	void update(Freeboard freeboard);
	Freeboard updateList(String fb_seq);
}