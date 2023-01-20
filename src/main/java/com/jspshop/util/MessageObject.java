package com.jspshop.util;

import lombok.Data;

@Data
//메시지 전달용 클래스
public class MessageObject {
	private int code; //성패를 식별하는 코드 1,0
	private String msg; //클라이언트에게 전송하려는 말
}
