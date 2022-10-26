package com.petcare.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Timetable {
	private String selectSTime;
	private String selectETime;
	private String timeSTable;
	private String timeETable;
	private Date workdate;
}
