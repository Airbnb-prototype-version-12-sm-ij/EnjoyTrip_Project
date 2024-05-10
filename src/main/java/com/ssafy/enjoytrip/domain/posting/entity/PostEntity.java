package com.ssafy.enjoytrip.domain.posting.entity;

import java.util.List;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;

import lombok.Data;

@Data
public class PostEntity {

	private Integer postId;
	private String title;
	private String content;
	private String userId;
	private String sidoName;
	private String gugunName;
	private Integer sidoCode;
	private Integer gugunCode;
	private String createdAt;
	private Integer hit;
	private List<PostDto.FileInfo> fileInfo;
}
