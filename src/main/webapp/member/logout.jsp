<%@page import="com.jspshop.util.ResponseMessage"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//로그아웃 처리는 기존 회원이 사용중이던 세션을 비활성화 하는 것
	session.invalidate();
out.print(ResponseMessage.getMsgURL("로그아웃되었습니다", "/"));
%>