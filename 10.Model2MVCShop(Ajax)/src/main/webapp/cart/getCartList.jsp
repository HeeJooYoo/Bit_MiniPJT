<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Insert title here</title>
<script type="text/javascript">

	function funDeleteCart(prodNo) {
		if (confirm("�����Ͻ� ��ǰ�� �����Ͻðڽ��ϱ�?")) {			
			location.href="/cart/deleteCart?userId=${user.userId}&prodNo="+prodNo;
		}
	}
	
</script>
</head>

<body>

${user.userName}���� ��ٱ���( ${totalCount} )

<c:forEach var="cart" items="${cart}">
	<table border=1>
		<tr>
			<td>��ǰ�̸�</td>
			<td>${cart.cartProduct.prodName}</td>
			<td>
				<button onclick="funDeleteCart(${cart.cartProduct.prodNo})">
				X
				</button>
		</tr>
		<tr>
			<td>��ǰ����</td>
			<td>
				<img src = "/images/uploadFiles/${cart.cartProduct.fileName}"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td>��ǰ����</td>
			<td>${cart.cartProduct.price}</td>
			<td></td>
		</tr>
		<tr>
			<td>��ǰ����</td>
			<td>${cart.amount}</td>
			<td></td>
		</tr>
	</table>
</c:forEach>

</body>
</html>