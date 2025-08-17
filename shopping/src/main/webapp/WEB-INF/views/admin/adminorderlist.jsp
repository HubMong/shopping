<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>서일 문고 관리자 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adminlist.css?v=1.0">
</head>

<body>

<c:if test="${empty sessionScope.loginUser or not sessionScope.loginUser.role == 'ADMIN'}">
    <c:redirect url="/books"/>
</c:if>
	
	<header>
		<div class="header-container header-top">
			<div class="logo">
				<div class="logo-text">SEOIL 서일문고</div>
			</div>

			<form action="<c:url value='/admin/adminorderlist'/>" method="get"
				class="search-box">
				<input type="text" name="keyword" placeholder="주문번호, 책 제목, 회원이름 검색"
					value="${keyword}">
				<button type="submit">
					<i class="fas fa-search"></i>
				</button>
			</form>

			
			<div class="user-menu">
	        	<a href="${pageContext.request.contextPath}/books" class="auth-button userpage-button">사용자 페이지</a>
		        <a href="${pageContext.request.contextPath}/admin/addbook" class="auth-button add-button">책 추가</a>
		        <a href="${pageContext.request.contextPath}/member/logout" class="auth-button logout-button">로그아웃</a>
	        </div>
       	</div>
	</header>

	<div class="menu-container">
	    <div class="menu-box ${page eq 'books' ? 'active' : ''}">
	        <a href="<c:url value='/admin/books'/>">📚 책 리스트</a>
	    </div>
	    <div class="menu-box ${page eq 'members' ? 'active' : ''}">
	        <a href="<c:url value='/admin/adminmemberlist'/>">👥 회원 리스트</a>
	    </div>
	    <div class="menu-box ${page eq 'orders' ? 'active' : ''}">
	        <a href="<c:url value='/admin/adminorderlist'/>">🧾 주문 리스트</a>
	    </div>
	</div>

<table>
  <thead>
    <tr>
      <th>거래 ID</th>
      <th>책 제목</th>
      <th>회원 이름</th>
      <th>총 결제 금액</th>
      <th>결제 일시</th>
      <th>상세보기</th>
    </tr>
  </thead>

  <tbody>
    <c:forEach var="entry" items="${groupedOrders}">
      <c:set var="firstOrder" value="${entry.value[0]}" />
      <c:set var="firstTitle" value="${firstOrder.book.title}" />
      <c:set var="bookCount" value="${fn:length(entry.value)}" />
      <c:set var="bookSummary" value="${firstTitle}" />

      <c:if test="${bookCount > 1}">
        <c:set var="bookSummary" value="${firstTitle} 외 ${bookCount - 1}권" />
      </c:if>

      <c:choose>
        <c:when test="${fn:length(bookSummary) > 20}">
          <c:set var="bookSummary" value="${fn:substring(bookSummary, 0, 20)}..." />
        </c:when>
      </c:choose>

      <c:set var="totalGroupPrice" value="0" />
      <c:forEach var="order" items="${entry.value}">
        <c:set var="totalGroupPrice" value="${totalGroupPrice + order.totalPrice}" />
      </c:forEach>

      <tr>
        <td>${entry.key}</td>
        <td>${bookSummary}</td>
        <td>${firstOrder.member.name}</td>
        <td><fmt:formatNumber value="${totalGroupPrice}" pattern="#,###" /> 원</td>
        <td><fmt:formatDate value="${firstOrder.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
        <td>
          <form action="${pageContext.request.contextPath}/admin/adminorderlist/detail" method="get" style="display:inline;">
            <input type="hidden" name="transactionId" value="${entry.key}" />
            <button type="submit" class="action-btn edit-btn">상세보기</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	

</body>
</html>
