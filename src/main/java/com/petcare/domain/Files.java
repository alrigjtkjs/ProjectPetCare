package com.petcare.domain;

import org.springframework.web.multipart.MultipartFile;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Files {
	private long f_seq;
	private String b_seq;
	private String fname;
	private String ofname;
	//private String fsize;
	
	public Files(MultipartFile img, String imgName) {
		setFname(imgName);
		setOfname(img.getOriginalFilename());
		//setFsize(String.valueOf(img.getSize()));
	}
}
