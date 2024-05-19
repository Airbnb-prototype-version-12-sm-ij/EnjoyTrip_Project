package com.ssafy.enjoytrip.domain.attraction.entity;

import lombok.Data;

@Data
public class AttractionEntity {

	private Integer contentId;
	private Integer contentTypeId;
	private String title;
	private String addr1;
	private String addr2;
	private String zipcode;
	private String tel;
	private String firstImage;
	private String firstImage2;
	private Integer readCount;
	private Integer sidoCode;
	private Integer gugunCode;
	private double latitude;
	private double longitude;
	private String mlevel;
	private String overview;
	private String wishlistId;
	private Integer wishCount;
	private Double reviewCount;
}
