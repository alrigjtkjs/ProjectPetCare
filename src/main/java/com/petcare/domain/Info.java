package com.petcare.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Info {
	private String n_seq;
	private String title;
	private String admin;
	private String content;
	private long view;
	private Date wdate;
}
