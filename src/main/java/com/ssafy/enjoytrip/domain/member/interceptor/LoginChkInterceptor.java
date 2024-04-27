package com.ssafy.enjoytrip.domain.member.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginChkInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
		HttpSession session = request.getSession();
		MemberEntity user = (MemberEntity)session.getAttribute("memberDto");
		if (user != null) {
			return true;
		}
		request.setAttribute("msg", "로그인해야 접근 가능합니다.");

		response.sendRedirect("/");
		return false;
	}

}