<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">
<head>
	<title>��ǰ���</title>
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	

	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	 <!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
	
	<script type="text/javascript">
		function fncAddProduct(){
			//Form ��ȿ�� ����
	/* 	 	var name = document.detailForm.prodName.value;
			var detail = document.detailForm.prodDetail.value;
			var manuDate = document.detailForm.manuDate.value;
			var price = document.detailForm.price.value; */
			
		 	var name = $("input[name='prodName']").val();
			var detail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();
		
			if(name == null || name.length<1){
				alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(price == null || price.length<1){
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
		
			/* document.detailForm.action='/product/addProduct';
			document.detailForm.submit(); */
			$("form").attr("method" , "POST").attr("action" , "/product/addProduct").attr("enctype", "multipart/form-data").submit();
		}
		
		function resetData(){
			//$("form")[0].reset();
			self.location = "../main.jsp"
		}
		
		$(function() {
			$("button").click(function() {
				resetData();
			});
			
			$("a[href='#']:contains('���')").click(function() {
				fncAddProduct();
			});
			
			$("input[name='manuDate']").datepicker({
				showOn:"both",
				buttonImage:"../images/ct_icon_date.gif",
				buttonImageOnly:true,
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
		<form>
		
		<div class="page-header">
	       <h3 class=" text-info">��ǰ���</h3>
	       <h5 class="text-muted">��ǰ�� <strong class="text-danger">�� ���</strong>�� �ּ���.</h5>
	    </div>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2">
	  			<strong>��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"></strong>
	  		</div>
			<div class="col-xs-8 col-md-4">
				<input type="text" name="prodName" class="ct_input_g" style="width: 100px; height: 20px" maxLength="20">
			</div>
		</div>
	
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 ">
	  			<strong>��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/></strong>
	  		</div>
			<div class="col-xs-8 col-md-4">
				<input type="text" name="prodDetail" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 ">
	  			<strong>�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/></strong>
	  		</div>
			<div class="col-xs-8 col-md-4">
				<input type="text" name="manuDate" readonly="readonly" class="ct_input_g" style="width: 100px; height: 19px; margin-right: 10px" maxLength="10" minLength="6"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 ">
	  			<strong>���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/></strong>
	  		</div>
			<div class="col-xs-8 col-md-4">
				<input type="text" name="price" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10">&nbsp;��
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 ">
	  			<strong>��ǰ�̹���</strong>
	  		</div>
			<div class="col-xs-8 col-md-4">
				<input type="file" name="fileName" class="ct_input_g" style="width: 200px;" maxLength="13"/>
			</div>
		</div>
		
		<hr/>	
		
		<div class="form-group">
		   <div class="col-sm-offset-2  col-sm-10 text-right">
			 <a class="btn btn-primary btn" href="#" role="button">���</a>
		     <button type="button" class="btn btn-primary">���</button>
		   </div>
	  	</div>
	</form>
	
	</div>
</body>
</html>