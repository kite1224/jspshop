package com.jspshop.exception;

public class MemberException extends RuntimeException{
	
	//개발자가 전달을 원하는 에러메시지
	public MemberException(String msg) {
		super(msg);
	}

}
