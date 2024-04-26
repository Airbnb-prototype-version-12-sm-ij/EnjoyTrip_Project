package com.ssafy.enjoytrip.domain.member.controller;

import com.ssafy.enjoytrip.domain.member.servic.MemberServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;
import com.ssafy.enjoytrip.domain.member.mapper.MemberMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequiredArgsConstructor
@RequestMapping("/members")
public class MemberController {

	private final MemberServiceImpl memberServiceImpl;

	@PostMapping("/login")
	@ResponseBody
	public ResponseEntity<?> login(@RequestBody MemberDto.Login login, HttpServletRequest request) {

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
}
