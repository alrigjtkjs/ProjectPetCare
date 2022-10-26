package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Comnt {
	
	private long cmt_seq;
	private String b_seq;
	private String email;
	private String content;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yy-MM-dd", timezone="Asia/Seoul")
	private Date wdate;
	private long gnum;
	private long gord;
	private long depth;
	
}
