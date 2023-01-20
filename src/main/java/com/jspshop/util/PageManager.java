package com.jspshop.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Data;

//페이징 처리 계산을 담당하는 객체
@Data
public class PageManager {
	private int totalRecord; //총 레코드 수
	private int pageSize=10; //페이지 당 보여질 레코드 수
	private int totalPage; //총 페이지 수
	private int blockSize=10; // 블럭당 보여질 ㅠㅔ이지 수
	private int currentPage=1; //현재 페이지
	private int firstPage; //시작페이지
	private int lastPage; //마지막 페이지
	private int curPos;//페이지 당 ArrayList의 시작 index
	private int num; //페이지 당 시작번호
	
	public void init(List list, HttpServletRequest request) {
		totalRecord=list.size();
		totalPage =(int) Math.ceil((float)totalRecord/pageSize);
		if(request.getParameter("currentPage")!=null) {
			currentPage  = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		firstPage = currentPage-(currentPage-1)%blockSize;
		lastPage = firstPage + (blockSize-1);
		curPos = (currentPage-1) * pageSize;
		num = totalRecord - curPos;
	}
	
}
