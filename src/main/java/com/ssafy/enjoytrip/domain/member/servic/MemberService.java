package com.ssafy.enjoytrip.domain.member.servic;

import java.io.IOException;
import java.util.List;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

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
}
