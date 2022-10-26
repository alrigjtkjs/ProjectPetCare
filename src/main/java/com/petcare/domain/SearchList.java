package com.petcare.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class SearchList {
	private String category;
	private String kind;
	private String tag;
	private String workday;
	private Date workdate;
	private List<String> region;
}

