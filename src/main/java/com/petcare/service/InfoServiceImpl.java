package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Info;
import com.petcare.domain.InfoVo;
import com.petcare.mapper.InfoMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class InfoServiceImpl implements InfoService {
	private InfoMapper infomapper;
	@Override
	public List<Info> listS() {
		return infomapper.list();
	}
	@Override
	public void insertS(Info info) {
		infomapper.insert(info);
	}
	@Override
	public void deleteS(String n_seq) {
		infomapper.delete(n_seq);
	}
	@Override
	public void updateS(Info info) {
		infomapper.update(info);
	}
	@Override
	public Info contentS(String n_seq) {
		return infomapper.content(n_seq);
	}
	@Override
	public InfoVo getInfoVo(int cp, int ps) {
		InfoVo infoVo = new InfoVo(cp, ps);
		long totalCount = infomapper.selectCount();
		List<Info> list = infomapper.selectPerPage(infoVo);
		return new InfoVo(cp, totalCount, ps, list);
	}
	
}
