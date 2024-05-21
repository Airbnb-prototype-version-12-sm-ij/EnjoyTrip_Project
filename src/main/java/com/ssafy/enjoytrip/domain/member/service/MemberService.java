package com.ssafy.enjoytrip.domain.member.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

public interface MemberService {

	// 로그인
	public MemberEntity login(MemberDto.Login login) throws IOException;

	// 회원가입
	public void addMember(MemberDto.Info info) throws IOException;

	// 회원 정보 load
	public List<MemberEntity> loadMember() throws IOException;

	// 회원 정보 수정
	public void modifyMember(MemberDto.Info info) throws IOException;

	// 회원 탈퇴
	public void deleteMember(String userId) throws IOException;

	// 특정 회원 정보
	public MemberEntity pickMember(String userId) throws IOException;

	public MemberEntity findMember(MemberDto.Find find) throws IOException;

	// 임시 비밀번호 발송
	public void sendSimpleMessage(MemberDto.Find find) throws Exception;

	// 이메일 메시지 생성
	@Transactional
	public MimeMessage createMessage(MemberEntity member) throws MessagingException, UnsupportedEncodingException;

}
