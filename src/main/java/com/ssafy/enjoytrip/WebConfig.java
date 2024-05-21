package com.ssafy.enjoytrip;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	// @Override
	// public void addInterceptors(InterceptorRegistry registry) {
	// 	registry
	// 		.addInterceptor(new AdminChkInterceptor())
	// 		.order(1)
	// 		.addPathPatterns("/members/info");
	// 	registry
	// 		.addInterceptor(new LoginChkInterceptor())
	// 		.order(2)
	// 		.addPathPatterns("/posting/**");
	// }

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
			.allowedOrigins("http://localhost:5173", "http://localhost", "http://172.30.1.85:5173/")
			.allowedMethods("GET", "POST", "PUT", "PATCH", "DELETE")
			.allowedHeaders("*")
			.allowCredentials(true);
	}
}
