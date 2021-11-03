<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

 <!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	body {
         padding-top : 50px;
     }
</style>

<title>Insert title here</title>

<script type="text/javascript">
	function funGuest() {
		if (confirm("비회원입니다. 구매하시겠습니까?")) {
			self.location="/purchase/addPurchase?prod_no=${product.prodNo}";
		}
	}

	function funCart() {
		if (confirm("장바구니에 상품을 담았습니다.\n\n장바구니 보러가기")) {
			location.href="/cart/addCart/ok";
		} else {
			location.href="/cart/addCart/cancel";
		}
	}
	
	$(function() {
		if (${param.menu != "ok"}) {
			$("#check").text("이전");
		} 
		
		$("#cart").click(function(){
			funCart();
		});
		
		$("#check:contains('이전')").click(function(){
			window.history.back();
		});
		
		$("#check:contains('확인')").click(function(){
			self.location="/product/listProduct?menu=manage";
		});
		
		$("#purchase").click(function(){
			if (${!empty user}) {
				self.location="/purchase/addPurchase?prod_no=${product.prodNo}";				
			} else {
				funGuest();
			}
		});
	});
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	       <h5 class="text-muted"><strong class="text-danger">상품상세정보</strong> 페이지 입니다.</h5>
	    </div>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<img src = "/images/uploadFiles/${sessionScope.product.fileName}"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<c:if test="${param.menu != 'ok'}">
	  				<button type="button" id="cart" class="btn btn-primary">담기</button>
	  				<button type="button" id="purchase" class="btn btn-primary">구매</button>
	  			</c:if>
	  			<button type="button" id="check" class="btn btn-default">확인</button>
	  		</div>
		</div>
		
		<br/>
	</div>
<form>
</body>
</html>