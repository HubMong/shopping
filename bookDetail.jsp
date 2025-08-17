<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>책 상세페이지</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/bookDetail.css?v=20250817">
</head>
<body>

<c:if test="${book == null}">
    <script>
        alert("찾으시는 책 정보가 없습니다.");
        window.location.href = "${pageContext.request.contextPath}/books";
    </script>
</c:if>

<c:if test="${book != null}">
<div class="page-wrapper">

    <!-- 책 상세 영역 -->
    <div class="book-container">
        <div class="cover">
            <c:choose>
                <c:when test="${not empty book.image}">
                    <img src="${pageContext.request.contextPath}/resources/images/${book.image}" 
                         alt="<c:out value='${book.title}'/>"
                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg'; this.onerror=null;">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/images/default_cover.jpg" alt="기본 이미지">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="info">
            <h1><c:out value="${book.title}"/></h1>
            <p class="author">저자: <c:out value="${book.author}"/></p>
            <p class="price"><fmt:formatNumber value="${book.price}" pattern="#,###"/>원</p>

            <c:if test="${avgScore > 0}">
                <div class="avg-rating">
                    <c:forEach var="i" begin="1" end="5">
                        <c:choose>
                            <c:when test="${i <= avgScore}">★</c:when>
                            <c:otherwise>☆</c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <span class="score-text">(<fmt:formatNumber value="${avgScore}" maxFractionDigits="1"/> / 5)</span>
                </div>
            </c:if>

            <div class="buttons">
                <form action="${pageContext.request.contextPath}/cart/add" method="post">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="add-to-cart">장바구니</button>
                </form>
                <form action="${pageContext.request.contextPath}/orders/buyNow" method="post">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="quantity" value="1">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="buy-now">바로 구매</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 책 소개 -->
    <div class="description-box">
        <h2>책 소개</h2>
        <p>
           <c:out value="${fn:replace(book.description, '&#10;', '<br/>')}" escapeXml="false"/>

        </p>
    </div>

    <!-- 리뷰 작성 + 리뷰 목록 -->
    <div class="review-wrapper">
        <h3>리뷰 (총 ${empty reviews ? 0 : fn:length(reviews)}개)</h3>

        <!-- 리뷰 작성 폼 -->
        <form method="post" action="${pageContext.request.contextPath}/books/${book.id}/review" class="review-form">
            <c:choose>
                <c:when test="${loginMember != null}">
                    <input type="hidden" name="reviewer" value="${loginMember.username}">
                    <span class="login-reviewer">${loginMember.username}</span>
                </c:when>
                <c:otherwise>
                    <input type="text" name="reviewer" placeholder="이름" required>
                </c:otherwise>
            </c:choose>

            <select name="score" required>
                <option value="5">★★★★★</option>
                <option value="4">★★★★☆</option>
                <option value="3">★★★☆☆</option>
                <option value="2">★★☆☆☆</option>
                <option value="1">★☆☆☆☆</option>
            </select>
            <textarea name="content" placeholder="리뷰를 작성하세요" required></textarea>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit">등록</button>
        </form>

        <!-- 리뷰 목록 -->
        <div class="review-list">
            <c:forEach var="rev" items="${reviews}">
                <div class="review-item">
                    <div class="star-rating">
                        <c:forEach var="i" begin="1" end="5">
                            <c:choose>
                                <c:when test="${i <= rev.score}">★</c:when>
                                <c:otherwise>☆</c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <strong><c:out value="${rev.memberName}"/></strong>
                    <p><c:out value="${rev.content}"/></p>
                    <span class="review-date">
                        <fmt:formatDate value="${rev.wroteOn}" pattern="yyyy-MM-dd HH:mm"/>
                    </span>

<c:if test="${loginUser != null and rev.memberId == loginUser.id}">
    <form action="${pageContext.request.contextPath}/books/${book.id}/review/${rev.id}/delete" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit" class="delete-btn">삭제</button>
    </form>
</c:if>

                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 목록으로 버튼 -->
    <a href="${pageContext.request.contextPath}/books" class="back-button">목록으로</a>

    <!-- 알림 메시지 -->
    <c:if test="${not empty successMsg}">
        <div class="alert success">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert error">${errorMsg}</div>
    </c:if>

</div>
</c:if>

</body>
</html>
