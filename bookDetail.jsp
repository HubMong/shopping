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
      <c:if test="${reviewAverage > 0}">
                <div class="avg-rating">
                    <div class="score-text">리뷰 평점: <fmt:formatNumber value="${reviewAverage}"/></div>
                    <c:forEach var="i" begin="1" end="5">
                        <c:choose>
                            <c:when test="${i <= reviewAverage}">★</c:when>
                            <c:otherwise>☆</c:otherwise>
                        </c:choose>
                    </c:forEach>                    
                </div>
            </c:if>
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
  <br>
  <div class="book-description">
  <h2>책의 상세 내용</h2>
  <p class="description">${book.description}</p>
  </div>
  
  
  <br>
  

<div class="review-container">
  <!-- 리뷰 작성 폼 -->
  <h2>리뷰 (${reviewCount}건 등록됨)</h2>
  <form action="${pageContext.request.contextPath}/review/add" method="post" class="review-form">
      <input type="hidden" name="memberId" value="${loginUser.id}">
      <input type="hidden" name="bookId" value="${book.id}">

      <textarea name="content" placeholder="리뷰 내용을 입력하세요" required></textarea>
      <select name="score" required>
          <option value="1">★☆☆☆☆</option>
          <option value="2">★★☆☆☆</option>
          <option value="3">★★★☆☆</option>
          <option value="4">★★★★☆</option>
          <option value="5">★★★★★</option>
      </select>
      <button type="submit" class="btn-submit">등록</button>
  </form>

  <!-- 리뷰 목록 -->
  <c:if test="${not empty reviewList}">
      <c:forEach var="review" items="${reviewList}">
    <div class="review-item" id="reviewRow${review.id}">
    <div class="star-rating">
    <input type="hidden" class="score" value="${review.score}">
    <c:forEach var="i" begin="1" end="5">
                            <c:choose>
                                <c:when test="${i <= review.score}">★</c:when>
                                <c:otherwise>☆</c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <strong>${review.memberId}</strong>
                    <span class="content">${review.content}</span>
                    <span class="review-date"><fmt:formatDate value="${review.wroteOn}" pattern="yyyy-MM-dd HH:mm"/></span>
    <c:if test="${loginUser != null and review.memberId == loginUser.id}">
    <div class="reviewactions">    
    <button type="button" class="btn-edit" onclick="editReview(${review.id})">수정</button>
    <form action="${pageContext.request.contextPath}/review/delete" method="post" style="display:inline">
    <input type="hidden" name="id" value="${review.id}">    
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <button type="submit" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
    </form>
    </div>
   	</c:if>
   	<hr>
   	</div>
   	</c:forEach>
</c:if>
</div>      
  </c:if>
  <c:if test="${empty reviewList}">
      <p class="no-review">등록된 리뷰가 없습니다.</p>
  </c:if>

  
  <a href="${pageContext.request.contextPath}/books" class="back-button">목록으로</a>  
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
function renderStars(score) { 
	let stars = "";
	for (let i = 1; i <= 5; i++){ 
		stars += (i <= score) ? "★ " : "☆ ";
	} 
	return stars;
}
function editReview(id) {
    const row = document.getElementById('reviewRow' + id);
    const contentTd = row.querySelector('.content');
    const scoreTd = row.querySelector('.score');
    const rating = row.querySelector('.star-rating');    
        
    const originalContent = contentTd.textContent;
    const originalScore = scoreTd.value;
       
    contentTd.innerHTML = `<textarea rows="3" cols="50" id="editContent\${id}">\${originalContent}</textarea>`;
    rating.innerHTML = `<select id="editScore\${id}"> <option value="1" \${originalScore=="1"?"selected":""}>★☆☆☆☆</option> <option value="2" \${originalScore=='2'?'selected':''}>★★☆☆☆</option> <option value="3" \${originalScore=='3'?'selected':''}>★★★☆☆</option> <option value="4" \${originalScore=='4'?'selected':''}>★★★★☆</option> <option value="5" \${originalScore=='5'?'selected':''}>★★★★★</option> </select>` ;
    
    const actionTd = row.querySelector('.reviewactions');    
    actionTd.innerHTML = `
        <button type="button" onclick="updateReview(\${id})">확인</button>
        <button type="button" onclick="cancelEdit(\${id}, '\${originalContent}', '\${originalScore}')">취소</button>
    `;    
}

function cancelEdit(reviewId, content, score) { 
	const row = document.getElementById('reviewRow' + reviewId);
    const contentTd = row.querySelector('.content');
    const scoreTd = row.querySelector('.score');
    const rating = row.querySelector('.star-rating');
    
    rating.innerHTML = `
    	<input type="hidden" class="score" value="\${score}">
    	\${renderStars(score)}
    `;
    contentTd.textContent = content;
    
	// 	버튼 복원 
    const actionTd = row.querySelector('.reviewactions');
	actionTd.innerHTML = `
    <button type="button" class="btn-edit" onclick="editReview(\${reviewId})">수정</button>
    <form action="${pageContext.request.contextPath}/review/delete" method="post" style="display:inline">
    <input type="hidden" name="id" value="\${reviewId}">    
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <button type="submit" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
	</form>` ;
}

function updateReview(reviewId) {
	const content = document.getElementById('editContent' + reviewId).value; 
	const score = document.getElementById('editScore' + reviewId).value;
	// POST 요청으로 서버에 전송 (폼을 동적으로 만들어서 submit)
	
	const form = document.createElement('form');
	form.method = 'post';
	form.action = '${pageContext.request.contextPath}/review/update';
	const idInput = document.createElement('input');
	idInput.type = 'hidden';
	idInput.name = 'id';
	idInput.value = reviewId;
	const contentInput = document.createElement('input');
	contentInput.type = 'hidden';
	contentInput.name = 'content';
	contentInput.value = content;
	const scoreInput = document.createElement('input');
	scoreInput.type = 'hidden';
	scoreInput.name = 'score';
	scoreInput.value = score;
	form.appendChild(idInput);
	form.appendChild(contentInput);
	form.appendChild(scoreInput);
	document.body.appendChild(form);
	form.submit();
}

</script>

</body>
</html>