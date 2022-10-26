package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.Info;
import com.petcare.domain.InfoVo;

public interface InfoMapper {
	List<Info> list();
	void insert(Info info);
	void delete(String n_seq);
	void update(Info info);
	Info content(String n_seq);
	long selectCount();
	List<Info> selectPerPage(InfoVo infoVo);
}
