package com.petcare.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Address {
	private String address_name;
	private String region_1depth_name;
	private String region_2depth_name;
	private String region_3depth_name;
	private String region_4depth_name;
	private Double y;
	private Double x;
}
