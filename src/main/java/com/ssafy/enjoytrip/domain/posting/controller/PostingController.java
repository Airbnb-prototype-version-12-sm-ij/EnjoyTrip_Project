package com.ssafy.enjoytrip.domain.posting.controller;

import static com.ssafy.enjoytrip.domain.posting.dto.PostDto.*;

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
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
@RequestMapping("/posting")
public class PostingController {

	@Value("${file.path}")
	private String uploadPath;

	@Value("${file.path.upload-images}")
	private String uploadImagePath;

	@Value("${file.path.upload-files}")
	private String uploadFilePath;

	private final PostService postService;

	@GetMapping("/list")
	public String list(Model model) {

		try {
			List<PostEntity> postList = postService.getPostList();

			List<String> sidos = new ArrayList<>();

			for (PostEntity post : postList) {
				sidos.add(postService.getSido(post.getSidoCode()));
			}
			model.addAttribute("postList", postList);
			model.addAttribute("sidos", sidos);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return "posting/list";
	}

	@GetMapping("/write")
	public String writeForm() {
		return "posting/write";
	}

	@PostMapping("/write")
	public String write(@Validated PostDto.Regist regist,
		BindingResult bindingResult,
		Model model,
		@RequestParam("upfile") MultipartFile[] files,
		HttpSession session) throws
		IOException {

		if (bindingResult.hasErrors()) {

			log.info("error : {}", bindingResult.getAllErrors());

			StringBuilder sb = new StringBuilder();

			for (ObjectError error : bindingResult.getAllErrors()) {
				sb.append(error.getDefaultMessage());
			}
			model.addAttribute("errorMsg", sb.toString());
			return "posting/write";
		}

		log.debug("uploadPath : {}, uploadImagePath : {}, uploadFilePath : {}", uploadPath, uploadImagePath,
			uploadFilePath);
		log.debug("MultipartFile.isEmpty : {}", files[0].isEmpty());
		if (!files[0].isEmpty()) {
			//			String realPath = servletContext.getRealPath(UPLOAD_PATH);
			//			String realPath = servletContext.getRealPath("/resources/img");
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
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		return "redirect:/posting/list";
	}

	// 시도 코드로 구군 데이터 얻기
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
	@GetMapping("{postId}")
	public String view(@PathVariable Integer postId, Model model) {

		log.info("=====================================================================");

		try {
			PostEntity post = postService.getPost(postId);
			List<PostDto.FileInfo> fileInfos = postService.fileInfoList(postId);

			model.addAttribute("fileInfos", fileInfos);
			model.addAttribute("post", post);

			log.info("post : {}", post);

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return "posting/view";
	}

	@PostMapping("/delete/{postId}")
	public String deletePost(@PathVariable Integer postId, HttpSession session) {

		PostDto.DeletePost deletePost = PostDto.DeletePost.builder()
			.userId(((MemberEntity)session.getAttribute("memberDto")).getUserId())
			.postId(postId)
			.build();

		try {
			postService.deletePost(deletePost);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		return "redirect:/posting/list";
	}

	//수정
	@GetMapping("/modify/{postId}")
	public String modifyForm(@PathVariable Integer postId, Model model, HttpSession session) {

		PostEntity post = null;

		try {
			post = postService.getPost(postId);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		post.setUserId(((MemberEntity)session.getAttribute("memberDto")).getUserId());
		model.addAttribute("post", post);

		return "/posting/modify";
	}

	@PostMapping("/modify/{postId}")
	public String modify(@PathVariable Integer postId,
		@Validated Update update,
		BindingResult bindingResult,
		Model model,
		HttpSession session) {

		if (bindingResult.hasErrors()) {

			log.info("error : {}", bindingResult.getAllErrors());

			return "posting/modify/" + postId;
		}

		String userId = ((MemberEntity)session.getAttribute("memberDto")).getUserId();
		update.setUserId(userId);
		update.setPostId(postId);

		try {
			postService.modifyPost(update);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		return "redirect:/posting/list";
	}
}