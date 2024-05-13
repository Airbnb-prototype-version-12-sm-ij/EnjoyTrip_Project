package com.ssafy.enjoytrip.domain.posting.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;
import com.ssafy.enjoytrip.domain.posting.dto.PostDto;
import com.ssafy.enjoytrip.domain.posting.entity.PostEntity;
import com.ssafy.enjoytrip.domain.posting.service.PostService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/posting")
public class PostingController {

	@Value("${file.path}")
	private String uploadPath;

	@Value("${file.path.upload-images}")
	private String uploadImagePath;

	@Value("${file.path.upload-files}")
	private String uploadFilePath;

	private final PostService postService;

	@GetMapping("/")
	public ResponseEntity<List<PostEntity>> list(@RequestParam(required = false) String key,
		@RequestParam(required = false) String word) {

		try {
			List<PostEntity> postList;
			if (key != null && word != null) {
				if (key.equals("sido_code")) {
					List<PostEntity> mergedList = new ArrayList<>();
					List<Integer> sidos = postService.getSidoCode(word);

					for (Integer sidoCode : sidos) {
						System.out.println("word : " + word);
						mergedList.addAll(postService.searchPostList(key, sidoCode.toString()));
					}

					postList = mergedList;

				} else {
					postList = postService.searchPostList(key, word);
				}
			} else {
				postList = postService.getPostList();
			}

			List<String> sidos = new ArrayList<>();
			for (PostEntity post : postList) {
				sidos.add(postService.getSidoName(post.getSidoCode()));
			}

			return new ResponseEntity<>(postList, HttpStatus.OK);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	@GetMapping("/list/{sidoCode}")
	public ResponseEntity<List<PostEntity>> getPostsBySidoCode(@PathVariable String sidoCode) {
		try {
			List<PostEntity> posts = postService.getPostsBySidoCode(sidoCode);
			for (PostEntity post : posts) {
				String sidoName = postService.getSidoName(post.getSidoCode());
				post.setSidoName(sidoName); // 시도 이름 설정
			}
			return new ResponseEntity<>(posts, HttpStatus.OK);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@PostMapping("/write")
	public ResponseEntity<Void> write(
		@Validated PostDto.Regist regist,
		BindingResult bindingResult,
		@RequestParam("upfile") MultipartFile[] files,
		HttpSession session) throws
		IOException {

		log.info("==============================={}======================================", regist);
		log.info("==============================={}======================================",
			((MemberEntity)session.getAttribute("memberDto")).getUserId());

		if (bindingResult.hasErrors()) {

			log.info("error : {}", bindingResult.getAllErrors());

			StringBuilder sb = new StringBuilder();

			for (ObjectError error : bindingResult.getAllErrors()) {
				sb.append(error.getDefaultMessage());
			}
		}

		if (!files[0].isEmpty()) {
			String today = new SimpleDateFormat("yyMMdd").format(new Date());
			String saveFolder = uploadPath + File.separator + today;
			log.debug("저장 폴더 : {}", saveFolder);
			File folder = new File(saveFolder);
			if (!folder.exists())
				folder.mkdirs();
			List<PostDto.FileInfo> fileInfos = new ArrayList<PostDto.FileInfo>();
			for (MultipartFile mfile : files) {
				PostDto.FileInfo fileInfoDto = PostDto.FileInfo.builder().build();
				String originalFileName = mfile.getOriginalFilename();

				log.info("==========================originalFileName : {}========================", originalFileName);

				if (!originalFileName.isEmpty()) {
					String saveFileName = UUID.randomUUID().toString().replace("-", "")
						+ originalFileName.substring(originalFileName.lastIndexOf('.'));

					log.info("==========================saveFileName : {}========================", saveFileName);
					fileInfoDto.setSaveFolder(today);
					fileInfoDto.setOriginalFile(originalFileName);
					fileInfoDto.setSaveFile(saveFileName);
					log.debug("원본 파일 이름 : {}, 실제 저장 파일 이름 : {}", mfile.getOriginalFilename(), saveFileName);
					mfile.transferTo(new File(folder, saveFileName));
				}
				fileInfos.add(fileInfoDto);
			}
			regist.setFileInfos(fileInfos);
		}

		String userId = ((MemberEntity)session.getAttribute("memberDto")).getUserId();
		regist.setUserId(userId);
		try {
			postService.registPost(regist);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	// 시도 코드로 구군 데이터 얻기
	@Deprecated
	@GetMapping("/getGugun/{sidoCode}")
	public ResponseEntity<List<PostDto.Gugun>> getGugun(@PathVariable String sidoCode) {
		try {
			List<PostDto.Gugun> gugun = postService.getGugun(sidoCode);
			return new ResponseEntity<>(gugun, HttpStatus.OK);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	// 게시글 상세 조회
	@GetMapping("/{postId}")
	public ResponseEntity<PostEntity> view(@PathVariable Integer postId) {

		log.info("=====================================================================");

		try {
			// 조회수 증가
			postService.increaseHit(postId);
			PostEntity post = postService.getPost(postId);
			List<PostDto.FileInfo> fileInfos = postService.fileInfoList(postId);

			String sidoName = postService.getSidoName(post.getSidoCode());
			String gugunName = postService.getGugunName(post.getSidoCode(), post.getGugunCode());

			post.setFileInfo(fileInfos);
			post.setSidoName(sidoName);
			post.setGugunName(gugunName);

			log.info("post : {}", post);
			return new ResponseEntity<>(post, HttpStatus.OK);

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@DeleteMapping("{postId}")
	public ResponseEntity<Void> deletePost(@PathVariable Integer postId, HttpSession session) {

		PostDto.DeletePost deletePost = PostDto.DeletePost.builder()
			.userId(((MemberEntity)session.getAttribute("memberDto")).getUserId())
			.postId(postId)
			.build();

		try {
			postService.deletePost(deletePost);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	//수정
	@PutMapping("/{postId}")
	public ResponseEntity<Void> modify(@PathVariable Integer postId,
		@Validated @RequestBody PostDto.Update update,
		BindingResult bindingResult,
		HttpSession session) {

		log.info("===================================수정이요~~~=====================================");
		log.info("==================================={}=====================================", update);

		if (bindingResult.hasErrors()) {
			log.info("error : {}", bindingResult.getAllErrors());
		}

		String userId = ((MemberEntity)session.getAttribute("memberDto")).getUserId();
		update.setUserId(userId);
		update.setPostId(postId);

		try {
			postService.modifyPost(update);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@GetMapping("/comment/{postId}")
	public ResponseEntity<List<PostDto.Comment>> getComment(@PathVariable Integer postId) {

		log.info("===================================댓글 조회=====================================");

		try {
			List<PostDto.Comment> list = postService.getComment(postId);
			return new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@PostMapping("/comment/{postId}")
	public ResponseEntity<Void> writeComment(@RequestBody PostDto.Comment comment, HttpSession session) {

		log.info("============================댓글 작성=====================");
		comment.setUserId(((MemberEntity)session.getAttribute("memberDto")).getUserId());
		log.info("==============================={}==============================", comment);

		try {
			postService.registComment(comment);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@DeleteMapping("/comment/{commentId}")
	public ResponseEntity<Void> deleteComment(@PathVariable Integer commentId, HttpSession session) {

		PostDto.DeleteComment deleteComment = PostDto.DeleteComment.builder()
			.userId(((MemberEntity)session.getAttribute("memberDto")).getUserId())
			.commentId(commentId)
			.build();

		log.info("============================댓글 삭제=====================");
		log.info("==============================={}==============================", deleteComment);

		try {
			postService.deleteComment(deleteComment);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}