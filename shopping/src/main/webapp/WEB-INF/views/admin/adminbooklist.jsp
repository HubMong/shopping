<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        <input type="text" name="keyword" placeholder="도서 검색" value="${keyword}">
        <button type="submit"><i class="fas fa-search"></i></button>
      </form>
      
      <div class="user-menu">
        <span class="welcome-text">관리자님</span>
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
        <th>도서 ID</th>
        <th>제목</th>
        <th>저자</th>
        <th>가격</th>
        <th>재고</th>
        <th>비고</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="book" items="${books}">
        <tr>
          <td>${book.id}</td>
          <td>${book.title}</td>
          <td>${book.author}</td>
          <td><fmt:formatNumber value="${book.price}" type="number" pattern="#,###" /> 원</td>
          <td>${book.stock}</td>
          <td>
            <!-- 책 상세보기만 남기기 -->
            <a class="action-btn detail-btn btn btn-success" href="<c:url value='/admin/books/detail'><c:param name='id' value='${book.id}'/></c:url>">
              책 상세보기
            </a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
