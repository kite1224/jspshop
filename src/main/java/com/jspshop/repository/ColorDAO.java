package com.jspshop.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Color;
import com.jspshop.exception.ColorException;
import com.jspshop.exception.ProductException;

public class ColorDAO {
	
private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void insert(Color color) throws ColorException{
		int result = sqlSession.insert("Color.insert", color);
		if(result<1) {
			//에러를 일부러 일으키자 > 얘는 강요하지않는 예외라서 빨간줄 안감
			throw new ColorException("색상 등록 실패");
		}
	}
	
	
}
