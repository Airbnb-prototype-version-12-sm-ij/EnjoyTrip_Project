package com.ssafy.enjoytrip.domain.review.dto;

import java.util.List;

import lombok.Builder;
import lombok.Data;

public class ReviewDto {

	// 리뷰 등록 DTO
	@Data
	@Builder
	public static class Regist {
		private Integer reviewId;
		private String title;
		private String content;
		private Integer rating;
		private String together;
		private String userId;
		private Integer contentId;
		private List<ReviewFileInfo> fileInfos;
	}

	@Data
	@Builder
	public static class Update {
		private Integer reviewId;
		private String title;
		private String content;
		private String userId;
		private Integer rating;
	}

	@Data
	@Builder
	public static class Delete {
		private Integer reviewId;
		private String userId;
	}

	@Data
	@Builder
	public static class ReviewFileInfo {
		private String saveFolder;
		private String originalFile;
		private String saveFile;
	}

}
