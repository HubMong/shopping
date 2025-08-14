<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SEOIL 서일문고</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css">
</head>

<body>

<c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userId == 'admin'}">
    <c:redirect url="/admin/books"/>
</c:if>

<div class="top-banner">서일 문고에 오신 것을 환영합니다.</div>
<header>
    <div class="header-container header-top">
        <div class="logo"><div class="logo-text" onclick="location.href='${pageContext.request.contextPath}/books'">SEOIL 서일문고</div></div>
        <form action="${pageContext.request.contextPath}/books" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="도서를 검색해보세요" value="${searchKeyword}">
            <button type="submit"><i class="fas fa-search"></i></button>
        </form>
        
        <div class="user-menu">
            <c:choose>
                <c:when test="${empty sessionScope.loginUser}">
                    <a href="${pageContext.request.contextPath}/member/registerform" class="auth-button register-button">회원가입</a>
                    <a href="${pageContext.request.contextPath}/member/loginform" class="auth-button login-button">로그인</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/member/info" class="welcome-text"> 안녕하세요, ${sessionScope.loginUser.name}님!</a>
                    <a href="${pageContext.request.contextPath}/cart" class="auth-button register-button">장바구니</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="auth-button login-button">로그아웃</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<nav class="main-nav">
    <div class="nav-container">
        <ul class="category-menu">
            <li><a href="${pageContext.request.contextPath}/books">서일문고</a></li>
            <li class="active"><a href="#">도서</a></li>
            <li><a href="#">베스트셀러</a></li>
            <li><a href="#">신간</a></li>
            <li><a href="#">이벤트</a></li>
        </ul>
        <div class="right-menu">
            <a href="#">회원혜택</a>
            <a href="${pageContext.request.contextPath}/member/info">회원정보</a>
            <a href="${pageContext.request.contextPath}/orders/member/${loginUser.id}">주문배송</a>
            <a href="#">고객센터</a>
        </div>
    </div>
</nav>
<div class="content">
    <div class="section-title">
        <c:choose>
            <c:when test="${not empty searchKeyword}">
                '${searchKeyword}'에 대한 검색 결과
            </c:when>
            <c:otherwise>
                전체 도서 목록
            </c:otherwise>
        </c:choose>
    </div>
    <div class="book-list">
        <c:forEach var="book" items="${bookList}">
            <div class="book-item">
                <a href="${pageContext.request.contextPath}/books/${book.id}">
                    <div class="book-card">
                        <img src="${pageContext.request.contextPath}/resources/images/${book.image}" alt="${book.title}" onerror="this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg'; this.onerror=null;"/>
                        <div class="book-info">
                            <div class="book-title">${book.title}</div>
                            <div class="book-author">${book.author}</div>
                            <div class="book-price"><fmt:formatNumber value="${book.price}" pattern="#,###" />원</div>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    // 이미지 로딩 처리
    document.addEventListener('DOMContentLoaded', function() {
        const contextPath = '${pageContext.request.contextPath}';
        const allImages = document.querySelectorAll('.book-card img');
        allImages.forEach(img => {
            img.classList.add('loading');
            img.onload = function() {
                this.classList.remove('loading');
            };
            img.onerror = function() {
                this.onerror = null;
                this.src = contextPath + '/resources/images/default_cover.jpg';
                this.classList.remove('loading');
            };
        });
    });
</script>
</body>
</html>
