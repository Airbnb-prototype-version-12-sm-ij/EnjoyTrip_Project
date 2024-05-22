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

		log.info("==============={}================", searchAttraction);

		try {
			return attractionMapper.loadAttraction(searchAttraction);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Override
	public int getWishCount(Integer content_id) throws SQLException {
		return attractionMapper.getWishCount(content_id);

	}

	@Override
	public double getReviewCount(Integer content_id) throws SQLException {
		return attractionMapper.getReviewCount(content_id);
	}

	@Override
	public AttractionEntity pickAttraction(Integer content_id) throws IOException {
		try {
			return attractionMapper.pickAttraction(content_id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Deprecated
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
			List<AttractionDto.Wish> wishList = attractionMapper.getWishList(wish.getUserId());
			System.out.println(wishList.size());
			if (wishList.size() >= 5) {
				throw new RuntimeException("찜은 5개까지만 가능합니다.");
			}
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

	@Override
	public void addViewCount(Integer contentId) throws IOException {

		try {
			attractionMapper.addViewCount(contentId);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<AttractionEntity> recommandAttractions(String userId) throws IOException {
		try {
			return attractionMapper.recommandAttractions(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
