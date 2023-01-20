<%@page import="com.jspshop.domain.Admin"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String[] sizeList={"XS","S","M","L","XL","XXL"};
	String[] colorList={"베이지","네이비","브라운","블랙"};
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Dashboard</title>
<%@ include file="/admin/inc/header_link.jsp"%>


</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Preloader -->
		<%@ include file="/admin/inc/preloader.jsp"%>

		<!-- Navbar -->
		<%@ include file="/admin/inc/navbar.jsp"%>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<%@ include file="/admin/inc/sidebar_left.jsp"%>


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							
							<h1 class="m-0">Dashboard</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Dashboard v1</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="col">
						<form id="form1">
							<div class="form-group">
								<select class="form-control" id="category"></select>

						</div>
						<div class="form-group">
							<input type="email" class="form-control" placeholder="상품명" id="product_name">
						</div>
						<div class="form-group">
							<input type="email" class="form-control" placeholder="브랜드" id="brand">
						</div>
						<div class="form-group">
							<input type="number" class="form-control" placeholder="가격" id="price">
						</div>
						<div class="form-group">
							<input type="number" class="form-control" placeholder="할인가" id="discount">
						</div>

						<div class="form-group">
							<%for(int i=0; i<sizeList.length; i++){ %>
							<div class="icheck-primary d-inline">
								<input type="checkbox" id="checkboxPrimary<%=i %>" name="size"
									value="<%=sizeList[i]  %>"> <label
									for="checkboxPrimary<%=i %>"><%=sizeList[i] %></label>
							</div>
							<%} %>
						</div>

						<div class="form-group">
							<%for(int i=0; i<colorList.length; i++){ %>
							<div class="icheck-primary d-inline">
								<input type="checkbox" id="color<%=i %>" name="color" value="<%=colorList[i]  %>"> 
								<label for="color<%=i %>"><%=colorList[i] %></label>
							</div>
							<%} %>
						</div>


					</div>
					<div class="form-group">
						<textarea id="detail" class="form-control"></textarea>
					</div>
				            
					
					<div class="form-group">
						<div class="custom-file">		
                                    <input type="file" class="custom-file-input" multiple id="file">
                             </div>
                             <span class="btn btn-success col-12 fileinput-button"  onClick="triggerFile()">
                             	<i class="fas fa-plus"> 파일을 추가하세요</i>
                             </span>
                                </div>
					
					<div class="row form-group" id="preview"></div>
					
					<div class="form-group">
						<button type="button" class="btn btn-primary" id="bt_regist">등록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- /.container-fluid -->
	</section>
	<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->

	<%@ include file="/admin/inc/footer.jsp"%>

	<!-- Control Sidebar -->
	<%@ include file="/admin/inc/sidebar_right.jsp"%>
	<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->
	<%@ include file="/admin/inc/footer_link.jsp"%>
	<script type="text/babel">
		function ImageBox(props){
			return(
				<div className={"col-sm-2 border"}>
					<div>
						<a href="#" onClick={(e)=>removeImg(e, props.index)}>x</a>
					</div>
					<img src={props.src} width="100px"/>
				</div>
			);
		}

	</script> 
	<script type="text/javascript">
		function triggerFile(){
			//파일 컴포넌트를 대상으로 클릭 효과를 낸다(간접적 클릭)
			$("#file").trigger("click");
			
			
		}
			
		function regist(){
			let formData = new FormData();
			//이미지 미리보기 기능은 단순히 우리만의 배열 처리 > 컴포넌트는 인식하지 못함(input type="file")은 여전히 유저가 선택한 이미지정보 유지
			//기존의 폼을 그대로 전송하지 않고, 개발자가 폼에 들어갈 파일을 직접 제어해야한다 >jquery가 지원해준다
			console.log("전송을 위한 폼에 넣을 파일의 수 는",fileList.length);
			alert($("#category").val());
			formData.append("category_idx", $("#category").val());
			formData.append("product_name", $("#product_name").val());
			formData.append("brand", $("#brand").val());
			formData.append("price", $("#price").val());
			formData.append("discount", $("#discount").val());
			
			//체크된 것에 데이터를 모으자
			//체크된 데이터만 모을 배열
			let sizeCheckedArray=[]; 
			for(let i=0; i<$("input[name='size']").length; i++){
				if($($("input[name='size']")[i]).is(':checked')){
					sizeCheckedArray.push($($("input[name='size']")[i]).val());
				}
			}
					//배열에 값 밀어넣기
			formData.append("size[]",sizeCheckedArray); //대괄호를 붙이면 배열로 인식한다
			
			
			//배열을 보내되 더 줄여쓰는 코드를 작성
			let colorCheckedArray=[];
				$.each( $("input[name='color']:checked"), function(){
					colorCheckedArray.push($(this).val());
				});
			formData.append("color[]", colorCheckedArray);
			
			
			formData.append("detail", $("#detail").val());
			
			for(let i=0; i<fileList.length; i++){				
				let file = fileList[i];
				
				formData.append("file",file); //파일 뿐 아니라 파라미터 등을 심을 수 있다
				
			}
			
			//비동기 방식으로 formdata를 전송하자
			 //processData:false, --> 쿼리스트링화 방지 : 이미지는 쿼리스트링으로 전송할 수 없기 때문
            //application/x-www... --> contentType:false
			$.ajax({
				url:"/admin/product/regist2.jsp",
				type:"post",
				processData:false, //쿼리스트링화 방지
				contentType:false, //application//x-www방지
				data:formData,
				success:function(result, status, xhr){
					alert("상품 등록이 완료되었습니다");
				}
				
			});
		}
		
	</script>

	<script type="text/babel">
	let tag=[]; //<imageBox> ui 컴포넌트를 누적할 배열
	let previewRoot; //리액트에 의해 렌더링된 컨테이너 요소	
	let fileList=[];//파일 정보를 가진 배열
	let oriFiles; //원래 유저가 선택한 파일의 원본
	
	
   function removeImg(e,index){
      //시각적인 처리
      $(e.target).parent().parent().remove();

	//원본 배열에서 해당 파일을 추출한다
      let file=oriFiles[index];

      //배열에서의 삭제 
      let sel_index = fileList.indexOf(file); // 추출한 파일이 삭제 대상의 배열에 몇 번째 위치해있는지 index를 조사한다
      fileList.splice(sel_index,1);
   }


	function createCategoryTable(result) {
        let op = "<option value='0'>상품분류 선택</option>";
        for (let i = 0; i < result.length; i++) {
            let category = result[i];
            op += "<option value='"+category.category_idx+"'>"
                    + category.category_name + "</option>";
        }
        $("#category").html(op);
    }

    //카테고리 목록 가져오기
    function getCategoryList() {
        $.ajax({
            url : "/admin/category/category_list.jsp",
            type : "GET",
            success : function(result, status, xhr) {
                console.log(result);
                //let categoryList=JSON.parse(result);

                createCategoryTable(result); //목록 UI에 반영
            }
        });
    }
    
    //사용자가 선택한 파일들을 매개변수로 받자
    function previewImg(){
    
    	 for(let i=0; i<fileList.length; i++){    		 
    		let reader = new FileReader();
    		//파일이 읽혀지면
    		reader.onload=function(e){
    			// e에는 읽은 파일에 대한 정보가 들어있다.
    			tag.push(<ImageBox key={i} src={e.target.result} index={i}/>);
			
				if(i>=fileList.length-1){//마지막 이미지에 도달하면				
    				previewRoot.render(tag);
				}
    		};
    		reader.readAsDataURL(fileList[i]); //읽을 대상 파일
    		
    	 }
    }

    $(function() {
		previewRoot = ReactDOM.createRoot(document.getElementById("preview"));

        $(document).ready(function() {
            getCategoryList(); //카테고리 목록 가져오기
            $('#detail').summernote({
                height : 200
            });
        });
	
		$("#bt_regist").click(function(){
			regist();
		});

        
        $("#file").change(function(){
        	this.files; //파일 컴포넌트에서 선택한 파일을 보유한 배열 > 이 배열은 read only(제어불가능)
        	 console.log("당신이 선택한 파일 수는", this.files.length);
				
			//유저가 선택한 파일에 대한 정보를 배열로 얻기
			oriFiles=this.files;
			//this.files.splice();

			//this.files는 이미 자바스크립트의 파일배열로써, 읽기만 가능하다.
			//수정 가능한 배열로 두려면  this.files안에 있는 요소들을 끄집어내서 일반배열로 옮겨야한다
			for(let i=0; i<this.files.length; i++){
				fileList.push(this.files[i]);
			}

        	previewImg();
        });
    });
	</script>
</body>
</html>