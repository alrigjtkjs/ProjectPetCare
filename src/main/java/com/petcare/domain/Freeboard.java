package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Freeboard {
	private String fb_seq;
	private String title;
	private String email;
	private String content;
	private int likes;
	private long views;
	private Date wdate;
	private int gnum; 
	private int gord; 
	private int depth;
}

