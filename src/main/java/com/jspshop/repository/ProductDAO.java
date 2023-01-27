package com.jspshop.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Product;
import com.jspshop.exception.ProductException;

public class ProductDAO {
	private SqlSession sqlSession;
		
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//  throws는 예외를 처리하는 것이 아니라 전가하는 것이다.호출한 사람이 적절한 처리를 해야한다
	public void insert(Product product) throws ProductException{
		int result = 0;
		System.out.println("마바티스 전의 product_idx" + product.getProduct_idx());
		result=sqlSession.insert("Product.insert", product);
		System.out.println("마바티스 후의 product_idx" + product.getProduct_idx());
		if(result<1) {
			//에러를 일부러 일으키자 > 얘는 강요하지않는 예외라서 빨간줄 안감
			throw new ProductException("상품이 등록되지 않았습니다");
		}
	}
	//모두 가져오기
	public List selectAll(){
		return  sqlSession.selectList("Product.selectAll");	
	}
	//검색 시 사용할 메서드
	public List selectBySearch(Map map){
		return  sqlSession.selectList("Product.selectBySearch", map);	
	}
	
	public List selectByCategory(int category_idx){
		return  sqlSession.selectList("Product.selectByCategory", category_idx);	
	}
	
	public Product select(int product_idx) {
		return sqlSession.selectOne("Product.select",product_idx);
	}
	
}
