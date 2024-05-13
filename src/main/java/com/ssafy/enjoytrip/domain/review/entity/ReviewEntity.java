package com.ssafy.enjoytrip.domain.review.entity;

import java.util.List;

import com.ssafy.enjoytrip.domain.review.dto.ReviewDto;

import lombok.Data;

@Data
public class ReviewEntity {

	private Integer reviewId;
	private String title;
	private String content;
	private Integer rating;
	private String userId;
	private Integer contentId;
	private String createdAt;
	private List<ReviewDto.ReviewFileInfo> fileInfo;
}
