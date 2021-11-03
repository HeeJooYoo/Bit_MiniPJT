<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<head>
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
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <style>
	  body {
            padding-top : 50px;
        }
  </style>
<%--   
  <c:choose>
  	<c:when test="${param.menu == 'manage'}">
		<title>��ǰ ����</title>
	</c:when>
	<c:otherwise>
		<title>��ǰ �����ȸ</title>
	</c:otherwise>
  </c:choose> --%>

<script type="text/javascript">

   function searchEnterkey() {
	  if (window.event.keyCode == 13) {
		  fncGetProductList(1);
      }
   }

   function fncGetProductList(currentPage) {
	  /* document.getElementById("currentPage").value = currentPage;
      document.detailForm.submit(); */
      console.log(currentPage);
      $("#currentPage").val(currentPage);
      $("form").attr("action","/product/listProduct?menu=${param.menu}").attr("method", "POST").submit();
   }
   
   $(function() {
	   $("input[name='searchKeyword']").keyup(function() {
		   searchEnterkey();
	   });
	   
	   $("#search").click(function(){
		   fncGetProductList('1');
	   });
	   
	   $("#orderName").click(function(){
		   self.location="/product/listProduct?menu=${param.menu}&searchOrder=1";
	   });
	   
	   $("#orderPrice1").click(function(){
		   self.location="/product/listProduct?menu=${param.menu}&searchOrder=2";
	   });
	   
	   $("#orderPrice2").click(function(){
		   self.location="/product/listProduct?menu=${param.menu}&searchOrder=3";
	   });
	   
	   $("td:nth-child(2)").click(function(){
		   console.log("ddd");
		   var prodNo = $(this).find("#h_prodNo").val();
		   var tranCode = $(this).find("#h_tranCode").val();
		   self.location="/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}&tranCode="+tranCode; 
	   });
	   
	   $("#div").click(function(){
		   alert($("#div").val()); 
		   self.location="/purchase/updateTranCodeByProd?prodNo="+$("#div").val()+"&tranCode=2"
	   });
	   
	   $("input[name='searchKeyword']").autocomplete({
	     source: function(request, response) {
	    	 		$.ajax({
	    	 			url:"/product/json/getProductKeyword",
		    	  		method : "GET",
						dataType : "json",
						contentType: 'application/x-www-form-urlencoded; charset=MS949',
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : {
							"keyWord" : encodeURI($("input[name='searchKeyword']").val())
						},
						success : function(data, status) {
							//alert(status);
							//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
							
							//alert(data);
							response(data);   //response
						}
		      		});
	     		}
	   });
	});
    
    var count = 2;
    window.onscroll = function() {
    	if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
    		$("#currentPage").val(count);
    		$.ajax(
    			{
    				url : "/product/json/listProduct",
    				type : "POST",
    				dataType : "json",
					data : {
						searchCondition : $("select[name='searchCondition']").val(),
						searchOrder : $("#searchOrder").val(),
						searchKeyword : $("#searchKeyword").val(),
						currentPage : $("#currentPage").val()
					},
    				success : function(data) {
    					/* alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
    					console.log(JSON.stringify(data));
    					alert(data.totalCount);
    					alert(data.list); */
    					count++;
    					var append_nod = "";
    					$.each(data.list, function(index, item){ 
    						console.log(item);
    						
    						append_nod += "<div class='col-xs-6 col-md-3'>";
    						append_nod += "<div class='thumbnail'>";    						
    						append_nod += "<img src = '/images/uploadFiles/"+item.fileName+"' />";
    						append_nod += "<div class='caption'>";
    						append_nod += ("<h3>" + item.prodName + "</h3>");
    						append_nod += ("<p>���� : " + item.price + "</p>"); 
    						append_nod += ("<p>����� :" + item.regDate + "</p>");
    						append_nod += "<p><a href='/product/getProduct?menu=search&prodNo="+item.prodNo+"&tranCode="+item.proTranCode+ "' class='btn btn-primary' role='button'>�󼼺���</a></p>";
    						append_nod += "</div>";
    						append_nod += "</div>";
    						append_nod += "</div>";
    					});
    					$('#prod').append(append_nod);
					},
					error:function(request,status,error){
				       console.log("����");
				    }

    			}); 
    	}
    }
</script>

