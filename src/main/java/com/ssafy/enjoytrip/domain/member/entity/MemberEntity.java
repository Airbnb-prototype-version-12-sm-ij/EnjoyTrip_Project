package com.ssafy.enjoytrip.domain.member.entity;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class MemberEntity {

	private String userId;

	private String userName;

	private String userPassword;

	private String userEmail;

	@NotBlank
	@Pattern(regexp = "^(default|admin)$")
	private String grade;

	@NotBlank
	@Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$")
	private String registrationDate;
}
