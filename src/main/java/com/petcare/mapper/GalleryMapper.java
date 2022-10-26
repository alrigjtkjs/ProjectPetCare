package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.Gallery;

public interface GalleryMapper {
	List<Gallery> galleryList();
	long TotalRowCounts();
	List<Gallery> galleryMyList(String email);
	void galleryWrite(Gallery gallery);
	void galleryDelete(String g_seq);
	void galleryUpdate(Gallery gallery);
	Gallery gUpdateList(String g_seq);
}