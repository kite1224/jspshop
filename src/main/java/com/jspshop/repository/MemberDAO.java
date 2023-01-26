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
	
	public int insert(Member member) throws MemberException{
		int result = sqlSession.insert("Member.insert", member);
		if(result<1) {
			throw new MemberException("회원가입 실패");
		}
		return result;
	}
	
	public List selectAll() {
		return  sqlSession.selectList("Member.selectAll");
	}
	
	public void delete(int member_idx) {
		int result = sqlSession.delete("Member.delete",member_idx);
		if(result<1) {
			throw new MemberException("삭제 실패");
		}
	}
}
