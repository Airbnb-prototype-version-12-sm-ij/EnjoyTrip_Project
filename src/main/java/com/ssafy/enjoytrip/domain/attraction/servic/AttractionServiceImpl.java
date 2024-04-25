package com.ssafy.enjoytrip.domain.attraction.servic;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;
import com.ssafy.enjoytrip.domain.attraction.mapper.AttractionMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttractionServiceImpl implements AttractionService {

	private final AttractionMapper attractionMapper;

	@Override
	public List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws Exception {
		return attractionMapper.loadAttraction(searchAttraction);
	}

	@Override
	public AttractionEntity pickAttraction(Integer content_id) throws Exception {
		return attractionMapper.pickAttraction(content_id);
	}

	@Override
	public List<AttractionDto> getGugun(Integer sido) throws Exception {
		return attractionMapper.getGugun(sido);
	}
}