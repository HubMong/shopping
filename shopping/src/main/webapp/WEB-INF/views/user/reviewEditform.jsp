<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>책 상세페이지</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bookDetail.css">
</head>
<body>
	<a href="${pageContext.request.contextPath}/books" class="back-button-fixed">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
    </a>
    
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
      <p class="author">저자 : ${book.author}</p>
      <p class="price"><fmt:formatNumber value="${book.price}" pattern="#,###" />원</p>
      
	  <div class="rating-section">
		<span class="stars">
		    <c:forEach begin="1" end="${fullStars}">★</c:forEach>
		    <c:if test="${halfStar}">⯨</c:if> <%-- 반쪽별 (원하면 다른 문자/아이콘) --%>
		    <c:forEach begin="1" end="${emptyStars}">☆</c:forEach>
		</span>
	    <span class="rating-text">
	        (<fmt:formatNumber value="${reviewAverage}" pattern="0.0" />) 리뷰 ${reviewCount}개
	    </span>
	  </div>
     
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
  
  <div class="book-description">
	  <h2>책 내용</h2>
	  <p class="description">${book.description}</p>
  </div>
 
<div class="review-container">
  <div>
  	<h2>리뷰(${reviewCount})</h2>
  </div>
	
<c:if test="${not empty loginUser}">
  <div class="review-form">
      <form action="${pageContext.request.contextPath}/review/add" method="post">
	  	  <input type="hidden" name="id" value="${book.id}">
          <div class="form-group">
			  <label>별점</label>
			  <div class="star-rating">
			      <span data-value="1"></span>
			      <span data-value="2"></span>
			      <span data-value="3"></span>
			      <span data-value="4"></span>
			      <span data-value="5"></span>
			  </div>
			  <input type="hidden" name="rating" id="rating-value" required>
		  </div>
          <div class="form-group">
              <textarea name="content" placeholder="리뷰를 작성하세요(100자 내외)" rows="3" required></textarea>
          </div>
          <div class="form-group btn-right">
          	<button type="submit" class="btn-submit">등록</button>
          </div>
      </form>
  </div>
</c:if>
 
<div class="review-list">
  <c:forEach var="review" items="${reviewList}">
  <div class="review-item" id="review-${review.id}">
    <div class="review-header">
        <div class="review-stars">
            <c:forEach begin="1" end="${review.score}">★</c:forEach>
            <c:forEach begin="1" end="${5 - review.score}">☆</c:forEach>
        </div>

        <c:if test="${not empty loginUser and loginUser.id == review.member.id}">
            <div class="review-actions">
                <form action="${pageContext.request.contextPath}/review/edit" method="get" style="display:inline;"> 
	                <input type="hidden" name="bookId" value="${book.id}"> 
	                <input type="hidden" name="id" value="${review.id}"> 
	                <button type="submit" class="btn-edit">수정</button> 
                </form>
                
                <form action="${pageContext.request.contextPath}/review/delete" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="id" value="${review.id}">
                    <button type="submit" class="btn-delete">삭제</button>
                </form>
            </div>
        </c:if>
    </div>

	<div class="review-content">${review.content}</div>
	    <div class="review-meta">
	        ${review.member.name} | <fmt:formatDate value="${review.wroteOn}" pattern="yyyy-MM-dd HH:mm"/>
	    </div>
	</div>
  </c:forEach>
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

<script>
document.addEventListener('DOMContentLoaded', function() {
    const stars = document.querySelectorAll('.star-rating span');
    const ratingInput = document.getElementById('rating-value');

    stars.forEach(star => {
        star.addEventListener('mouseover', function() {
            const value = parseInt(this.getAttribute('data-value'));
            highlightStars(value);
        });
        star.addEventListener('mouseout', function() {
            const value = parseInt(ratingInput.value) || 0;
            highlightStars(value);
        });
        star.addEventListener('click', function() {
            const value = parseInt(this.getAttribute('data-value'));
            ratingInput.value = value;
            highlightStars(value);
        });
    });

    function highlightStars(value) {
        stars.forEach(star => {
            if (parseInt(star.getAttribute('data-value')) <= value) {
                star.classList.add('filled');
            } else {
                star.classList.remove('filled');
            }
        });
    }
});

</script>

<c:if test="${not empty scrollToReviewId}">
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const el = document.getElementById("review-${scrollToReviewId}");
	    if (el) {
	        el.scrollIntoView({ behavior: "smooth", block: "center" });
	    }
	});
	</script>
</c:if>

</body>
</html>