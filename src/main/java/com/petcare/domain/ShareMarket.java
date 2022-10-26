package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ShareMarket {
	private String sm_seq;
	private String title;
	private String email;
	private String location;
	private String category;
	private String content;
	private long likes;
	private long views;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yy-MM-dd HH:mm", timezone="Asia/Seoul")
	private Date wdate;
}
