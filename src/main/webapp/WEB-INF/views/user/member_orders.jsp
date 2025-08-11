
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>내 주문 내역</title>
</head>
<body>
<h2>📦 내 주문 내역</h2>
<table border="1">
    <tr>
        <th>주문번호</th>
        <th>책 ID</th>
        <th>수량</th>
        <th>총 가격</th>
        <th>주문일</th>
    </tr>
    <c:forEach var="o" items="${orders}">
        <tr>
            <td>${o.id}</td>
            <td>${o.bookId}</td>
            <td>${o.quantity}</td>
            <td>${o.totalPrice}</td>
            <td>${o.orderDate}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
