<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>구매 목록조회</title>
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
	  
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<style>
		body {
			padding-top : 50px;
	    }
	</style>

	<script type="text/javascript">
		function fncGetPurchaseList(currentPage) {
			$("#currentPage").val(currentPage);
		    $("form").attr("action","/purchase/listPurchase").attr("method", "POST").submit();
		}
		
		$(function() {
			$("#f_button").click(function() {
				var prodNo = $("#f_button").val();
				alert(prodNo);
				self.location="/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode=3";
			});
			
			$("td:nth-child(1)").click(function() {
				var tranNo = $(this).find("input").val();
				console.log(tranNo);
				self.location="/purchase/getPurchase?tranNo="+tranNo;
			});
			
			$("#orderNew").click(function(){
				self.location="/purchase/listPurchase?&searchOrder=1";
			});
			
			$("#orderOld").click(function(){
				self.location="/purchase/listPurchase?&searchOrder=2";
			});
		});
	</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
    
		<div class="page-header text-info">
	       <h3>구매 목록조회</h3>    
	    </div>
		
		 <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
				<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="guestName" name="guestName" value="${guestName}"/>
				<input type="hidden" id="guestPhone" name="guestPhone" value="${guestPhone}"/>
	    		<c:if test="${!empty user}">
	    			<div class="form-group">
				        <input type="hidden" id="searchOrder" name="searchOrder" value="${searchOrder}"/>
					 	<span id="orderNew">최신순</span> | 
					 	<span id="orderOld">과거순</span>
			        </div>
	    		</c:if>
		        <br/>
	    		
	    		</form>
	    	</div>
		</div>
		
		<table class="table table-hover table-striped" >
	        <thead>
	          <tr>
	            <th align="center">상품명</th>
	            <th align="left" >이름</th>
	            <th align="left">전화번호</th>
	            <th align="left">배송현황</th>
	            <th align="left">도착현황</th>
	          </tr>
	        </thead>
	        
			<tbody>
			  <c:set var="i" value="0" />
			  <c:forEach var="vo" items= "${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="left">
				  	<a type="button">${vo.purchaseProd.prodName}</a>
				  	<input type="hidden" value="${vo.tranNo}">
				  </td>
			  	 <c:choose>
					<c:when test="${empty user}">
						<td align="left">${vo.receiverName}</td>
						<td align="left">${vo.receiverPhone}</td>
					</c:when>
					<c:otherwise>
						<td align="left">${user.userName}</td>
						<td align="left">${user.phone}</td>
					</c:otherwise>
				 </c:choose>
				  <td align="left">
				  	 <c:if test="${vo.tranCode == '1'}">
						현재 구매완료 상태 입니다.
					 </c:if>
					 <c:if test="${vo.tranCode == '2'}">
						현재 배송중 상태 입니다.
					 </c:if>
					 <c:if test="${vo.tranCode == '3'}">
						현재 배송완료 상태 입니다.
					 </c:if>
				  </td>
				  <td align="left">
				  	<c:if test="${vo.tranCode == '2'}">
				  		<button id="f_button" value="${vo.purchaseProd.prodNo}">물건도착</button>
				  	</c:if>
				  </td>
				</tr>
	          </c:forEach>
	        </tbody>
      </table>

      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
		<tr>
			<td align="center">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			 	<jsp:include page="../common/pageNavigator_new.jsp">
			 		<jsp:param value="fncGetPurchaseList" name="page"/>
			 	</jsp:include>
			</td>
		</tr>
	  </table>
   </div>
</body>
</html>