package com.jspshop.repository;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Psize;
import com.jspshop.exception.ProductException;
import com.jspshop.exception.PsizeException;

public class PsizeDAO {
	
private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int insert(Psize psize) throws PsizeException{
		int result=0;
		result=sqlSession.insert("Psize.insert", psize);
		if(result<1) {
			//에러를 일부러 일으키자 > 얘는 강요하지않는 예외라서 빨간줄 안감
			throw new PsizeException("사이즈 등록 실패");
		}
		return result;
	}
}
