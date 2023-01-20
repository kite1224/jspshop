package com.jspshop.domain;

import lombok.Data;

@Data
public class Color {
	private int color_idx;
	private Product product; //자식이 부모에 접근하는 것: assosiation으로 가져온다
	private String color_name;
}
