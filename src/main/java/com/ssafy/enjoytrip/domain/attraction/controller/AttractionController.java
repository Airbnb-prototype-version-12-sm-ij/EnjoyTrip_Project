package com.ssafy.enjoytrip.domain.attraction.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto;
import com.ssafy.enjoytrip.domain.attraction.dto.AttractionDto.SearchAttraction;
import com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity;
import com.ssafy.enjoytrip.domain.attraction.service.AttractionService;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/attractions")
public class AttractionController {

	private final AttractionService attractionService;
	private final HttpSession httpSession;

	@GetMapping("/search")
	public ResponseEntity<?> searchAttractions(@ModelAttribute SearchAttraction searchAttraction,
		HttpSession session) {

		MemberEntity memberDto = ((MemberEntity)session.getAttribute("memberDto"));
		if (memberDto != null) {
			searchAttraction.setUserId(memberDto.getUserId());
		}
		try {
			List<AttractionEntity> attractionList = attractionService.loadAttraction(searchAttraction);
			for (AttractionEntity attraction : attractionList) {
				attraction.setWishCount(attractionService.getWishCount(attraction.getContentId()));
				attraction.setReviewCount(attractionService.getReviewCount(attraction.getContentId()));
			}
			return new ResponseEntity<List<AttractionEntity>>(attractionList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	// 조회수 높은거 5개 가져옴
	@GetMapping("/recommand")
	public ResponseEntity<?> recommandAttractions(HttpSession session) {

		log.info("recommandAttractions");

		MemberEntity memberDto = ((MemberEntity)session.getAttribute("memberDto"));

		try {
			List<AttractionEntity> attractionList = attractionService.recommandAttractions(null);
			if (memberDto != null){
				attractionList = attractionService.recommandAttractions(memberDto.getUserId());
			}
			for (AttractionEntity attraction : attractionList) {
				attraction.setWishCount(attractionService.getWishCount(attraction.getContentId()));
				attraction.setReviewCount(attractionService.getReviewCount(attraction.getContentId()));
			}
			return ResponseEntity.ok().body(attractionList);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	// 찜 목록 조회
	@GetMapping("/wishlist")
	public ResponseEntity<?> getWishList(HttpSession session) {

		log.info("getWishList: {}", session.getAttribute("memberDto"));

		MemberEntity memberDto = ((MemberEntity)session.getAttribute("memberDto"));

		if (memberDto != null) {
			try {
				List<AttractionEntity> wishList = attractionService.getWishListWithUser(memberDto.getUserId());
				return new ResponseEntity<List<AttractionEntity>>(wishList, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("찜 목록 조회 중 오류가 발생했습니다.");
			}
		} else {
			throw new RuntimeException("로그인이 필요합니다.");

		}
	}

	@SuppressWarnings("checkstyle:ParameterName")
	@GetMapping("/{content_id}")
	public AttractionEntity getAttraction(@PathVariable Integer content_id) {
		try {
			return attractionService.pickAttraction(content_id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Deprecated
	@GetMapping("/gugun/{sido}")
	public List<AttractionDto.Gugun> getGugun(@PathVariable Integer sido) {
		try {
			return attractionService.getGugun(sido);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@PostMapping("/wish")
	public ResponseEntity<?> addWish(@RequestBody AttractionDto.Wish wish,
		HttpSession session) {

		log.info("====================================찜 추가==============================");

		MemberEntity memberDto = (MemberEntity)session.getAttribute("memberDto");

		if (memberDto != null) {
			String userId = memberDto.getUserId();
			wish.setUserId(userId);
		}
		log.info("===================================={}==============================", wish);
		try {
			attractionService.addWish(wish);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("찜은 5개까지만 가능합니다.");
		}
	}

	// @GetMapping("/wish/{userId}")
	// public ResponseEntity<List<AttractionDto.Wish>> getWishList(@PathVariable String userId) {
	//
	// 	log.info("====================================찜 리스트 조회==============================");
	// 	log.info("===================================={}==============================", userId);
	//
	// 	List<AttractionDto.Wish> wishList = new ArrayList<>();
	//
	// 	try {
	// 		wishList = attractionService.getWishList(userId);
	// 		return ResponseEntity.ok(wishList);
	// 	} catch (IOException e) {
	// 		throw new RuntimeException(e);
	// 	}
	// }

	@DeleteMapping("/wish")
	public ResponseEntity<Void> deleteWish(@RequestBody AttractionDto.Wish wish,
		HttpSession session) {

		MemberEntity memberDto = (MemberEntity)session.getAttribute("memberDto");

		if (memberDto != null) {
			String userId = memberDto.getUserId();
			wish.setUserId(userId);
		}
		log.info("====================================찜 삭제==============================");
		log.info("===================================={}==============================", wish);
		try {
			attractionService.deleteWish(wish);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	@GetMapping("/wishList")
	public ResponseEntity<List<AttractionEntity>> getWishListWithUser(HttpSession session) {

		MemberEntity memberDto = ((MemberEntity)session.getAttribute("memberDto"));

		if (memberDto != null) {
			try {
				List<AttractionEntity> wishList = attractionService.getWishListWithUser(memberDto.getUserId());
				return new ResponseEntity<List<AttractionEntity>>(wishList, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("찜 목록 조회 중 오류가 발생했습니다.");
			}
		} else {
			throw new RuntimeException("로그인이 필요합니다.");
		}
	}

	// 조회수 증가
	@PostMapping("/addViewCount/{contentId}")
	public ResponseEntity<Void> addViewCount(@PathVariable("contentId") Integer contentId) {

		log.info("===========================조회수 증가=======================================");

		try {
			attractionService.addViewCount(contentId);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

}