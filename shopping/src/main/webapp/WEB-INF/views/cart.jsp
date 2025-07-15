<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>장바구니</title>
    <style>
        body { font-family: 'Arial'; margin: 20px; }
        .step { display: flex; margin-bottom: 20px; }
        .step div { padding: 10px 20px; border-radius: 20px; margin-right: 10px; }
        .active-step { background: green; color: white; }
        .cart-box { display: flex; border-top: 2px solid black; padding-top: 10px; }
        .cart-list { flex: 3; }
        .cart-item { display: flex; align-items: center; border-bottom: 1px solid #ccc; padding: 10px; }
        .cart-item img { width: 100px; height: auto; margin-right: 20px; }
        .item-info { flex-grow: 1; }
        .item-info h4 { margin: 0 0 10px; }
        .item-price { font-weight: bold; }
        .cart-summary { flex: 1; margin-left: 20px; border: 1px solid #ccc; padding: 20px; height: fit-content; }
        .btn-order { margin-top: 20px; width: 100%; padding: 10px; background: purple; color: white; border: none; font-size: 16px; }
    </style>
</head>
<body>

<div class="step">
    <div class="active-step">1. 장바구니</div>
    <div>2. 주문/결제</div>
    <div>3	. 주문완료</div>
</div>

<div class="cart-box">
    <div class="cart-list">
        <c:if test="${empty cart}">
            <p>장바구니에 담긴 상품이 없습니다.</p>
        </c:if>

        <c:forEach var="item" items="${cart}">
            <div class="cart-item">
                <input type="checkbox" checked />
                <img src="/img/sample-book.jpg" alt="썸네일">
                <div class="item-info">
                    <h4>[국내도서] ${item.title}</h4>
                    <div>단가: <span class="item-price">${item.price}원</span></div>
                    <div>수량: ${item.quantity}</div>
                    <div>총합: <b>${item.price * item.quantity}원</b></div>
                    <div>내일 도착 · 바로드림 가능</div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="cart-summary">
        <div>상품 금액: <b>${total}원</b></div>
        <div>상품 할인: <b style="color: blue;">-${discount}원</b></div>
        <div>배송비: <b>0원</b></div>
        <hr>
        <div>결제 예정 금액: <b style="font-size: 20px;">${finalTotal}원</b></div>
        <div>적립 예정 포인트: <b>${discount}P</b></div>
        <form action="/order" method="post">
            <button type="submit" class="btn-order">주문하기 (${cart.size()})</button>
        </form>
    </div>
</div>

</body>
</html>




















https://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccidenthttps://uwuowo.mathi.moe/character/CE/Lilaccident