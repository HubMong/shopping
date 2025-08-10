<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제</title>
<link href="<c:url value='/resources/css/payment.css'/>" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>주문/결제</h1>

        <h2 class="section-title">주문 상품 정보</h2>
        <table class="order-items-table">
            <thead>
                <tr>
                    <th style="width:50%;">상품 정보</th>
                    <th style="width:15%;">수량</th>
                    <th style="width:15%;">상품 금액</th>
                    <th style="width:20%;">합계</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${order.items}">
                    <tr>
                        <td class="item-info">
                            <img src="<c:url value='/resources/images/${item.title}.jpg'/>" alt="${item.title}">
                            <div>
                                <strong>${item.title}</strong><br>
                                <small>${item.author}</small>
                            </div>
                        </td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.price}" type="number" />원</td>
                        <td><fmt:formatNumber value="${item.price * item.quantity}" type="number" />원</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2 class="section-title">주문자 정보</h2>
        <table class="info-table">
            <tr>
                <th>이름</th>
                <td>${loginUser.name}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${loginUser.email}</td>
            </tr>
        </table>

        <h2 class="section-title">배송 정보</h2>
        <table class="info-table">
            <tr>
                <th>받는 분</th>
                <td><input type="text" value="${loginUser.name}" style="width: 200px;"></td>
            </tr>
            <tr>
                <th>주소</th>
                <td><input type="text" value="${loginUser.address}" style="width: 400px;"></td>
            </tr>
             <tr>
                <th>휴대전화</th>
                <td><input type="text" value="${loginUser.hp}" style="width: 200px;"></td>
            </tr>
            <tr>
                <th>배송 요청사항</th>
                <td><input type="text" placeholder="예: 부재 시 경비실에 맡겨주세요." style="width: 400px;"></td>
            </tr>
        </table>

        <div class="payment-summary">
            <div class="summary-box">
                <div class="summary-item">
                    <div class="label">총 상품 금액</div>
                    <div class="value"><fmt:formatNumber value="${order.totalAmount}" type="number" />원</div>
                </div>
                <div class="summary-item">
                    <div class="label">배송비</div>
                    <div class="value">0원</div>
                </div>
                <div class="summary-item final-amount">
                    <div class="label">최종 결제 금액</div>
                    <div class="value"><fmt:formatNumber value="${order.totalAmount}" type="number" />원</div>
                </div>
            </div>
        </div>

        <div class="payment-actions">
            <form action="<c:url value='/order/confirm'/>" method="post">
                <button type="submit" class="btn-payment">결제하기</button>
            </form>
        </div>
    </div>
</body>
</html>
