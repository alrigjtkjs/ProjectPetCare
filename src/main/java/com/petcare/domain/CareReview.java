package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CareReview {
	/*private String cr_seq;
	private String fname;
	private String ofname;
	private int comments;
	private String content;
	private float star;
	private String nickname;
	private Date wdate;*/
	private String cr_seq;
	private String content;
	private String writer; /*글작성자 닉네임*/
	private String writerEmail; /*글작성자 이메일*/
	private String dolbomy; /*돌보미 닉네임*/
	private String dolbomyEmail; /*돌보미 이메일*/
	private float star;
	private Date wdate;
}
