package com.ssafy.enjoytrip.domain.attraction.servic;

import java.io.IOException;
import java.sql.SQLException;
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
	public List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws IOException {
		try {
			return attractionMapper.loadAttraction(searchAttraction);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public AttractionEntity pickAttraction(Integer content_id) throws IOException {
		try {
			return attractionMapper.pickAttraction(content_id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<AttractionDto> getGugun(Integer sido) throws IOException {
		try {
			return attractionMapper.getGugun(sido);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}
}
