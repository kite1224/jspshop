<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObject"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.domain.Member"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@ page contentType="application/json; charset=UTF-8"%>
<%!
	MemberDAO memberDAO = new MemberDAO();
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
%>
<%
	SqlSession sqlSession = mybatisConfig.getSqlSession();	
	MessageObject messageObject=new MessageObject();

	String id = request.getParameter("id");
	String pass= request.getParameter("pass");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	
	Member member = new Member();
	member.setId(id);
	member.setPass(pass);
	member.setEmail(email);
	member.setName(name);
	
	System.out.println(member);
	
	memberDAO.setSqlSession(sqlSession);
	int result =memberDAO.insert(member);
	
	if(result>0){
		out.print(result);
		sqlSession.commit();
	}
	
%>
