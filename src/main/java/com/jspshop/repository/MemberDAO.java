package com.jspshop.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Member;
import com.jspshop.exception.MemberException;

public class MemberDAO {
	
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession  = sqlSession;
	}
	
	
	public List selectAll() {
		return  sqlSession.selectList("Member.selectAll");
	}
	
	//회원 한 명 가져오기 > 아이디, 패스워드 일치
	public Member select(Member member) throws MemberException {
		Member dto = null;
		dto = sqlSession.selectOne("Member.select",member);
		
		if(dto==null) {
			throw new MemberException("회원정보가 일치하지 않습니다");
		}
		return dto;
	}
	
	//한 건 넣기
	public void insert(Member member) throws MemberException{
		int result=0;
		result=sqlSession.insert("Member.insert",member);
		if(result<1) {
			throw new MemberException("회원가입 실패");
		}
	} 
	
	//한 건 수정
	public void update(Member member) throws MemberException{
		int result=0;
		result=sqlSession.update("Member.update",member);
		if(result<1) {
			throw new MemberException("수정 실패");
		}
	} 
	
	//한 건 삭제
		public void delete(int member_idx) throws MemberException{
			int result=0;
			result=sqlSession.delete("Member.delete",member_idx);
			if(result<1) {
				throw new MemberException("삭제 실패");
			}
		} 
}
