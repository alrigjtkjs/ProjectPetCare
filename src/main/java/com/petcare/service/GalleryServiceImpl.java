package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Gallery;
import com.petcare.mapper.GalleryMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class GalleryServiceImpl implements GalleryService{
	private GalleryMapper galleryMapper;
	
	@Override
	public List<Gallery> galleryList(){
		return galleryMapper.galleryList();
	}
	
	@Override
	public List<Gallery> galleryMyList(String email){
		return galleryMapper.galleryMyList(email);
	}
	
	@Override
	public void galleryWrite(Gallery gallery) {
		galleryMapper.galleryWrite(gallery);
	}
	
	@Override
	public void galleryDelete(String g_seq) {
		galleryMapper.galleryDelete(g_seq);
	}

	@Override
	public void galleryUpdate(Gallery gallery) {
		galleryMapper.galleryUpdate(gallery);
	}
	
	@Override
	public Gallery gUpdateList(String g_seq) {
		Gallery glist = galleryMapper.gUpdateList(g_seq);
		return glist;
	}
}
