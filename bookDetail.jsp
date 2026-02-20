<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>책 상세페이지</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bookDetail.css">
</head>
<body>
  <c:if test="${book == null}">
    <script>
      alert("찾으시는 책 정보가 없습니다.");
      window.location.href = "${pageContext.request.contextPath}/books";
    </script>
  </c:if>
  <c:if test="${book != null}">
  <div class="book-container">
    <div class="cover">
      <img src="${pageContext.request.contextPath}/resources/images/${book.image}" alt="${book.title}" onerror="this.src='${pageContext.request.contextPath}/resources/images/default_cover.jpg'; this.onerror=null;"/>
    </div>
    <div class="info">
      <h1>${book.title}</h1>
      <p class="author">저자: ${book.author}</p>
      <p class="price"><fmt:formatNumber value="${book.price}" pattern="#,###" />원</p>
      <p class="description">${book.description}</p>
      <div class="buttons">
        <c:choose>
          <c:when test="${book.stock > 0}">
            <form action="${pageContext.request.contextPath}/cart/add" method="post">
              <input type="hidden" name="bookId" value="${book.id}">
              <button type="submit" class="add-to-cart">장바구니</button>
            </form>
            <form action="${pageContext.request.contextPath}/orders/buyNow" method="post">
                <input type="hidden" name="bookId" value="${book.id}">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="buy-now">바로 구매</button>
            </form>
          </c:when>
          <c:otherwise>
            <button type="button" class="out-of-stock" disabled>품절</button>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
  <a href="${pageContext.request.contextPath}/books" class="back-button">목록으로</a>
  </c:if>
  <script>
    // 이미지 로딩 처리
    document.addEventListener('DOMContentLoaded', function() {
        const contextPath = '${pageContext.request.contextPath}';
        const coverImg = document.querySelector('.cover img');
        if(coverImg) {
            // 이미지에 로딩 클래스 추가
            coverImg.classList.add('loading');
            
            // 이미지 로드 완료 이벤트
            coverImg.onload = function() {
                this.classList.remove('loading');
            };
            
            // 이미지 로드 실패 이벤트 (한 번만 실행되도록 처리)
            coverImg.onerror = function() {
                this.onerror = null; // 재귀 호출 방지
                this.src = contextPath + '/resources/images/default_cover.jpg';
                this.classList.remove('loading');
            };
        }
    });
</script>
<c:if test="${not empty successMsg}">
    <script>
        alert("${successMsg}");
    </script>
</c:if>
</body>
</html>