package com.ssafy.enjoytrip;

import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class SwaggerConfig {

	@Bean
	public OpenAPI openAPI() {
		Info info = new Info().title("EnjoyTrip API").description("EnjoyTrip API 명세서").version("1.0.0")
			.contact(new io.swagger.v3.oas.models.info.Contact().name("enjoytrip"));
		return new OpenAPI().components(new Components()).info(info);
	}

	@Bean
	public GroupedOpenApi publicApi() {
		return GroupedOpenApi.builder().group("public").pathsToMatch("/**").build();
	}
}