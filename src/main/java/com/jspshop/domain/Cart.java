package com.jspshop.domain;

import lombok.Data;

@Data
public class Cart extends Product{
	//상품에는 존재하지 않는 속성인 갯수를 추가하자(자식에게만)
	private int ea;
	private Member member;
	
}
