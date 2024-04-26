package com.ssafy.enjoytrip.domain.member.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import com.ssafy.enjoytrip.domain.member.entity.MemberEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

//@SuppressWarnings("deprecation")
//public class ConfirmInterceptor extends HandlerInterceptorAdapter {
//spring 5.3 부터는 HandlerInterceptor implements
//@Component
@Slf4j
public class AdminChkInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
		HttpSession session = request.getSession();
		MemberEntity user = (MemberEntity)session.getAttribute("memberDto");
		if (user != null && user.getGrade().equals("admin")) {
			return true;
		}
		request.setAttribute("msg", "관리자만 접근 가능합니다.");

		response.sendRedirect("/");
		return false;
	}

}