package com.jspshop.exception;

public class ProductException extends RuntimeException{
	
	//개발자가 전달을 원하는 에러메시지
	public ProductException(String msg) {
		super(msg);
	}

}
