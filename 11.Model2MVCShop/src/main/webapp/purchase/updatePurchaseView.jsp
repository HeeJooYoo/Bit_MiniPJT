<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

	<title>구매정보 수정</title>
	
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
		
		$(function(){
			$("#phone1").change(function() {
				$("#phone2").focus();
			});
			
			$("a[href='#']:contains('수정')").click(function(){
				fncUpdatePurchase();
			});
			
			$("a[href='#']:contains('취소')").click(function(){
				window.history.back();
			});
			
			$("#divyDate").datepicker({
				/* showOn:"both",
				buttonImage:"../images/ct_icon_date.gif",
				buttonImageOnly:true, */
				changeMonth: true,
				changeYear: true,
				dateFormat:"yy-mm-dd"
			});
		});
	
		function fncUpdatePurchase() {
			if($("#phone2").val() != "" && $("#phone3").val() != "") {
				$("#receiverPhone").val($("#phone1").val()+"-"+$("#phone2").val()+"-"+$("#phone3").val());
			} else {
				$("#receiverPhone").val("");
			}
			
			$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
		}
	</script>

</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보수정</h3>
	       <h5 class="text-muted">구매정보를 <strong class="text-danger">업데이트</strong>해주세요.</h5>
	    </div>
		
		<form class="form-horizontal">
			<c:if test="${!empty user}">
				<div class="form-group">
				    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				    <div class="col-sm-4">${purchase.buyer.userId}</div>
				    <input type="hidden" name="buyerId" value="${purchase.buyer.userId}"/>
				</div>
			</c:if>
			
			<div class="form-group">
			    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
			    <div class="col-sm-4">
			      	<select class="form-control" name="paymentOption" id="paymentOption">
						<option value="1" selected=${purchase.paymentOption == '1' ? 'selected' : ''}>현금구매</option>
						<option value="2" selected=${purchase.paymentOption == '2' ? 'selected' : ''}>신용구매</option>
					</select>
				</div>
			</div>
	
			<div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">
			    	구매자이름 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}" />
			    </div>
			</div>
	
			<div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">
			    	구매자연락처 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-2">
					<select class="form-control" name="phone1" id="phone1">
						<option value="010" ${ ! empty purchase.phone1 && purchase.phone1 == "010" ? "selected" : ""  } >010</option>
						<option value="011" ${ ! empty purchase.phone1 && purchase.phone1 == "011" ? "selected" : ""  } >011</option>
						<option value="016" ${ ! empty purchase.phone1 && purchase.phone1 == "016" ? "selected" : ""  } >016</option>
						<option value="018" ${ ! empty purchase.phone1 && purchase.phone1 == "018" ? "selected" : ""  } >018</option>
						<option value="019" ${ ! empty purchase.phone1 && purchase.phone1 == "019" ? "selected" : ""  } >019</option>
					</select>
			   	</div>
			    <div class="col-sm-2">
			    	<input type="text" class="form-control" id="phone2" name="phone2" value="${ ! empty purchase.phone2 ? purchase.phone2 : ''}"  placeholder="변경번호">
			    </div>
			    <div class="col-sm-2">
			    	<input type="text" class="form-control" id="phone3" name="phone3" value="${ ! empty purchase.phone3 ? purchase.phone3 : ''}"   placeholder="변경번호">
			    </div>
			    	<input type="hidden" name="receiverPhone" id="receiverPhone" />
			</div>
			
			<div class="form-group">
			    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
			    <div class="col-sm-4">
			      	<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
			    <div class="col-sm-4">
			      	<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
			    <div class="col-sm-4">
			    	<input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate}" readonly />
			    </div>
			</div>
	
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
				  	<a class="btn btn-primary btn" href="#" role="button">수정</a>
				  	<a class="btn btn-default btn" href="#" role="button">취소</a>
			    </div>
			</div>
		</form>
	</div>
</body>
</html>