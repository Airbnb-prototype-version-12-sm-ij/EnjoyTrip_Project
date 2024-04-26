package com.ssafy.enjoytrip.domain.posting.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;

public interface PostService {

	// 게시글 조회 (전체)
	List<PostEntity> getPostList() throws IOException;

	// 게시글 조회 (특정)
	PostEntity getPost(Integer postId) throws IOException;

	// 게시글 등록
	void registPost(PostDto.Regist regist) throws IOException;

	// 게시글 수정
	void modifyPost(PostDto.Regist regist) throws IOException;

	// 게시글 삭제
	void deletePost(PostDto.DeletePost deletePost) throws IOException;

	// 댓글 등록
	void registComment(PostDto.Comment comment) throws IOException;

	// 댓글 삭제
	void deleteComment(PostDto.DeleteComment deleteComment) throws IOException;

}
