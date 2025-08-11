<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cart.css">
</head>
<body>

  <c:if test="${order == null}">
      <script>
          alert("주문 정보가 없습니다.");
          window.location.href = "${pageContext.request.contextPath}/admin/adminorderlist";
      </script>
  </c:if>

  <c:if test="${order != null}">
  <div class="cart-container">
    <h1>주문 상세</h1>

    <div class="cart-header">
        <div>책 제목</div>
        <div>가격</div>
        <div>수량</div>
        <div>합계</div>
    </div>

    <div class="cart-item">
        <div class="item-title">${order.book.title}</div>
        <div><fmt:formatNumber value="${order.book.price}" pattern="#,###" />원</div>
        <div>${order.quantity}</div>
        <div><fmt:formatNumber value="${order.book.price * order.quantity}" pattern="#,###" />원</div>
    </div>

    <div class="cart-summary">
        <div class="cart-total">총 금액: <fmt:formatNumber value="${order.totalPrice}" pattern="#,###" />원</div>
    </div>

    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/admin/adminorderlist" class="continue-shopping">주문 목록으로 돌아가기</a>
    </div>
  </div>
  </c:if>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
