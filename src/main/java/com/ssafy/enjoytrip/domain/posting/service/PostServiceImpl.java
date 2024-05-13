package com.ssafy.enjoytrip.domain.posting.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;
import com.ssafy.enjoytrip.domain.posting.mapper.PostingMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

	private final PostingMapper postingMapper;

	@Override
	public List<PostEntity> getPostList() throws Exception {
		try {
			List<PostEntity> postList = postingMapper.getPostList();
			for (PostEntity post : postList) {
				List<PostDto.FileInfo> fileInfoList = postingMapper.fileInfoList(post.getPostId());
				post.setFileInfo(fileInfoList);
			}
			return postList;

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<PostEntity> searchPostList(String key, String word) throws Exception {
		return postingMapper.searchPostList(key, word);
	}

	public List<PostEntity> getPostsBySidoCode(String sidoCode) throws SQLException {
		return postingMapper.getPostsBySidoCode(sidoCode);
	}

	@Override
	public PostEntity getPost(Integer postId) throws Exception {
		try {
			return postingMapper.getPost(postId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void registPost(PostDto.Regist regist) throws Exception {
		try {
			postingMapper.registPost(regist);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

		List<PostDto.FileInfo> fileInfos = regist.getFileInfos();
		if (fileInfos != null && !fileInfos.isEmpty()) {
			try {
				postingMapper.registerFile(regist);
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	@Override
	public List<PostDto.FileInfo> fileInfoList(int articleNo) throws Exception {
		return postingMapper.fileInfoList(articleNo);
	}

	@Override
	public void modifyPost(PostDto.Update update) throws Exception {
		try {
			postingMapper.modifyPost(update);
		} catch (SQLException e) {
			log.info(" =========================================SERVICE modifyPost error");
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deletePost(PostDto.DeletePost deletePost) throws Exception {
		try {
			postingMapper.deletePost(deletePost);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public String getSidoName(Integer sidoCode) throws Exception {
		try {
			return postingMapper.getSidoName(sidoCode);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<Integer> getSidoCode(String sidoName) throws Exception {
		try {
			return postingMapper.getSidoCode(sidoName);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public String getGugunName(Integer sidoCode, Integer gugunCode) throws Exception {
		try {
			return postingMapper.getGugunName(sidoCode, gugunCode);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<PostDto.Comment> getComment(Integer postId) throws Exception {
		return postingMapper.getComment(postId);
	}

	@Override
	public void registComment(PostDto.Comment comment) throws Exception {
		try {
			postingMapper.registComment(comment);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	@Override
	public void deleteComment(PostDto.DeleteComment deleteComment) throws Exception {
		try {
			postingMapper.deleteComment(deleteComment);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<PostDto.Gugun> getGugun(String sidoCode) throws Exception {
		try {
			return postingMapper.getGugun(sidoCode);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void increaseHit(Integer postId) throws Exception {
		try {
			postingMapper.increaseHit(postId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}

