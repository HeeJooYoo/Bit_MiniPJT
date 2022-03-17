<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	          <!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	          <ul class="nav navbar-nav">
	        		    
	              <!--  ȸ������ DrowDown -->
	              <c:if test="${!empty user}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >ȸ������</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">����������ȸ</a></li>
		                         <c:if test="${sessionScope.user.role == 'admin'}">
		                         	<li class="divider"></li>
		                         	<li><a href="#">ȸ��������ȸ</a></li>
		                         </c:if>
		                     </ul>
		                 </li>
	              </c:if>  
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	             <li class="dropdown">
	             	<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                	<span >��ǰ����</span>
	                    <span class="caret"></span>
	                </a>
	                <ul class="dropdown-menu">
	                	<li><a href="#">�� ǰ �� ��</a></li>
	                    <li class="divider"></li>
	                    <c:if test="${sessionScope.user.role == 'user'}">
	                    	<li><a href="#">�����̷���ȸ</a></li>
	                        <li class="divider"></li>
	                    </c:if>
	                    <c:if test="${empty user}">
	                    	<li><a href="#">��ȸ��������ȸ</a></li>
	                        <li class="divider"></li>
	                    </c:if>
	                        <li><a href="#">�ֱٺ���ǰ</a></li>
	                </ul>
	             </li>
	          </ul>
	          
	          <ul class="nav navbar-nav navbar-right">
		          <c:choose>
		          	<c:when test="${!empty user}">
		          		<c:if test="${user.role == 'user'}">
		          			<li><a href="#">��ٱ���</a></li>
		          		</c:if>
			        	<li><a href="#">�α׾ƿ�</a></li>
		          	</c:when>
		          	<c:otherwise>
			        	<li><a href="#">�α���</a></li>
		          	</c:otherwise>
		          </c:choose>
	          </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
		//============= logout Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
			
		 	$("a:contains('�α���')").on("click" , function() {
				$(self.location).attr("href","/user/login");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= ȸ��������ȸ Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  ����������ȸȸ Event  ó�� =============	
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
		
		//============= ��ǰ Event ó�� ===============
		$(function() {
			$("a:contains('�ǸŻ�ǰ���')").click(function() {
				$(self.location).attr("href","../product/addProductView.jsp");
			});
			
			$("a:contains('�ǸŻ�ǰ����')").click(function() {
				$(self.location).attr("href","/product/listProduct?menu=manage");
			});
			
			$("a:contains('�� ǰ �� ��')").click(function() {
				$(self.location).attr("href","/product/listProduct?menu=search");
			});
			
			$("a[href='#']:contains('��ȸ��������ȸ')").on("click" , function() {
				self.location = "../guest.jsp"
			});
			
			$("a[href='#']:contains('�����̷���ȸ')").on("click", function(){
				self.location = "/purchase/listPurchase";
			});
			
			$("a:contains('��ٱ���')").click(function() {
				location.href="/cart/getCartList?userId=${user.userId}";
			});
		});
		
	</script>  