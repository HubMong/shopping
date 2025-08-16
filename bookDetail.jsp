<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>책 상세페이지</title>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/bookDetail.css?v=20250815">
</head>
<body>
<c:if test="${book == null}">
    <script>
        alert("찾으시는 책 정보가 없습니다.");
        window.location.href = "${pageContext.request.contextPath}/books";
    </script>
</c:if>

<c:if test="${book != null}">
    <!-- 전체 중앙 정렬 wrapper -->
    <div class="page-wrapper">

        <!-- 책 상세 영역 -->
        <div class="book-container">
            <div class="cover">
                <img src="${pageContext.request.contextPath}/resources/images/${book.image}" 
                     alt="${book.title}" 
                     onerror="this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg'; this.onerror=null;">
            </div>

            <div class="info">
                <h1>${book.title}</h1>
                <p class="author">저자: ${book.author}</p>
                <p class="price"><fmt:formatNumber value="${book.price}" pattern="#,###" />원</p>
                <p class="description">${book.description}</p>

                <div class="buttons">
                    <form action="${pageContext.request.contextPath}/cart/add" method="post">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <button type="submit" class="add-to-cart">장바구니</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/orders/buyNow" method="post">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="buy-now">바로 구매</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- 리뷰 작성 + 목록 -->
        <div class="review-wrapper">

            <!-- 리뷰 작성 -->
            <div class="review-section">
                <h3>리뷰 작성</h3>
                <form method="post" action="${pageContext.request.contextPath}/books/${book.id}/review">
                    <input type="text" name="reviewer" placeholder="이름" required>
                    <select name="score" required>
                        <option value="5">★★★★★</option>
                        <option value="4">★★★★☆</option>
                        <option value="3">★★★☆☆</option>
                        <option value="2">★★☆☆☆</option>
                        <option value="1">★☆☆☆☆</option>
                    </select>
                    <textarea name="content" placeholder="리뷰를 작성하세요" required></textarea>
                    <button type="submit">등록</button>
                </form>
            </div>

            <!-- 리뷰 목록 -->
            <div class="review-section">
                <h3>리뷰</h3>
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
                            <strong>${rev.memberName}</strong>
                            <p>${rev.content}</p>
                            <span class="review-date">
                                <fmt:formatDate value="${rev.wroteOn}" pattern="yyyy-MM-dd HH:mm" />
                            </span>
                            <form action="${pageContext.request.contextPath}/books/${book.id}/review/${rev.id}/delete" method="post">
                                <button type="submit" class="delete-btn">삭제</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div>

        <!-- 목록으로 버튼 -->
        <a href="${pageContext.request.contextPath}/books" class="back-button">목록으로</a>

    </div>
</c:if>

<!-- 메시지 알림 -->
<c:if test="${not empty successMsg}">
    <script>alert("${successMsg}");</script>
</c:if>
</body>
</html>
