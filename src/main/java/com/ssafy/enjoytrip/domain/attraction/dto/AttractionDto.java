package com.ssafy.enjoytrip.domain.attraction.dto;

import lombok.Builder;
import lombok.Data;

public class AttractionDto {

	@Data
	@Builder
	public static class SearchAttraction {
		private Integer sidoCode;
		private Integer typeCode;
		private String title;

		public static SearchAttraction of(Integer sidoCode, Integer typeCode, String title) {
			return SearchAttraction.builder()
				.sidoCode(sidoCode)
				.typeCode(typeCode)
				.title(title)
				.build();
		}
	}

	@Data
	@Builder
	public static class Gugun {
		private Integer sidoCode;
		private String gugunName;
	}

	@Data
	public static class Wish {
		private String userId;
		private Integer contentId;
	}
}
