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
	private String writer; /*���ۼ��� �г���*/
	private String writerEmail; /*���ۼ��� �̸���*/
	private String dolbomy; /*������ �г���*/
	private String dolbomyEmail; /*������ �̸���*/
	private float star;
	private Date wdate;
}
