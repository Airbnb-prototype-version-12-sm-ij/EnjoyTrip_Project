package com.ssafy.enjoytrip.domain.member.dto;

import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Builder;
import lombok.Data;

public class MemberDto {

	public static Login of(MemberEntity memberEntity) {
		return Login.builder().userId(memberEntity.getUserId()).userPassword(memberEntity.getUserPassword()).build();
	}

	@Data
	@Builder
	public static class Info {

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$")
		private String userId;

		@NotBlank
		private String userName;

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$")
		private String userPassword;
		private String userEmail;

		public static Info of(MemberEntity memberEntity) {
			return Info.builder().userId(memberEntity.getUserId()).userName(memberEntity.getUserName())
				.userPassword(memberEntity.getUserPassword())
				.userEmail(memberEntity.getUserEmail()).build();
		}
	}

	@Data
	@Builder
	public static class Login {

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$")
		private String userId;

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$")
		private String userPassword;
	}

	@Data
	public static class Find {

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$")
		private String userId;

		// @NotBlank
		// @Pattern(regexp = "^[가-힣]+$")
		// private String userName;

		private String userEmail;
	}

	@Data
	public static class ForModify {

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$")
		private String userPassword;
	}

	@Data
	public static class ForDelete {

		@NotBlank
		@Pattern(regexp = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$")
		private String userId;
	}

}
