<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>Insert title here</title>
	
	<!-- ���� �ּ� ã�� �� �� -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86fc1389540999ea4a3cdaa2a9ca1cc1&libraries=services"></script>
	
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
	
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
     
	<script type="text/javascript">
		
		function fncKakaoPay() {
			var IMP = window.IMP; 
		    IMP.init('imp91244665'); 
		    IMP.request_pay({
		    	pg : "kakaopay", 
		        pay_method : 'card',
		        merchant_uid : 'merchant_' + new Date().getTime(),
		        name : '����',
		        amount : $('#price').text(),
		        buyer_email : '${user.email}',
		        buyer_name : '${user.userName}',
		        buyer_tel : '${user.phone}',
		        buyer_addr : '${user.addr}',
		        buyer_postcode : '${user.addr}'
		    }, function(rsp) {
		        if ( rsp.success ) {
		            var msg = '������ �Ϸ�Ǿ����ϴ�.';
		            $("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
		        } else {
		            var msg = '������ �����Ͽ����ϴ�.';
		            rsp.error_msg;
		        }
		    });
		}
	
	
		function fncAddPurchase() {
			if($("input[name='phone2']").val() != "" && $("input[name='phone3']").val() != "") {
				$("input[name='receiverPhone']").val($("select[name='phone1']").val() + "-" + $("input[name='phone2']").val() + "-" + $("input[name='phone3']").val());
			} else {
				$("input[name='receiverPhone']").val("");
			}
			
			if (${empty user}) {
				
				var name = $("input[name='receiverName']").val();
				var phone = $("input[name='receiverPhone']").val();
				var addr = $("input[name='divyAddr']").val();
				
				if(name == null || name.length <1){
					alert("������ �̸��� �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(phone == null || phone.length <1){
					alert("������ ��ȭ��ȣ��  �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(addr == null || addr.length <1){
					alert("������ �ּҴ�  �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
			}
			
			if ($("select[name='paymentOption']").val() == '2') {
				fncKakaoPay();
				return;
			}
			
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
		}
		
		$(function() {
			$("a[href='#']:contains('����')").click(function() {
				fncAddPurchase();
			});
			
			$("a[href='#']:contains('���')").click(function() {
				window.history.back();
			});
			
			$("select[name='phone1']").change(function(){
				$("input[name='phone2']").focus();
			});
			
			$("input[name='divyDate']").datepicker({
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
	       <h3 class=" text-info">��ǰ����</h3>
	       <h5 class="text-muted"><strong class="text-danger">���� ������</strong> �Է����ּ���.</h5>
	    </div>
	
		<form class="form-horizontal">
			<input type="hidden" name="prodNo" value="${product.prodNo}" />
		 
		 	<div class="form-group">
		    	<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">
		    		��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		    	</label>
		    	<div class="col-sm-4">${product.prodNo}</div>
		 	</div>
		  
			<div class="form-group">
			    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">
			    	��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">${product.prodName}</div>
			</div>
			
			<div class="form-group">
			    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">
			    	��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">${product.prodDetail}</div>
			</div>
			
			<div class="form-group">
			    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">
			    	�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">${product.manuDate}</div>
			</div>
			
			<div class="form-group">
			    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">
			    	�� �� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4" id="price">${product.price}</div>
			</div>
			
			<div class="form-group">
			    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">
			    	������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">${product.regDate}</div>
			</div>
			
			<c:choose>
				<c:when test="${!empty user}">
					<div class="form-group">
					    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">
					    	�����ھ��̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					    </label>
					    <div class="col-sm-4">${user.userId}</div>
					    <input type="hidden" name="buyerId" value="${user.userId}" />
						<input type="hidden" name="memberCheck" value="0" />
					</div>
				</c:when>	
				<c:otherwise>
					<input type="hidden" name="memberCheck" value="1" />
				</c:otherwise>
			</c:choose>
			
			<div class="form-group">
			    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">
			    	���Ź�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			    </label>
			    <div class="col-sm-4">
			    	<select class="form-control" name="paymentOption">
						<option value="1" selected="selected">���ݱ���</option>
						<option value="2">�ſ뱸��</option>
					</select>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">
			    	�������̸� 
			    	<c:if test="${empty user}">
						<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>				
					</c:if>
			    </label>
			    <div class="col-sm-4">
			    	<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-2 col-xs-12 control-label">
			    	�����ڿ���ó 
			    	<c:if test="${empty user}">
						<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>				
					</c:if> 
			    </label>
			    <div class="col-sm-2 col-xs-4">
			    	<select class="form-control" id="phone1" name="phone1">
			  			<option value="010" ${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  } >010</option>
						<option value="011" ${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  } >011</option>
						<option value="016" ${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  } >016</option>
						<option value="018" ${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  } >018</option>
						<option value="019" ${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  } >019</option>
					</select>
				</div>
				 <div class="col-sm-2 col-xs-4">
				 	<input type="text" class="form-control" id="phone2" name="phone2" value="${!empty user.phone2 ? user.phone2 : ''}">
				 </div>
				 <div class="col-sm-2 col-xs-4">
				    <input type="text" class="form-control" id="phone3" name="phone3" value="${!empty user.phone3 ? user.phone3 : ''}"  >
				 </div>
				 <input type="hidden" id="receiverPhone" name="receiverPhone"/>
			</div>
			
			<div class="form-group">
			    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">
					�������ּ�
					<c:if test="${empty user}">
						<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>				
					</c:if> 
			    </label>
			    <div class="col-sm-4" id="address">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}" readonly="readonly"/>
			    </div>
			</div>
			
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-12 text-center">
					<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>	
				</div>
			</div>
			
			<div class="form-group">
			    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
			    <div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest"/>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
			    <div class="col-sm-4">
					<input type="text" readonly="readonly" class="form-control" id="divyDate" name="divyDate"/>
			    </div>
			</div>
			
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
			    	<a class="btn btn-primary btn" href="#" role="button">����</a>
			      	<a class="btn btn-default btn" href="#" role="button">���</a>		      
			    </div>
			</div>
		</form>
	</div>
	
	<script>
		var mapContainer = document.getElementById('map'),
		mapOption = {
			center: new daum.maps.LatLng(37.537187, 127.005476), //������ �߽���ǥ
			level: 5 //������ Ȯ�� ����
		};
		
		//������ �̸� ����
		var map = new daum.maps.Map(mapContainer, mapOption);
		//�ּ�-��ǥ ��ȯ ��ü�� ����
		var geocoder = new daum.maps.services.Geocoder();
		//��Ŀ�� �̸� ����
		var marker = new daum.maps.Marker({
			position: new daum.maps.LatLng(37.537187, 127.005476),
			map: map
		});
		
		$(function(){
			$("#divyAddr").click(function(){
				new daum.Postcode({
					oncomplete: function(data) {
						var addr = data.address; //���� �ּ� ����
			
						//�ּ� ������ �ش� �ʵ忡 �ִ´�.
						$("#divyAddr").val(addr);
						//�ּҷ� �� ������ �˻�
						geocoder.addressSearch(data.address, function(results, status) {
							//���������� �˻��� �Ϸ������,
							if (status === daum.maps.services.Status.OK) {
								var result = results[0]; //ù��° ����� ���� Ȱ��
								
								//�ش� �ּҿ� ���� ��ǥ�� �޾Ƽ�
								var coords = new daum.maps.LatLng(result.y, result.x);
								//������ �����ش�.
								mapContainer.style.display = "block";
								map.relayout();
								//���� �߽��� �����Ѵ�.
								map.setCenter(coords);
								//��Ŀ�� ��������� ���� ��ġ�� �ű��.
								marker.setPosition(coords);
							}
						});
					}
				}).open();
			});
		});
	</script>
</body>
</html>