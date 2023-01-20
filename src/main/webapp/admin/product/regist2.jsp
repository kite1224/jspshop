<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@page import="com.jspshop.repository.ProductDAO"%>
<%@page import="com.jspshop.util.FileManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jspshop.domain.Pimg"%>
<%@page import="com.jspshop.domain.Color"%>
<%@page import="com.jspshop.domain.Psize"%>
<%@page import="com.jspshop.domain.Category"%>
<%@page import="com.jspshop.domain.Product"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.net.ApplicationBufferHandler"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="application/json; charset=UTF-8"%>
<%! 
	ProductDAO productDAO = new ProductDAO();	
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
%>
<%!
	int maxSize=5*(1024*1024);
	String path="/data/";  
%>
<%
	//업로드 관련 설정정보를 가진 객체 > 서블릿 업로드와 함께 새로 만들어진다
	DiskFileItemFactory factory=new DiskFileItemFactory();
	//이곳은 서비스 영역이라 실질적으로 요청하는 공간이다 > 이 곳에서 내장객체를 처리해야한다.
	path=application.getRealPath(path); // 실제 경로로 대체됨
	System.out.print(path);
	
	//파일 업로드 요청이 있으므로 업로드 라이브러리를 활용해야한다
	factory.setSizeThreshold(maxSize); //파일 사이즈
	factory.setRepository(new File(path)); //임시디렉토리 및 파일 저장위치
	
	//실제 업로드 처리 담당
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	//클라이언트의 요청 분석 후 itemlist 로 결과 반환
	List<FileItem> itemList =upload.parseRequest(request);
	
	//클라이언트의 파라미터의 종류와 이름에 따라 적절한 DTO에 담는다
	Product product = new Product();
	List<Psize> psizeList =  new ArrayList();
	List<Color> colorList =  new ArrayList();
	List<Pimg> pimgList =  new ArrayList();
	
	//product 안에 리스트 넣어두기(위의 네개를 엮어두기)
	product.setPsizeList(psizeList);
	product.setColorList(colorList);
	product.setPimgList(pimgList);
	
	
	//파라미터 수만큼 반복 처리
	for(FileItem item:itemList){
		if(item.isFormField()){ //일반 텍스트 파라미터라면
			if(item.getFieldName().equals("category_idx")){// html의 파라미터명이 카테고리인지
				Category category = new Category(); //product가ㅣ category_idx 라는 int 형으로 보유하지 않고 부모를 dto 형태로 보유중
				category.setCategory_idx(Integer.parseInt(item.getString()));
				product.setCategory(category);
				
			}else if(item.getFieldName().equals("product_name")){// html의 파라미터명이 상품명인지
				product.setProduct_name(item.getString("utf-8"));
			
			}else if(item.getFieldName().equals("brand")){// html의 파라미터명이 브랜드인지
				product.setBrand(item.getString("utf-8"));
			
			}else if(item.getFieldName().equals("price")){// html의 파라미터명이 가격인지
				product.setPrice(Integer.parseInt(item.getString()));
			
			}else if(item.getFieldName().equals("discount")){// html의 파라미터명이 할인가인지
				product.setPrice(Integer.parseInt(item.getString()));
			
			}else if(item.getFieldName().equals("size[]")){// html의 파라미터명이 사이즈인지
				System.out.println(item.getString("utf-8"));
				//넘어온 데이터가 배열인 경우 쉼표로 구분되어있다. > 쉼표를 기준으로 분리시켜 재배열하기
				String[] psize=item.getString("utf-8").split(",");
				for(int i=0; i<psize.length; i++){
					Psize obj = new Psize();//emthy 
					//obj.setProduct(product); //어떤 상품에 소속되어있는지
					obj.setPsize_name(psize[i]); //xl, m...등\
					
					psizeList.add(obj); //dto를 위의 리스트에 추가 
				}
				
			}else if(item.getFieldName().equals("color[]")){// html의 파라미터명이 색상인지
				String[] color=item.getString("utf-8").split(",");
				for(int i=0; i<color.length; i++){
					Color obj = new Color();
					//obj.setProduct(product);
					obj.setColor_name(color[i]);
					
					colorList.add(obj);
				}
			
			}else if(item.getFieldName().equals("detail")){// html의 파라미터명이 상세내용인지
				product.setDetail(item.getString("utf-8"));
			}
		}else{ //파일 업로드라면
			long time = System.currentTimeMillis(); //파일 이름 예정
			String ext = FileManager.getExt(item.getName());
			String filename = time+"."+ext; //파일명 조합
			item.write(new File(path+filename)); //이 시점에서 디스크에 내려쓰기
			
			//파일에 대한 정보를 dto에 담아서 
			Pimg pimg = new Pimg();
			//pimg.setProduct(product); //어떤 상품에 소속된 이미지인지
			pimg.setFilename(filename);
			
			pimgList.add(pimg);
			
		}
	}
		//최종으로 채워진 product 확인
		System.out.println(product);
		
		SqlSession sqlSession = mybatisConfig.getSqlSession();
		//얻어진  SqlSession을 해당 DAO에게 전달
		productDAO.setSqlSession(sqlSession);
		
		productDAO.insert(product);
		sqlSession.commit();
%>