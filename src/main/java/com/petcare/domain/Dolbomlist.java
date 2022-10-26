package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Dolbomlist {
	private long seq;
	private String category;//요청/지원
	private String state;//대기중,진행중,완료
	//private String message;
	private String sendernick;
	private String senderemail;
	private String receivernick;
	private String receiveremail;
	//private String region;
	private Date rdate; //요청한 날짜
	//@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private String workdate;
	//private Date workdate;
	//private String workday;
	//private String workstime;
	//private String worketime;
	private String kind;
	private String dseq; //돌봄시퀀스
}
