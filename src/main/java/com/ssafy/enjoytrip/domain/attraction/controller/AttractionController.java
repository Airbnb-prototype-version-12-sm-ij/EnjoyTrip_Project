
package com.ssafy.enjoytrip.domain.attraction.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;
import com.ssafy.enjoytrip.domain.attraction.servic.AttractionService;

@RestController
@RequestMapping("/attractions")
public class AttractionController {

	private final AttractionService attractionService;

	public AttractionController(AttractionService attractionService) {
		this.attractionService = attractionService;
	}

	@GetMapping
	public List<AttractionEntity> loadAttraction(AttractionDto.SearchAttraction searchAttraction) throws SQLException {
		return attractionService.loadAttraction(searchAttraction);
	}

	@GetMapping("/{content_id}")
	public AttractionEntity pickAttraction(@PathVariable Integer content_id) throws SQLException {
		return attractionService.pickAttraction(content_id);
	}

	@GetMapping("/gugun/{sido}")
	public List<AttractionDto> getGugun(@PathVariable Integer sido) throws SQLException {
		return attractionService.getGugun(sido);
	}
}