</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	<div class="container">
    
		<div class="page-header text-info">
	       
	       <c:choose>
	       		<c:when test="${param.menu == 'manage'}">
	       			<h3>��ǰ ����</h3>                  		
	       		</c:when>
	       		<c:otherwise>
	       			<h3>��ǰ �����ȸ</h3>
	       		</c:otherwise>
	       	</c:choose>
	    </div>
		
		 <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
				<div class="form-group">
					<select class="form-control" name="searchCondition" >
						<c:if test="${!empty user && user.userId == 'admin'}">
		                	<option value="0" ${search.searchCondition == '0' ? 'selected' : ''}>��ǰ��ȣ</option>             
		                </c:if>
		                <option value="1" ${search.searchCondition == '1' ? 'selected' : ''}>��ǰ��</option>
		            	<option value="2" ${search.searchCondition == '2' ? 'selected' : ''}>��ǰ����</option>
				  	</select>
				</div>
				  
				<div class="form-group">
				   <label class="sr-only" for="searchKeyword">�˻���</label>
				   <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				</div>
				  
				<button id="search" type="button" class="btn btn-default">�˻�</button>
				  
				<!-- PageNavigation ���� ������ ���� ������ �κ� -->
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
	    		
	    		<c:if test="${param.menu != 'manage'}">
	    		<br/><br/>
	    	 	<div class="form-group">
			        <input type="hidden" id="searchOrder" name="searchOrder" value="${searchOrder}"/>
				 	<span id="orderName">��ǰ��</span> | 
				 	<span id="orderPrice1">��������</span> | 
				 	<span id="orderPrice2">��������</span>
		        </div>
		        <br/>
		     </c:if>
	    		
	    		</form>
	    	</div>
		</div>
		
		<c:choose>
			<c:when test="${param.menu == 'manage'}">
				<table class="table table-hover table-striped" >
	      
		        <thead>
		          <tr>
		            <th align="center">No</th>
		            <th align="left" >��ǰ��</th>
		            <th align="left">����</th>
		            <th align="left">�����</th>
		            <th align="left">�������</th>
		          </tr>
		        </thead>
		       
				<tbody>
				  <c:set var="i" value="0" />
				  <c:forEach var="product" items= "${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
					  <td align="center">${ i }</td>
					  <td align="left">
					  	 <input type="hidden" id="h_prodNo" value="${product.prodNo}"/>
				       	 <input type="hidden" id="h_tranCode" value="${product.proTranCode}"/>
			           	 ${product.prodName}
			          </td>
					  <td align="left">${product.price}</td>
					  <td align="left">${product.regDate}</td>
					  <c:choose>
			               		<c:when test="${empty product.proTranCode}">
			               			<td align="left">�Ǹ���</td>
			               		</c:when>
			               		<c:otherwise>
			               			<c:choose>
			               				<c:when test="${user.role == 'admin'}">
			               					<c:if test="${product.proTranCode == '1'}">
			               						<c:choose>
			               							<c:when test="${param.menu == 'manage'}">
			               								<td align="left">���ſϷ�
			               									<button id="div" value="${product.prodNo}">����ϱ�</button>
			               								</td>
			               							</c:when>
			               							<c:otherwise>
			               								<td align="left">���ſϷ�</td>
			               							</c:otherwise>
			               						</c:choose>
						               		</c:if>
						               		<c:if test="${product.proTranCode == '2'}">
						               			<td align="left">�����</td>
						               		</c:if>
						               		<c:if test="${product.proTranCode == '3'}">
						               			<td align="left">��ۿϷ�</td>
						               		</c:if>
			               				</c:when>
			               				<c:otherwise>
			               					<td align="left">������</td>
			               				</c:otherwise>
			               			</c:choose>
			               		</c:otherwise>
			               </c:choose>
					</tr>
		          </c:forEach>
		        
		        </tbody>
		      
		      </table>
		
		      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
		          <tr>
		              <td align="center">
		                 <input type="hidden" id="currentPage" name="currentPage" value=""/>
						 <jsp:include page="../common/pageNavigator.jsp">
						 	<jsp:param value="fncGetProductList" name="page"/>
						 </jsp:include>
		              </td>
		          </tr>
		      </table>
		      <!--  ������ Navigator �� -->
			</c:when>
			<c:otherwise>
				<div class="container">
				<div class="row" id="prod">
					<c:set var="i" value="0" />
				  	<c:forEach var="product" items= "${list}">
						<c:set var="i" value="${ i+1 }" />
							<div class="col-xs-6 col-md-3">
						    	<div class="thumbnail">
						    	  <c:choose>
						    	  	<c:when test="${product.fileName=='empty.GIF'}">
						    	  		<img src = "/images/notFile.png"/>
						    	  	</c:when>
						    	  	<c:otherwise>
						    	  		<img src = "/images/uploadFiles/${product.fileName}"/>
						    	  	</c:otherwise>
						    	  </c:choose>
							      <div class="caption">
							        <h3>${product.prodName}</h3>
							        <p>���� : ${product.price}</p>
							        <p>����� : ${product.regDate}</p>
							        <p>
							        	<a href="/product/getProduct?menu=search&prodNo=${product.prodNo}&tranCode=${product.proTranCode}" class="btn btn-primary" role="button">�󼼺���</a>
							        </p>
							      </div>
							    </div>
							</div>
					</c:forEach>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
   </div>
</body>
</html>