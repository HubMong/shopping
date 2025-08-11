<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>회원 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/info.css">
</head>
<body>
<div class="info-container">
    <h2>${member.name}님의 회원 정보</h2>
    <ul>
        <li><strong>아이디:</strong> ${member.userId}</li>
        <li><strong>이 름:</strong> ${member.name}</li>
        <li><strong>주 소:</strong> ${member.address}</li>
    </ul>

    <div class="purchase-section">
        <h3>구매한 상품 목록</h3>
        <c:choose>
            <c:when test="${empty orders}">
                <p>구매한 내역이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="order" items="${orders}">
                    <div class="order-item">
                        <h4>구매 ID: ${order.id} (구매일: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>)</h4>
                        <ul>
                            <li>책 ID: ${order.bookId} - 수량: ${order.quantity}개 - <fmt:formatNumber value="${order.totalPrice}" pattern="#,###" />원</li>
                        </ul>
                        <p>단일 구매 금액: <fmt:formatNumber value="${order.totalPrice}" pattern="#,###" />원</p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${pageContext.request.contextPath}/books" class="btn-back">← 메인으로 돌아가기</a>
</div>
</body>
</html>