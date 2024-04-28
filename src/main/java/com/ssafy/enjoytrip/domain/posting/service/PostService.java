package com.ssafy.enjoytrip.domain.posting.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;

public interface PostService {

	// 게시글 조회 (전체)
	List<PostEntity> getPostList() throws Exception;

	// 게시글 조회 (특정)
	PostEntity getPost(Integer postId) throws Exception;

	// 게시글 파일들 조회
	List<PostDto.FileInfo> fileInfoList(int articleNo) throws Exception;

	// 게시글 등록
	@Transactional
	void registPost(PostDto.Regist regist) throws Exception;

	// 게시글 수정
	@Transactional
	void modifyPost(PostDto.Update update) throws Exception;

	// 게시글 삭제
	@Transactional
	void deletePost(PostDto.DeletePost deletePost) throws Exception;

	// 시도 찾기
	String getSido(Integer sidoCode) throws Exception;

	// 댓글 등록
	@Transactional
	void registComment(PostDto.Comment comment) throws Exception;

	// 댓글 삭제
	@Transactional
	void deleteComment(PostDto.DeleteComment deleteComment) throws Exception;

	// 구군 정보 얻어오기
	List<PostDto.Gugun> getGugun(String sidoCode) throws Exception;
}
