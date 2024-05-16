package com.ssafy.enjoytrip.domain.attraction.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;
import com.ssafy.enjoytrip.domain.attraction.mapper.AttractionMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AttractionServiceImpl implements AttractionService {

	private final AttractionMapper attractionMapper;

	@Override
	public List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws
		IOException {

		try {
			return attractionMapper.loadAttraction(searchAttraction);
		} catch (SQLException e) {
			e.printStackTrace();
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
	public List<AttractionDto.Gugun> getGugun(Integer sido) throws IOException {
		try {
			return attractionMapper.getGugun(sido);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void addWish(AttractionDto.Wish wish) throws IOException {

		try {
			attractionMapper.addWish(wish);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<AttractionDto.Wish> getWishList(String userId) throws IOException {
		try {
			return attractionMapper.getWishList(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteWish(AttractionDto.Wish wish) throws IOException {

		try {
			attractionMapper.deleteWish(wish);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<AttractionEntity> getWishListWithUser(String userId) throws IOException {
		try {
			return attractionMapper.getWishListWithUser(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
