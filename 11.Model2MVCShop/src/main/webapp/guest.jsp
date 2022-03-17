<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>

<title>��ȸ�� ��ȸ</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<style>
	body {
          padding-top : 50px;
      }
</style>


<script type="text/javascript">

	function fncGuestPurchase() {
		if($("#guestPhone2").val() != "" && $("#guestPhone3").val() != "") {
			$("#guestPhone").val($("#guestPhone1").val() + "-" 
					+ $("#guestPhone2").val() + "-" + $("#guestPhone3").val());
		} else {
			$("#guestPhone").val("");
		}
		
		var name = $("#guestName").val();
		var phone = $("#guestPhone").val();
		
		if(name == null || name.length <1){
			alert("�̸��� �Է����ּ���.");
			return;
		}
		if(phone == null || phone.length <1){
			alert("��ȭ��ȣ�� �Է����ּ���.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
	}
	
	$(function() {
		$("#guestPhone1").change(function() {
			$("#guestPhone2").focus();
		});
		
		$("a[href='#']:contains('�˻�')").click(function(){
			fncGuestPurchase();
		});
		
		$("a[href='#']:contains('���')").click(function(){
			window.history.back();
		});
	});

</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header text-center">
	       <h3 class=" text-info">��ȸ�� ��ȸ</h3>
	       <h5 class="text-muted">��ǰ ��ȸ�� ���� <strong class="text-danger">�̸��� ��ȭ��ȣ</strong>�� �Է����ּ���.</h5>
	    </div>
	    
	    <form class="form-horizontal">
	    	<input type="hidden" name="memberCheck" value="1" />
	    	
	    	<div class="form-group">
			    <label for="guestName" class="col-sm-offset-1 col-sm-2 col-xs-3 control-label">
		    		�̸� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		    	</label>
			    <div class="col-sm-6 col-xs-9">
			      	<input type="text" class="form-control" id="guestName" name="guestName">
				</div>
			</div>
			
			<div class="form-group">
			    <label for="guestPhone" class="col-sm-offset-1 col-sm-2 col-xs-12 control-label">
			    	��ȭ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-2 col-xs-4">
			    	<select class="form-control" id="guestPhone1" name="guestPhone1">
			  			<option value="010" >010</option>
						<option value="011" >011</option>	
						<option value="016" >016</option>
						<option value="018" >018</option>
						<option value="019" >019</option>
					</select>
				</div>
				 <div class="col-sm-2 col-xs-4">
				 	<input type="text" class="form-control" id="guestPhone2" name="guestPhone2" placeholder="��ȣ">
				 </div>
				 <div class="col-sm-2 col-xs-4">
				    <input type="text" class="form-control" id="guestPhone3" name="guestPhone3" placeholder="��ȣ">
				 </div>
				 <input type="hidden" id="guestPhone" name="guestPhone"/>
			</div>
			
			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <a class="btn btn-primary btn" href="#" role="button">�˻�</a>
		      <a class="btn btn-default btn" href="#" role="button">���</a>		      
		    </div>
		  </div>
		</form>
	</div>
</body>

</html>