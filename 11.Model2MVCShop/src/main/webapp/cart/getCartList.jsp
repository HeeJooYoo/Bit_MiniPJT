<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Insert title here</title>

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
    
	<script type="text/javascript">
	
		function funDeleteCart(prodNo) {
			if (confirm("�����Ͻ� ��ǰ�� �����Ͻðڽ��ϱ�?")) {			
				location.href="/cart/deleteCart?userId=${user.userId}&prodNo="+prodNo;
			}
		}
		
	</script>
	<style>
		body {
            padding-top : 50px;
        }
	</style>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ٱ���</h3>
	       <h5 class="text-muted"><strong class="text-danger">${user.userName}��</strong>�� ��ٱ���( ${totalCount} )</h5>
	    </div>
	    
		<div class="row">
			<c:forEach var="cart" items="${cart}">
				
				  <div class="col-xs-6 col-md-3">
				    <div class="thumbnail">
				      <img src = "/images/uploadFiles/${cart.cartProduct.fileName}"/>
				      <div class="caption">
				        <h3>${cart.cartProduct.prodName}</h3>
				        <p>���� : ${cart.amount}</p>
				        <p>���� : ${cart.cartProduct.price}</p>
				        <p>
				        	<a href="/product/getProduct?menu=search&prodNo=${cart.cartProduct.prodNo}" class="btn btn-primary" role="button">�󼼺���</a>
				        	<a href="javascript:funDeleteCart(${cart.cartProduct.prodNo})" class="btn btn-default" role="button">����</a> 
				        </p>
				      </div>
				    </div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>