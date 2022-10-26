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
	private String category;//��û/����
	private String state;//�����,������,�Ϸ�
	//private String message;
	private String sendernick;
	private String senderemail;
	private String receivernick;
	private String receiveremail;
	//private String region;
	private Date rdate; //��û�� ��¥
	//@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private String workdate;
	//private Date workdate;
	//private String workday;
	//private String workstime;
	//private String worketime;
	private String kind;
	private String dseq; //����������
}