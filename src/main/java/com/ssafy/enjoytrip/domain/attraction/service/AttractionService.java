package com.ssafy.enjoytrip.domain.attraction.service;

import java.io.IOException;
import java.util.List;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;

public interface AttractionService {

	// 시, 군, 타입, 검색어 받아서 Attraction 리스트 조회
	List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws IOException;

	// 정보 보기 누르면 해당 관광지의 content_id 받아서 해당 관광지의 모든 정보 받아오기
	AttractionEntity pickAttraction(Integer contentId) throws IOException;

	// 시도코드 받아서 구군코드 구하기
	List<AttractionDto.Gugun> getGugun(Integer sido) throws IOException;

}
