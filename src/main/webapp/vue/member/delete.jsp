<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	MemberDAO memberDAO = new MemberDAO();
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
%>
<%
	SqlSession sqlSession =mybatisConfig.getSqlSession();
	
	
	String member_idx= request.getParameter("member_idx");
	memberDAO.setSqlSession(sqlSession);
	try{		
	 	memberDAO.delete(Integer.parseInt(member_idx));
		sqlSession.commit();
	}catch(MemberException e){
		sqlSession.rollback();
	}finally{
		mybatisConfig.release(sqlSession);
	}
	
		
	
%>