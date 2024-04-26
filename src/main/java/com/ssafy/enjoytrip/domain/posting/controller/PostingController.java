package com.ssafy.enjoytrip.domain.posting.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

	private final PostService postService;

	@GetMapping("/list")
	public String list(Model model) {

		log.info("===========================list==========================");

		try {
			List<PostEntity> postList = postService.getPostList();

			model.addAttribute("postList", postList);

			log.info("postList : {}", postList);

		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return "posting/list";
	}

	@GetMapping("/write")
	public String writeForm() {
		return "posting/write";
	}

	@PostMapping("/write")
	public String write(PostDto.Regist regist, HttpSession session) {

		String userId = ((MemberEntity)session.getAttribute("memberDto")).getUserId();
		regist.setUserId(userId);

		log.info("===========================write==========================");
		log.info("regist : {}", regist);

		try {
			postService.registPost(regist);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}

		return "posting/list";
	}

	@GetMapping("{postId}")
	public String view(@PathVariable Integer postId, Model model) {

		log.info("===========================view==========================");

		try {
			PostEntity post = postService.getPost(postId);

			model.addAttribute("post", post);

			log.info("post : {}", post);

		} catch (IOException e) {
			throw new RuntimeException(e);
		}

		return "posting/view";
	}

}