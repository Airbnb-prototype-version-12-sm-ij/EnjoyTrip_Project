package com.ssafy.enjoytrip.domain.member.servic;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;
import com.ssafy.enjoytrip.domain.member.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;

	@Override
	public void addMember(MemberDto.Info info) throws IOException {
		try {
			memberMapper.addMember(info);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<MemberEntity> loadMember() throws IOException {
		try {
			return memberMapper.loadMember();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void modifyMember(MemberDto.Info info) throws IOException {
		try {
			memberMapper.modifyMember(info);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteMember(String userId) throws IOException {
		try {
			memberMapper.deleteMember(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public MemberEntity pickMember(String userId) throws IOException {
		try {
			return memberMapper.pickMember(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
