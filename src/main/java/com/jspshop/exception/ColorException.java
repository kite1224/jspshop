package com.jspshop.exception;

public class ColorException extends RuntimeException{
	
	//개발자가 전달을 원하는 에러메시지
	public ColorException(String msg) {
		super(msg);
	}

}
