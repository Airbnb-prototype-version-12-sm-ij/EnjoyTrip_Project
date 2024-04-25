package com.ssafy.enjoytrip.domain.member.entity;

import lombok.Data;

@Data
public class MemberEntity {
	private String userId;
	private String userName;
	private String userPassword;
	private String grade;
	private String registrationDate;
}
