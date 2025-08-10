<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>내 주문 내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberorders.css">
</head>
<body>
    <div class="info-container">
        <h2>📦 내 주문 내역</h2>
        <table border="1" style="width:100%; border-collapse: collapse;">
            <thead>
                <tr>
                    <th>주문번호</th>
                    <th>책 ID</th>
                    <th>수량</th>
                    <th>총 가격</th>
                    <th>주문일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>${o.id}</td>
                        <td>${o.bookId}</td>
                        <td>${o.quantity}</td>
                        <td>${o.totalPrice}</td>
                        <td><fmt:formatDate value="${o.orderDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="${pageContext.request.contextPath}/books" class="btn-back">← 메인으로 돌아가기</a>
    </div>
</body>

</html>