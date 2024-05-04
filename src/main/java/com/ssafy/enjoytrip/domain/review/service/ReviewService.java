package com.ssafy.enjoytrip.domain.review.service;

import java.util.List;

import com.ssafy.enjoytrip.domain.review.dto.ReviewDto;
import com.ssafy.enjoytrip.domain.review.entity.ReviewEntity;

public interface ReviewService {
	List<ReviewEntity> getReviewList(Integer content_id) throws Exception;

	void registReview(ReviewDto.Regist regist) throws Exception;

	List<ReviewDto.ReviewFileInfo> fileInfoList(int reviewId) throws Exception;

	void modifyReview(ReviewDto.Update update) throws Exception;

	void deleteReview(ReviewDto.Delete delete) throws Exception;
}
