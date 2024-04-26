package com.ssafy.enjoytrip.domain.member.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;
import com.ssafy.enjoytrip.domain.member.servic.MemberServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/members")
@RequiredArgsConstructor
@CrossOrigin("*")
public class MemberController {

	private final MemberServiceImpl memberServiceImpl;

	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody MemberDto.Login login, HttpServletRequest request) {
		log.info("--------------------MemberController --- login: {}----------------------", login);

		try {
			MemberEntity loginInfo = memberServiceImpl.login(login);
			log.info("loginInfo: {}", loginInfo);
			if (loginInfo != null) {
				HttpSession session = request.getSession();
				session.setAttribute("memberDto", loginInfo);
				return new ResponseEntity<>(HttpStatus.OK);
			} else {
				return new ResponseEntity<>("유저 로그인 정보를 확인하세요", HttpStatus.UNAUTHORIZED);
			}
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/logout")
	public void logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}

	// 버튼을 누르면 회원들의 정보를 반환 해주는 회원 관리 REST API
	@GetMapping("/info")
	public ResponseEntity<?> getMemberInfo(HttpServletRequest request) {
		try {
			List<MemberEntity> memberList = memberServiceImpl.loadMember();
			return new ResponseEntity<List<MemberEntity>>(memberList, HttpStatus.OK);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	// 회원 id를 받아 회원을 삭제하는 REST API
	@PostMapping("/delete")
	public ResponseEntity<?> deleteMember(@RequestBody String userId) {

		try {
			System.out.println("userId: " + userId);
			memberServiceImpl.deleteMember(userId);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
}
