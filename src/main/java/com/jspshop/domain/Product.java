package com.jspshop.domain;

import java.util.List;

import lombok.Data;

@Data
public class Product {
	private int product_idx;
	private Category category; //mybatis 에서 부모를  association 으로 연결
	private String product_name;
	private String brand;
	private int price;
	private int discount;
	private String detail;
	
	//하나의 상품이 거느리고있는 자식 테이블을 표현한 dto들
	private List<Psize> psizeList; //mybatis의 collection의 대상이 된다
	private List<Color> colorList; //mybatis의 collection의 대상이 된다
	private List<Pimg> pimgList; //mybatis의 collection의 대상이 된다
}
