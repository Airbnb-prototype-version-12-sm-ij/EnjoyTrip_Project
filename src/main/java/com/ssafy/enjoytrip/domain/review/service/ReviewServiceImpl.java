package com.ssafy.enjoytrip.domain.review.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.review.dto.ReviewDto;
import com.ssafy.enjoytrip.domain.review.entity.ReviewEntity;
import com.ssafy.enjoytrip.domain.review.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	private final ReviewMapper reviewMapper;

	@Override
	public List<ReviewEntity> getReviewList(Integer content_id) throws Exception {
		return reviewMapper.getReviewList(content_id);
	}

	@Override
	public void registReview(ReviewDto.Regist regist) throws Exception {
		reviewMapper.registReview(regist);

		List<ReviewDto.ReviewFileInfo> fileInfos = regist.getFileInfos();
		if (fileInfos != null && !fileInfos.isEmpty()) {
			try {
				reviewMapper.registerFile(regist);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}
		}
	}

	@Override
	public List<ReviewDto.ReviewFileInfo> fileInfoList(int reviewId) throws Exception {
		return reviewMapper.fileInfoList(reviewId);
	}

	@Override
	public void modifyReview(ReviewDto.Update update) throws Exception {
		reviewMapper.modifyReview(update);
	}

	@Override
	public void deleteReview(ReviewDto.Delete delete) throws Exception {
		reviewMapper.deleteReview(delete);
	}
}
