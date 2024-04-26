package com.ssafy.enjoytrip.domain.posting.entity;

public class PostEntity {

	// Table: posts
	// Columns:
	// post_id int AI PK
	// title varchar(100)
	// content text
	// user_id varchar(16)
	// sido_code int
	// gugun_code int
	// created_at timestamp

	//엔티티 속성 정의해줘
	private Integer postId;
	private String title;
	private String content;
	private String userId;
	private Integer sidoCode;
	private String gugunCode;
	private String creatAt;

}
