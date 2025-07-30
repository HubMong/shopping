<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>서일 문고 관리자 페이지</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminlist.css?v=1.0">
</head>


<body>

<header>
    <div class="header-container header-top">
        <div class="logo"><div class="logo-text">SEOIL 서일문고</div></div>
        
        <form action="${pageContext.request.contextPath}/admin/books" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="도서를 검색해보세요" value="${searchKeyword}">
            <button type="submit"><i class="fas fa-search"></i></button>
        </form>
        
	    <div class="user-menu">
			<div class="user-menu">
	        	<span class="welcome-text">관리자님</span>
		        <a href="${pageContext.request.contextPath}/admin/addbook" class="auth-button add-button">책 추가</a>
		        <a href="${pageContext.request.contextPath}/member/logout" class="auth-button logout-button">로그아웃</a>
	        </div>
       	</div>
       	
   	</div>
</header>

<div class="menu-container">
    <div class="menu-box">
      <a href="books">📚 책 리스트</a>
    </div>
    
    <div class="menu-box">
      <a href="adminmemberlist">👥 회원 리스트</a>
    </div>
    
    <div class="menu-box">
      <a href="adminorderlist">🧾 주문 리스트</a>
    </div>
</div>

<table>
  <thead>
    <tr>
      <th>주문 번호</th>
      <th>책 아이디</th>
      <th>회원 아이디</th>
      <th>수량</th>
      <th>결제 금액</th>
      <th>결제 일시</th>
      <th>비고</th>
    </tr>
  </thead>
  
  <tbody>
    <c:forEach var="order" items="${orders}">
      <tr>
        <td>${order.id}</td>
        <td>${order.bookId}</td>
        <td>${order.memberId}</td>
        <td>${order.quantity}</td>
        <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> 원</td>
        <td>>${order.orderDate}</td>
        <td>
          <form action="order/detail?memberId=${order.memberId}" method="get" style="display:inline;">
            <input type="hidden" name="memberId" value="${order.memberId}" />
            <button type="submit" class="action-btn detail-btn">상세보기</button>
          </form>
          
          <form action="order/edit?memberId=${order.memberId}" method="get" style="display:inline;">
            <input type="hidden" name="memberId" value="${order.memberId}" />
            <button type="submit" class="action-btn edit-btn">수정</button>
          </form>
          
          <form action="adminorderlist/delete?memberId=${book.memberId}" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
            <input type="hidden" name="memberId" value="${order.memberId}" />
            <button type="submit" class="action-btn delete-btn">삭제</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
