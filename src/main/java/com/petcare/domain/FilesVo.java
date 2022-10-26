package com.petcare.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class FilesVo {
	private long f_seq;
	private String seqinit; //시퀀스 시작 문자
	private String b_seq;
	private String seqname; //시퀀스이름
	private String fname;
	private String ofname;
	
	public FilesVo(MultipartFile img, String imgName,String seqinit) {
		setFname(imgName);
		setOfname(img.getOriginalFilename());
		settingSeq(seqinit);
	}
	public void settingSeq(String seqinit) {
		if(seqinit.startsWith("pet")) {
			setSeqinit(seqinit);
			setSeqname("PET_SEQ");
		}
		if(seqinit.startsWith("SM")) {
			setSeqinit(seqinit);
			setSeqname("SHAREMARKET_SEQ");
		}	
		if(seqinit.startsWith("G")) {
			setSeqinit(seqinit);
			setSeqname("GALLERY_SEQ");
		}	
	}
}
