package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	// 필수입력
	private String email;
	private String pwd;
	private String nickname;
	private String agree;
	// 선택입력
	private String phone;
	private String name;
	private String addr;
	private String gender;
	private Date bdate;
	// 자동생성
	private float sat;
	private Date joindate;
	private int give;
	private int take;
}