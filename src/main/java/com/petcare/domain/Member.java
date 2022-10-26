package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	// �ʼ��Է�
	private String email;
	private String pwd;
	private String nickname;
	private String agree;
	// �����Է�
	private String phone;
	private String name;
	private String addr;
	private String gender;
	private Date bdate;
	// �ڵ�����
	private float sat;
	private Date joindate;
	private int give;
	private int take;
}