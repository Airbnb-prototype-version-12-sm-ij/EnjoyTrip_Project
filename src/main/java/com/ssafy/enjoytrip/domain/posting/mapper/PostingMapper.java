package com.ssafy.enjoytrip.domain.posting.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;

@Mapper
public interface PostingMapper {

	// 게시글 조회 (전체)
	List<PostEntity> getPostList() throws SQLException;

	// 게시글 조회 (특정)
	PostEntity getPost(Integer postId) throws SQLException;

	// 게시글 등록
	void registPost(PostDto.Regist regist) throws SQLException;

	// 게시글 수정
	void modifyPost(PostDto.Regist regist) throws SQLException;

	// 게시글 삭제
	void deletePost(PostDto.DeletePost deletePost) throws SQLException;

	// 댓글 등록
	void registComment(PostDto.Comment comment) throws SQLException;

	// 댓글 삭제
	void deleteComment(PostDto.DeleteComment deleteComment) throws SQLException;


	/*TODO 댓글 수정*/
}
