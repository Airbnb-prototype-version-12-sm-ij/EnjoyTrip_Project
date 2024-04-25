package com.ssafy.enjoytrip.domain.member.servic;

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
	public void addMember(MemberDto.Info info) throws Exception {
		memberMapper.addMember(info);
	}

	@Override
	public List<MemberEntity> loadMember() throws Exception {
		return memberMapper.loadMember();
	}

	@Override
	public void modifyMember(MemberDto.Info info) throws Exception {
		memberMapper.modifyMember(info);
	}

	@Override
	public void deleteMember(String userId) throws Exception {
		memberMapper.deleteMember(userId);
	}

	@Override
	public MemberEntity pickMember(String userId) throws Exception {
		return memberMapper.pickMember(userId);
	}
}
