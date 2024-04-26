package com.ssafy.enjoytrip.domain.member.servic;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;
import com.ssafy.enjoytrip.domain.member.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;

	@Override
	public MemberEntity login(MemberDto.Login login) throws IOException {
		login.setUserPassword(getHashValue(login.getUserPassword()));
		log.info("login: {}", login);
		try {
			return memberMapper.login(login);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void addMember(MemberDto.Info info) throws IOException {
		info.setUserPassword(getHashValue(info.getUserPassword()));
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

	private static String getHashValue(String pwd) {

		// 솔트 이부분은 실제 숨겨야 하는 내용
		String salt = "ssafy11th";

		String result = "";
		try {
			// 1. SHA256 알고리즘 객체 생성
			MessageDigest md = MessageDigest.getInstance("SHA-256");

			// 2. 비밀번호와 salt 합친 문자열에 SHA 256 적용
			md.update((pwd + salt).getBytes());
			byte[] pwdsalt = md.digest();

			// 3. byte To String (10진수의 문자열로 변경)
			StringBuffer sb = new StringBuffer();
			for (byte b : pwdsalt) {
				sb.append(String.format("%02x", b));
			}

			result = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return result;
	}

}
