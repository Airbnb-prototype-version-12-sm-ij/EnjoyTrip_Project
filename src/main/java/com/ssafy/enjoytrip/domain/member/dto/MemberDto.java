package com.ssafy.enjoytrip.domain.member.dto;

import com.ssafy.enjoytrip.domain.member.entity.MembersEntity;

import lombok.Builder;
import lombok.Data;

public class MemberDto {

	@Data
	@Builder
	public static class Assign {
		private String userId;
		private String userName;
		private String userPassword;

		public static Assign of(MembersEntity membersEntity) {
			return Assign.builder().userId(membersEntity.getUserId()).userName(membersEntity.getUserName())
				.userPassword(membersEntity.getUserPassword()).build();
		}
	}
}
