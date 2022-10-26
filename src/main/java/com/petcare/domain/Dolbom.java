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
	private String category;//��û/����
	private String header; //ū����
	private String content;//����
	private String kind;//��å,��Ź����,�湮����
	private String region; //��������
	private Date workdate; //��¥/�Ⱓ
	private String workday; //��ȭ���������
	private String workstime; //���۽ð�
	private String worketime; //����ð�
	private String tag;//�±�
	private String state;//�����,������,�Ϸ�
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date wdate;//�ۼ���
	private String nickname;
	private String email;
}
