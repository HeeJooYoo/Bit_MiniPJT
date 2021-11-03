<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
		if (confirm("��ȸ���Դϴ�. �����Ͻðڽ��ϱ�?")) {
			self.location="/purchase/addPurchase?prod_no=${product.prodNo}";
		}
	}

	function funCart() {
		if (confirm("��ٱ��Ͽ� ��ǰ�� ��ҽ��ϴ�.\n\n��ٱ��� ��������")) {
			location.href="/cart/addCart/ok";
		} else {
			location.href="/cart/addCart/cancel";
		}
	}
	
	$(function() {
		if (${param.menu != "ok"}) {
			$("#check").text("����");
		} 
		
		$("#cart").click(function(){
			funCart();
		});
		
		$("#check:contains('����')").click(function(){
			window.history.back();
		});
		
		$("#check:contains('Ȯ��')").click(function(){
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
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	       <h5 class="text-muted"><strong class="text-danger">��ǰ������</strong> ������ �Դϴ�.</h5>
	    </div>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4">
				<img src = "/images/uploadFiles/${sessionScope.product.fileName}"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.product.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<c:if test="${param.menu != 'ok'}">
	  				<button type="button" id="cart" class="btn btn-primary">���</button>
	  				<button type="button" id="purchase" class="btn btn-primary">����</button>
	  			</c:if>
	  			<button type="button" id="check" class="btn btn-default">Ȯ��</button>
	  		</div>
		</div>
		
		<br/>
	</div>
<form>
</body>
</html>