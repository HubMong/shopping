<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>베스트셀러 Top 5 - SEOIL 서일문고</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css">
  <style>
    /* 히어로 (#1) 강조 */
    .best-hero{display:grid;grid-template-columns:280px 1fr;gap:24px;align-items:center;background:#fff;
      border-radius:14px;box-shadow:0 8px 24px rgba(0,0,0,.06);padding:20px;position:relative;margin-bottom:28px}
    .best-hero .badge{position:absolute;top:-10px;left:-10px;background:linear-gradient(135deg,#ff6b6b,#ff8e53);
      color:#fff;font-weight:700;border-radius:12px;padding:8px 14px;box-shadow:0 6px 18px rgba(255,107,107,.35)}
    .best-hero .cover{border-radius:12px;overflow:hidden;background:#f8f8f8}
    .best-hero .cover img{width:100%;height:auto;display:block}
    .best-hero h2{margin:0 0 8px;font-size:28px;line-height:1.25}
    .best-hero .author{color:#666;margin-bottom:10px}
    .best-hero .meta{display:flex;gap:16px;align-items:center;margin-top:12px}
    .best-hero .price{font-size:20px;font-weight:700}
    .best-hero .sales{font-size:14px;color:#888}
    .best-hero .cta{margin-top:14px;display:flex;gap:10px}
    .best-hero .cta a{display:inline-flex;align-items:center;gap:8px;padding:10px 14px;border-radius:10px;
      text-decoration:none}
    .best-hero .cta .detail{background:#111;color:#fff}
    .best-hero .cta .cart{background:#f1f1f1;color:#222}

    /* 랭크 배지 */
    .rank-badge{position:absolute;top:10px;left:10px;background:linear-gradient(135deg,#ff6b6b,#ff8e53);color:#fff;font-weight:700;border-radius:10px;
      padding:6px 10px;font-size:12px;box-shadow:0 4px 12px rgba(0,0,0,.15)}

    /* 그리드 (#2~#5) */
    .bests-grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:18px}
    .bests-card{position:relative;background:#fff;border-radius:12px;box-shadow:0 6px 18px rgba(0,0,0,.05);
      overflow:hidden;transition:transform .15s ease, box-shadow .15s ease}
    .bests-card:hover{transform:translateY(-3px);box-shadow:0 10px 26px rgba(0,0,0,.08)}
    .bests-card .thumb{aspect-ratio:3/4;display:block;background:#f6f6f6}
    .bests-card .thumb img{width:100%;height:100%;object-fit:cover;display:block}
    .bests-card .info{padding:12px}
    .bests-card .title{font-weight:700;height:44px;overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical}
    .bests-card .author{color:#666;margin:6px 0 8px}
    .bests-card .foot{display:flex;justify-content:space-between;align-items:center}
    .bests-card .price{font-weight:800}
    .bests-card .sales{color:#999;font-size:12px}

    /* 페이지 타이틀 */
    .page-title{display:flex;align-items:center;gap:12px;margin:18px 0}
    .page-title h1{margin:0;font-size:24px}
    .page-title .sub{color:#888}

    @media (max-width:1100px){.bests-grid{grid-template-columns:repeat(3,1fr)}}
    @media (max-width:820px){.best-hero{grid-template-columns:1fr}.bests-grid{grid-template-columns:repeat(2,1fr)}}
    @media (max-width:560px){.bests-grid{grid-template-columns:1fr}}
  </style>
</head>

<body>
<div class="top-banner">서일 문고에 오신 것을 환영합니다.</div>

<header>
  <div class="header-container header-top">
    <div class="logo">
      <div class="logo-text" onclick="location.href='${pageContext.request.contextPath}/books'">SEOIL 서일문고</div>
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
          <a href="${pageContext.request.contextPath}/cart" class="auth-button cart-button">장바구니</a>
          <a href="${pageContext.request.contextPath}/member/logout" class="auth-button logout-button">로그아웃</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>

<nav class="main-nav">
  <div class="nav-container">
    <ul class="category-menu">
      <li><a href="${pageContext.request.contextPath}/books">도서</a></li>
      <li class="active"><a href="${pageContext.request.contextPath}/bestsellers">베스트셀러</a></li>
      <li><a href="${pageContext.request.contextPath}/recommended">추천 도서</a></li>
      <c:if test="${sessionScope.loginUser.role == 'ADMIN'}">
        <li class="admin-menu">
          <a href="#">관리자 페이지 ▼</a>
          <div class="mega-menu">
            <div class="mega-menu-column">
              <a href="/admin/books">📚 도서 관리</a>
              <a href="/admin/adminmemberlist">👤 회원 관리</a>
              <a href="/admin/adminorderlist">🛒 주문 관리</a>
            </div>
          </div>
        </li>
      </c:if>
    </ul>
    <div class="right-menu">
      <a href="#">회원혜택</a>
      <a href="${pageContext.request.contextPath}/member/info">회원정보</a>
      <a href="${pageContext.request.contextPath}/orders/member/orderlist">주문배송</a>
      <a href="${pageContext.request.contextPath}/faq">고객센터</a>
    </div>
  </div>
</nav>

<main class="content">
  <div class="page-title">
    <h1>베스트셀러 Top 5</h1>
    <span class="sub">누적 판매량 기준</span>
  </div>

  <!-- 데이터 없을 때 -->
  <c:if test="${empty bestsellers}">
    <p>베스트셀러 데이터가 없습니다.</p>
  </c:if>

  <!-- BEST 1 (히어로) -->
  <c:if test="${not empty bestsellers}">
    <c:forEach var="b" items="${bestsellers}" varStatus="st">
      <c:if test="${st.index == 0}">
        <div class="best-hero">
          <div class="badge">서일문고 Best 1</div>
          <div class="cover">
            <a href="${pageContext.request.contextPath}/books/${b.id}">
              <img src="${pageContext.request.contextPath}/resources/images/${b.image}"
                   alt="${b.title}"
                   onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg';">
            </a>
          </div>
          <div class="detail">
            <h2>${b.title}</h2>
            <div class="author">${b.author}</div>
            <div class="meta">
              <div class="price"><fmt:formatNumber value="${b.price}" pattern="#,###"/>원</div>
              <div class="sales">누적 판매량: <strong><fmt:formatNumber value="${b.salesVolume}" pattern="#,###"/></strong> 권</div>
            </div>
            <div class="cta">
              <a class="detail" href="${pageContext.request.contextPath}/books/${b.id}">
                <i class="fas fa-book-open"></i> 상세보기
              </a>
            </div>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </c:if>

  <!-- BEST 2 ~ 5 -->
  <c:if test="${not empty bestsellers}">
    <div class="bests-grid">
      <c:forEach var="b" items="${bestsellers}" varStatus="st">
        <c:if test="${st.index > 0 && st.index < 5}">
          <div class="bests-card">
            <div class="rank-badge">Best ${st.index + 1}</div>
            <a href="${pageContext.request.contextPath}/books/${b.id}" class="thumb">
              <img src="${pageContext.request.contextPath}/resources/images/${b.image}"
                   alt="${b.title}"
                   onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg';">
            </a>
            <div class="info">
              <div class="title">${b.title}</div>
              <div class="author">${b.author}</div>
              <div class="foot">
                <div class="price"><fmt:formatNumber value="${b.price}" pattern="#,###"/>원</div>
                <div class="sales"><fmt:formatNumber value="${b.salesVolume}" pattern="#,###"/>권</div>
              </div>
            </div>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </c:if>
</main>

<footer class="site-footer">
  <div class="footer-container">
    <p>회사명: 서일문고 | 주소: 서울특별시 면목역 | 전화: 02-1234-1234</p>
    <p>© 2025 SEOIL 문고.</p>
  </div>
</footer>

</body>
</html>
