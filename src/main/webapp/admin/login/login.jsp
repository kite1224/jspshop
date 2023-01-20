<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObject"%>
<%@page import="com.jspshop.domain.Admin"%>
<%@page import="com.jspshop.repository.AdminDAO"%>
<%@ page contentType="application/json; charset=UTF-8"%>
<%!
AdminDAO adminDAO = new AdminDAO();
%>
<%
	//로그인 폼으로부터 전송된 파라미터 받기
	String admin_id= request.getParameter("admin_id");
	String admin_pass= request.getParameter("admin_pass");
	
	Admin admin  = new Admin(); //empty
	admin.setAdmin_id(admin_id);
	admin.setAdmin_pass(admin_pass);

	Admin obj = adminDAO.select(admin);
	
	MessageObject msg = new MessageObject();
	Gson gson = new Gson();
	
	if(obj != null){ //로그인 성공(객체가 존재한다=동일인 맞음!)
		//세션객체에 obj를 담아두고 다음 번에 들어왔을 때도 이 유저를 알아봐주자
		//session은 map형식이다. key-value로 관리한다 
		session.setAttribute("admin", obj); //세션에 admin이라는 이름으로 세션에 저장
		msg.setCode(1); //성공 데이터
		msg.setMsg("인증 성공!");
		
	}else{			
		msg.setCode(0); //실패 데이터
		msg.setMsg("당신은 인증실패자입니다.");
	}
	String result = gson.toJson(msg);
	out.print(result);
	
%>