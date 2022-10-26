package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Dolbom {
	private String dol_seq;
	private String category;//요청/제공
	private String header; //큰제목
	private String content;//내용
	private String kind;//산책,위탁돌봄,방문돌봄
	private String region; //돌봄지역
	private Date workdate; //날짜/기간
	private String workday; //월화수목금토일
	private String workstime; //시작시간
	private String worketime; //종료시간
	private String tag;//태그
	private String state;//대기중,진행중,완료
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date wdate;//작성일
	private String nickname;
	private String email;
}
