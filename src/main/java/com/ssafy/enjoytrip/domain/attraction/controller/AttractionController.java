package com.ssafy.enjoytrip.domain.attraction.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;
import com.ssafy.enjoytrip.domain.attraction.servic.AttractionService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/attractions")
public class AttractionController {

	private final AttractionService attractionService;

	@GetMapping("/search")
	public ResponseEntity<List<AttractionEntity>> searchAttractions(
		@ModelAttribute AttractionDto.SearchAttraction searchAttraction) throws SQLException {
		List<AttractionEntity> attractionList = attractionService.loadAttraction(searchAttraction);
		return ResponseEntity.ok(attractionList);
	}

	@GetMapping("/{content_id}")
	public AttractionEntity getAttraction(@PathVariable Integer content_id) throws SQLException {
		return attractionService.pickAttraction(content_id);
	}

	@GetMapping("/gugun/{sido}")
	public List<AttractionDto> getGugun(@PathVariable Integer sido) throws SQLException {
		return attractionService.getGugun(sido);
	}
}