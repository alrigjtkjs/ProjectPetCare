package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Gallery {
	private String g_seq;
	private String email;
	private String content;
	private long likes;
	private long views;
	private Date wdate;
	/*
	private int gnum;  //´ñ±Û ±×·ì
	private int gord;  //gnum ³»ÀÇ ´ñ±Û ±×·ì
	private int depth; //´ñ±Û, ´ë´ñ±Û ±æÀÌ..?O
	*/
}

