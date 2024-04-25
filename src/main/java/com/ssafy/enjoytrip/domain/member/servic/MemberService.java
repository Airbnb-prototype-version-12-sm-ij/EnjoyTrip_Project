package com.ssafy.enjoytrip.domain.member.servic;

import java.util.List;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

public interface MemberService {

	// 회원가입
	public void addMember(MemberDto.Info info) throws Exception;

	// 회원 정보 load
	public List<MemberEntity> loadMember() throws Exception;

	// 회원 정보 수정
	public void modifyMember(MemberDto.Info info) throws Exception;

	// 회원 탈퇴
	public void deleteMember(String userId) throws Exception;

	// 특정 회원 정보
	public MemberEntity pickMember(String userId) throws Exception;
}
