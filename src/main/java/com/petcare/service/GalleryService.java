package com.petcare.service;

import java.util.List;

import com.petcare.domain.Gallery;

public interface GalleryService {
	List<Gallery> galleryList();
	List<Gallery> galleryMyList(String email);
	void galleryWrite(Gallery gallery);
	void galleryDelete(String g_seq);
	void galleryUpdate(Gallery gallery);
	Gallery gUpdateList(String g_seq);
}

