package com.ssafy.enjoytrip.domain.posting.dto;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;
import lombok.Data;

public class PostDto {

	// 등록 수정할때 DTO
	@Data
	@Builder
	public static class Regist {
		private Integer postId;
		@NotBlank(message = "제목을 입력해주세요.")
		private String title;
		@NotBlank(message = "내용을 입력해주세요.")
		private String content;
		private String userId;
		private Integer sidoCode;
		private Integer gugunCode;
		private List<FileInfo> fileInfos;
	}

	@Data
	@Builder
	public static class Update {
		private Integer postId;

		@NotBlank(message = "제목을 입력해주세요.")
		private String title;

		@NotBlank(message = "내용을 입력해주세요.")
		private String content;
		private String userId;
		private Integer sidoCode;
		private Integer gugunCode;
	}

	// 안쓰는듯...
	// // 이미지 파일 관련 DTO
	// @Data
	// @Builder
	// public static class PostImg {
	// 	private Integer id;
	// 	private Integer postId;
	// 	private String saveFolder;
	// 	private String originalFile;
	// 	private String saveFile;
	// }

	// 댓글 DTO
	@Data
	@Builder
	public static class Comment {
		private Integer id;
		private Integer postId;
		private String userId;
		private String comment;
		private String createdAt;
	}

	// 게시글 삭제 DTO 유저의 id와  게시글 Id로 검사
	@Data
	@Builder
	public static class DeletePost {
		private String userId;
		private Integer postId;

	}

	// 댓글 삭제 DTO 유저의 id와  댓글 Id로 검사
	@Data
	@Builder
	public static class DeleteComment {
		private String userId;
		private Integer commentId;
	}

	@Data
	@Builder
	public static class Gugun {
		private Integer gugunCode;
		private String gugunName;
	}

	@Data
	@Builder
	public static class FileInfo {
		private String saveFolder;
		private String originalFile;
		private String saveFile;

	}

}
