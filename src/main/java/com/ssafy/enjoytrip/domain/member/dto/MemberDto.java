package com.ssafy.enjoytrip.domain.member.dto;

import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

import lombok.Builder;
import lombok.Data;

public class MemberDto {

	@Data
	@Builder
	public static class Info {
		private String userId;
		private String userName;
		private String userPassword;

		public static Info of(MemberEntity memberEntity) {
			return Info.builder().userId(memberEntity.getUserId()).userName(memberEntity.getUserName())
				.userPassword(memberEntity.getUserPassword()).build();
		}
	}
}
