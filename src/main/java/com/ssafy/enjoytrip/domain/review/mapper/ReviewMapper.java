package com.ssafy.enjoytrip.domain.review.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.domain.review.dto.ReviewDto;
import com.ssafy.enjoytrip.domain.review.entity.ReviewEntity;

@Mapper
public interface ReviewMapper {

	/**
	 * 리뷰 조회
	 * @return List<ReviewEntity>
	 * @throws SQLException
	 */
	List<ReviewEntity> getReviewList(Integer content_id) throws SQLException;

	/**
	 * 리뷰 등록
	 * @param regist
	 * @throws SQLException
	 */
	void registReview(ReviewDto.Regist regist) throws SQLException;

	/**
	 * 파일 등록
	 * @param regist
	 * @throws SQLException
	 */
	void registerFile(ReviewDto.Regist regist) throws SQLException;

	/**
	 * 리뷰의 파일들 불러오기
	 * @param reviewId
	 * @return
	 * @throws SQLException
	 */
	List<ReviewDto.ReviewFileInfo> fileInfoList(int reviewId) throws SQLException;

	/**
	 * 리뷰 수정
	 * @param update
	 * @throws SQLException
	 */
	void modifyReview(ReviewDto.Update update) throws SQLException;

	/**
	 * 리뷰 삭제
	 * @param delete
	 * @throws SQLException
	 */
	void deleteReview(ReviewDto.Delete delete) throws SQLException;

}
