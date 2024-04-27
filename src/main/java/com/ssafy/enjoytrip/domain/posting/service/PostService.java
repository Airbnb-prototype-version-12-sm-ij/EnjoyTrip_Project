package com.ssafy.enjoytrip.domain.posting.service;

import java.io.IOException;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;

public interface PostService {

	// 게시글 조회 (전체)
	List<PostEntity> getPostList() throws IOException;

	// 게시글 조회 (특정)
	PostEntity getPost(Integer postId) throws IOException;

	// 게시글 등록
	@Transactional
	void registPost(PostDto.Regist regist) throws IOException;

	// 게시글 수정
	@Transactional
	void modifyPost(PostDto.Update update) throws IOException;

	// 게시글 삭제
	@Transactional
	void deletePost(PostDto.DeletePost deletePost) throws IOException;

	// 댓글 등록
	@Transactional
	void registComment(PostDto.Comment comment) throws IOException;

	// 댓글 삭제
	@Transactional
	void deleteComment(PostDto.DeleteComment deleteComment) throws IOException;

	// 구군 정보 얻어오기
	List<PostDto.Gugun> getGugun(String sidoCode) throws IOException;
}
