package com.ssafy.enjoytrip.domain.attraction.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;

@Mapper
public interface AttractionMapper {

	// 시, 군, 타입, 검색어 받아서 Attraction 리스트 조회
	List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws
		SQLException;

	// 찜 개수
	int getWishCount(Integer content_id) throws SQLException;

	// 리뷰 평균
	double getReviewCount(Integer content_id) throws SQLException;

	// 유저가 있는 경우 조회 (찜 리스트도 같이 불러오기 위해)
	List<AttractionEntity> loadAttractionWithUser(AttractionDto.SearchAttraction searchAttraction, String userId) throws
		SQLException;

	// 정보 보기 누르면 해당 관광지의 content_id 받아서 해당 관광지의 모든 정보 받아오기
	AttractionEntity pickAttraction(Integer content_id) throws SQLException;

	// 시도 코드를 넣어서 구군 정보 얻어오기 ex) 서울 ->  강남구, 강서구, ...
	@Deprecated
	List<AttractionDto.Gugun> getGugun(Integer sido) throws SQLException;

	void addWish(AttractionDto.Wish wish) throws SQLException;

	List<AttractionDto.Wish> getWishList(String userId) throws SQLException;

	void deleteWish(AttractionDto.Wish wish) throws SQLException;

	List<AttractionEntity> getWishListWithUser(String userId) throws SQLException;

	void addViewCount(Integer content_id) throws SQLException;

	List<AttractionEntity> recommandAttractions(String userId) throws SQLException;
}