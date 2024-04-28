package com.ssafy.enjoytrip.domain.posting.entity;

import lombok.Data;

@Data
public class PostEntity {

	private Integer postId;
	private String title;
	private String content;
	private String userId;
	private String sidoName;
	private Integer sidoCode;
	private Integer gugunCode;
	private String createdAt;
	private Integer hit;
}
