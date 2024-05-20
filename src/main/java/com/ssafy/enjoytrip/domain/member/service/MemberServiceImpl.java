package com.ssafy.enjoytrip.domain.member.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.member.dto.MemberDto;
import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;
import com.ssafy.enjoytrip.domain.member.mapper.MemberMapper;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	final JavaMailSender javaMailSender;

	@Value("${spring.mail.username}")
	private String id;

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

	@SuppressWarnings("checkstyle:RegexpMultiline")
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
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@Override
	public MemberEntity findMember(MemberDto.Find find) throws IOException {

		try {
			return memberMapper.findMember(find);
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
		info.setUserPassword(getHashValue(info.getUserPassword()));
		try {
			memberMapper.modifyMember(info);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteMember(String userId) throws IOException {
		try {
			memberMapper.deleteMember(userId.replace("\"", ""));
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

	@Override
	public void sendSimpleMessage(MemberDto.Find find)
		throws Exception {

		MemberEntity member = memberMapper.MemberForChangePwd(find);
		log.info("===============================================================");
		log.info("sendSimpleMessage: {}", member);

		if(member == null) {
			throw new IllegalArgumentException();
		}

		MimeMessage message = createMessage(member);
		try{
			javaMailSender.send(message); // 메일 발송
		}catch(MailException es){
			es.printStackTrace();
			throw new IllegalArgumentException();
		}
	}


	@Override
	public MimeMessage createMessage(MemberEntity member) throws MessagingException, UnsupportedEncodingException
	{
		log.info("보내는 대상 : " + member.getUserEmail());

		MimeMessage message = javaMailSender.createMimeMessage();
		message.addRecipients(MimeMessage.RecipientType.TO, member.getUserEmail());
		// to 보내는 대상
		message.setSubject("임시 비밀번호 입니다."); //메일 제목
		// 메일 내용 메일의 subtype을 html로 지정하여 html문법 사용 가능

		String tmpPwd =getTmpPwd();
		member.setUserPassword(getHashValue(tmpPwd));

		try {
			memberMapper.modifyMember(MemberDto.Info.of(member));
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}

		String msg = "<h1>안녕하세요</h1><br><h2>방방곡곡</h2><br><h3>임시 비밀번호는 : "+ tmpPwd + " 입니다. 로그인 후 비밀번호를 변경해주세요.</h3>";

		message.setText(msg, "utf-8", "html"); //내용, charset타입, subtype
		message.setFrom(new InternetAddress(id,"방방 곡곡")); //보내는 사람의 메일 주소, 보내는 사람 이름
		return message;
	}


	public static String getTmpPwd() {
		String characters = "abcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuilder randomString = new StringBuilder();

		for (int i = 0; i < 8; i++) {
			int index = random.nextInt(characters.length());
			randomString.append(characters.charAt(index));
		}
		randomString.append("1");

		return randomString.toString();
	}

}
