package com.ssafy.enjoytrip.domain.member.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

@Mapper
public interface MemberMapper {

	// 로그인
	MemberEntity login(MemberDto.Login login) throws SQLException;

	// 회원가입
	@Transactional
	void addMember(MemberDto.Info info) throws SQLException;

	// 회원 정보 load
	List<MemberEntity> loadMember() throws SQLException;

	// 회원 정보 수정
	@Transactional
	void modifyMember(MemberDto.Info info) throws SQLException;

	// 회원 탈퇴
	@Transactional
	void deleteMember(String userId) throws SQLException;

	// 특정 회원 정보
	MemberEntity pickMember(String userId) throws SQLException;

	// 회원id, 와 이름으로 회원 찾기
	MemberEntity findMember(MemberDto.Find find) throws SQLException;

	MemberEntity MemberForChangePwd(MemberDto.Find find) throws SQLException;
}
