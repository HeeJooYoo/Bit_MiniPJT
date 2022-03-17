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
				/* showOn:"both",
				buttonImage:"../images/ct_icon_date.gif",
				buttonImageOnly:true, */
				changeMonth: true,
				changeYear: true,
				dateFormat:"yy-mm-dd"
			});
			
			$("#fileName").addEventListener('drop', function(e) {
		        e.preventDefault();

		        console.log('drop');
		        this.style.backgroundColor = 'white';
		    });
				
		});
	</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ���</h3>
	       <h5 class="text-muted">��ǰ�� <strong class="text-danger">�� ���</strong>�� �ּ���.</h5>
	    </div>
		
		<form class="form-horizontal">
		 <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">
		    	�� ǰ �� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		    </label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">
		    	��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		    </label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">
		    	�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		    </label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">
		    	���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		    </label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="fileName" name="fileName">
		    </div>
		  </div>
		  
		  <div class="form-group">
		   	<div class="col-sm-offset-4  col-sm-4 text-center">
				<a class="btn btn-primary btn" href="#" role="button">���</a>
		     	<button type="button" class="btn btn-primary">���</button>
		   	</div>
	  	  </div>
		</form>
	
	</div>
</body>
</html>