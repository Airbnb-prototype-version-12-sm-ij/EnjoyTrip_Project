package com.ssafy.enjoytrip.domain.member.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

@Mapper
public interface MemberMapper {

	// 로그인
	MemberEntity login(MemberDto.Login login) throws SQLException;

	// 회원가입
	void addMember(MemberDto.Info info) throws SQLException;

	// 회원 정보 load
	List<MemberEntity> loadMember() throws SQLException;

	// 회원 정보 수정
	void modifyMember(MemberDto.Info info) throws SQLException;

	// 회원 탈퇴
	void deleteMember(String userId) throws SQLException;

	// 특정 회원 정보
	MemberEntity pickMember(String userId) throws SQLException;
}
