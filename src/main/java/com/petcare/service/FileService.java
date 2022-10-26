package com.petcare.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.petcare.domain.Files;

public interface FileService {
	void setFiles(ArrayList<MultipartFile> multipartFiles, String b_seq, String seqinit);//seq
	List<Files> getFiles(String b_seq);//seq
	ResponseEntity<Resource> findFiles(String imgName);
	void removeFiles(String fname);
	
	//파일스토어
	void insertS(Files files);
	Map<String, List<Object>> getUpdateFileName();
	List<Files> filecontentS(String n_seq);
	MultipartHttpServletRequest getMultipartRequest();
	void setMultipartRequest(MultipartHttpServletRequest multipartRequest);
	void deleteS(String n_seq);
	void fileupdateinsertS(Files files);
	void fileupdatedeleteS(String n_seq, String ofname);
	List<Files> fileupdatedeleteselectS(String n_seq, String ofname);
}