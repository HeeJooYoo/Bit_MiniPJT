<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- 
<%@page import="com.model2.mvc.service.domain.Product"%>
<%
	Product product = (Product)request.getAttribute("product");
%>    
--%>
<!DOCTYPE html>
<html>
<head>

	<title>상품정보수정</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
   <!-- ////////////////// datepicker /////////////////////  -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

	<style>
		body {
            padding-top : 50px;
        }
    </style>

	<script type="text/javascript">
	
		function fncAddProduct(){
			//Form 유효성 검증
		 	/* var name = document.detailForm.prodName.value;
			var detail = document.detailForm.prodDetail.value;
			var manuDate = document.detailForm.manuDate.value;
			var price = document.detailForm.price.value; */
		
			var name = $("input[name='prodName']").val();
			var detail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();
			
			if(name == null || name.length<1){
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if(price == null || price.length<1){
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
				
			/* document.detailForm.action='/product/updateProduct';
			document.detailForm.submit(); */
			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
		}
		
		$(function() {
			$("a[href='#']:contains('수정')").click(function() {
				fncAddProduct();
			});
			
			$("button").click(function() {
				window.history.back();
			});
			
			$("input[name='manuDate']").datepicker({
				/* showOn:"both",
				buttonImage:"../images/ct_icon_date.gif",
				buttonImageOnly:true, */
				changeMonth: true,
				changeYear: true,
				dateFormat:"yy-mm-dd"
			});
				
		});
	</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header text-center">
	       <h3 class=" text-info">상품수정</h3>
	       <h5 class="text-muted">상품을 <strong class="text-danger">업데이트</strong>해주세요.</h5>
	    </div>
	    
	    <form class="form-horizontal">
	    	<input type="hidden" name="prodNo" value="${product.prodNo}"/>
	    	
	    	<div class="form-group">
			    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">
		    		상 품 명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		    	</label>
			    <div class="col-sm-4">
			      	<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
				</div>
			</div>
			
			<div class="form-group">
			    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">
			    	상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">
			    	제조일자 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}" readonly>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">
			    	가격 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
			    </div>
			</div>
			  
			<div class="form-group">
			    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
			    <div class="col-sm-4">
			      <input type="file" class="form-control" id="uploadFile" name="uploadFile" value="${product.fileName}">
			    </div>
			</div>
			  
			<div class="form-group">
			   	<div class="col-sm-offset-4  col-sm-4 text-center">
					<a class="btn btn-primary btn" href="#" role="button">수정</a>
			     	<button type="button" class="btn btn-primary">취소</button>
			   	</div>
		  	</div>
		</form>
	</div>
</body>
</html>