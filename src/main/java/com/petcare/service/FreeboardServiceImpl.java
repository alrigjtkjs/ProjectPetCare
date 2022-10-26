package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Freeboard;
import com.petcare.mapper.FreeboardMapper;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class FreeboardServiceImpl implements FreeboardService{
	private FreeboardMapper freeboardMapper;
	
	@Override
	public List<Freeboard> list(){
		return freeboardMapper.list();
	}

	@Override
	public Freeboard content(String fb_seq) {
		return freeboardMapper.content(fb_seq);
	}
	
	@Override
	public void write(Freeboard freeboard) {
		freeboardMapper.write(freeboard);
	}
	
	@Override
	public void delete(String fb_seq) {
		freeboardMapper.delete(fb_seq);
	}

	@Override
	public void update(Freeboard freeboard) {
		freeboardMapper.update(freeboard);
	}
	
	@Override
	public Freeboard updateList(String fb_seq) {
		Freeboard flist = freeboardMapper.updateList(fb_seq);
		return flist;
	}
}
