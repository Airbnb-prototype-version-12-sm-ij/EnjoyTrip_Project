package com.ssafy.enjoytrip;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ssafy.enjoytrip.domain.member.interceptor.AdminChkInterceptor;
import com.ssafy.enjoytrip.domain.member.interceptor.LoginChkInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry
			.addInterceptor(new AdminChkInterceptor())
			.order(1)
			.addPathPatterns("/members/info");
		registry
			.addInterceptor(new LoginChkInterceptor())
			.order(2)
			.addPathPatterns("/posting/**");
	}
}
