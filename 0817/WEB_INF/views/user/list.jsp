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
    <div class="top-banner">서일 문고에 오신 것을 환영합니다.</div>

    <header>
        <div class="header-container header-top">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/books" class="logo-text">SEOIL 서일문고</a>
            </div>
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
                        <a href="${pageContext.request.contextPath}/member/info" class="welcome-text">안녕하세요, ${sessionScope.loginUser.name}님!</a>
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
                <li class="active"><a href="#">도서</a></li>
                <li><a href="#">베스트셀러</a></li>
                <li><a href="#">신간</a></li>
                <li><a href="#">이벤트</a></li>
            </ul>
            <div class="right-menu">
                <a href="#">회원혜택</a>
                <a href="${pageContext.request.contextPath}/member/info">회원정보</a>
                <a href="${pageContext.request.contextPath}/orders/member/${loginUser.id}">주문내역</a>
                <a href="${pageContext.request.contextPath}/faq">고객센터</a>
            </div>
        </div>
    </nav>

    <main class="content">
        <!-- 광고 영역 -->
        <div class="ad-banner">
            <div class="ad-card active" id="ad1">
                <img src="${pageContext.request.contextPath}/resources/images/book2.jpg" alt="추천 도서">
                <div class="ad-content">
                    <h2>생각의 주도권을 디자인하라</h2>
                    <p>상상하고, 해제하고, 연결하라! 인공지능에 휘둘리지 않는 결정적 사고방식</p>
                </div>
            </div>
            <div class="ad-card" id="ad2">
                <img src="${pageContext.request.contextPath}/resources/images/book3.jpg" alt="추천 도서 2">
                <div class="ad-content">
                    <h2>책 제목 2</h2>
                    <p>책 내용 2</p>
                </div>
            </div>
            <div class="ad-card" id="ad3">
                <img src="${pageContext.request.contextPath}/resources/images/book4.jpg" alt="추천 도서 3">
                <div class="ad-content">
                    <h2>책 제목 3</h2>
                    <p>책 내용 3</p>
                </div>
            </div>
            <button class="ad-prev-btn">&lt;</button>
            <button class="ad-next-btn">&gt;</button>
        </div>

        <div class="section-title">
            <c:choose>
                <c:when test="${not empty searchKeyword}">'${searchKeyword}'에 대한 검색 결과</c:when>
                <c:otherwise>전체 도서 목록</c:otherwise>
            </c:choose>
        </div>

        <div class="book-list">
            <c:forEach var="book" items="${bookList}">
                <div class="book-item">
                    <a href="${pageContext.request.contextPath}/books/${book.id}">
                        <div class="book-card">
                            <img src="${pageContext.request.contextPath}/resources/images/${book.image}" alt="${book.title}" onerror="this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg'; this.onerror=null;">
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
    </main>

    <footer class="site-footer">
        <div class="footer-container">
            <p>회사명: 서일문고 | 주소: 서울특별시 면목역 | 전화: 02-1234-1234</p>
            <p>© 2025 SEOIL 문고.</p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ads = document.querySelectorAll('.ad-card');
            let current = 0;

            const nextBtn = document.querySelector('.ad-next-btn');
            const prevBtn = document.querySelector('.ad-prev-btn');

            nextBtn.addEventListener('click', () => {
                ads[current].classList.remove('active');
                current = (current + 1) % ads.length;
                ads[current].classList.add('active');
            });

            prevBtn.addEventListener('click', () => {
                ads[current].classList.remove('active');
                current = (current - 1 + ads.length) % ads.length;
                ads[current].classList.add('active');
            });
        });
    </script>
</body>
</html>
