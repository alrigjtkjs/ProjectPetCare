package com.petcare.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.Files;
import com.petcare.domain.FilesVo;

public interface FilesMapper {
	void insertFiles(FilesVo filesVo);
	List<Files> selectFiles(String b_seq);//sm_seq
	void deleteFiles(String fname);
	
	//LJY
	void insert(Files files);
	void delete(String n_seq);
	List<Files> filecontent(String n_seq);
	void fileupdateinsert(Files files);
	void fileupdatedelete(@Param("n_seq") String n_seq,@Param("ofname") String ofname);
	List<Files> fileupdatedeleteselect(@Param("n_seq") String n_seq,@Param("ofname") String ofname);
}