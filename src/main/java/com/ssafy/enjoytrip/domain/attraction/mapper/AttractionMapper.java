package com.ssafy.enjoytrip.domain.attraction.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;

@Mapper
public interface AttractionMapper {

	// 시, 군, 타입, 검색어 받아서 Attraction 리스트 조회
	List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws SQLException;

	// 정보 보기 누르면 해당 관광지의 content_id 받아서 해당 관광지의 모든 정보 받아오기
	AttractionEntity pickAttraction(int content_id) throws SQLException;

	// 시도 코드를 넣어서 구군 정보 얻어오기 ex) 서울 ->  강남구, 강서구, ...
	List<AttractionDto.Gugun> getGugun(int sido) throws SQLException;

}