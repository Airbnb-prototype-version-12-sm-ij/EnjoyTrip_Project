package com.ssafy.enjoytrip.domain.posting.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;

@Mapper
public interface PostingMapper {

	// 게시글 조회 (전체)
	List<PostEntity> getPostList() throws SQLException;

	// 게시글 조회 (특정)
	PostEntity getPost(Integer postId) throws SQLException;

	// 게시글 조회 (지역)
	List<PostEntity> getPostsBySidoCode(String sidoCode) throws SQLException;

	// 게시글 등록
	@Transactional
	void registPost(PostDto.Regist regist) throws SQLException;

	// 파일 등록
	@Transactional
	void registerFile(PostDto.Regist regist) throws SQLException;

	// 게시글의 파일들 불러오기
	List<PostDto.FileInfo> fileInfoList(int articleNo) throws SQLException;

	// 게시글 수정
	@Transactional
	void modifyPost(PostDto.Update update) throws SQLException;

	// 게시글 삭제
	@Transactional
	void deletePost(PostDto.DeletePost deletePost) throws SQLException;

	// 시도 이름 찾기
	String getSidoName(Integer sidoCode) throws SQLException;

	// 시도 코드 찾기
	List<Integer> getSidoCode(String sidoName) throws SQLException;

	// 구군 찾기
	String getGugunName(Integer sidoCode, Integer gugunCode) throws SQLException;

	//댓글 조회
	List<PostDto.Comment> getComment(Integer postId) throws SQLException;

	// 댓글 등록
	@Transactional
	void registComment(PostDto.Comment comment) throws SQLException;

	// 댓글 삭제
	@Transactional
	void deleteComment(PostDto.DeleteComment deleteComment) throws SQLException;

	// 시도 코드로 구군 코드 얻어오기
	List<PostDto.Gugun> getGugun(String sidoCode) throws SQLException;

	// 조회수 증가
	@Transactional
	void increaseHit(Integer postId) throws SQLException;

	// 게시글 검색
	List<PostEntity> searchPostList(String key, String word) throws SQLException;


	/*TODO 댓글 수정*/
}
