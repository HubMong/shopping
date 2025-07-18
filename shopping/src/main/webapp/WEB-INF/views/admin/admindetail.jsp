<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>책 상세페이지</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_admindetail.css">
</head>
<body>
  <c:if test="${book == null}">
    <script>
      alert("찾으시는 책 정보가 없습니다.");
      window.location.href = "${pageContext.request.contextPath}/admin/books";
    </script>
  </c:if>
  
  <c:if test="${book != null}">
  <div class="book-container">
    <div class="cover">
      <img src="${pageContext.request.contextPath}/resources/images/${book.imagePath}" alt="책 표지">
    </div>
    
    <div class="info">
      <h1>${book.title}</h1>
      <p class="author">저자 : ${book.author}</p>
      <p class="price">가격 : ${book.price}원</p>
      <p class="content">${book.content}</p>
      
      
      <div class="buttons">
	      <form action="${pageContext.request.contextPath}/admin/books/edit" method="get">
	           <input type="hidden" name="id" value="${book.id}">
	           <button class="modify" type="submit">수정하기</button>
	      </form>
	                
	      <form action="${pageContext.request.contextPath}/admin/books/delete" method="post"
	          onsubmit="return confirm('정말 삭제하시겠습니까?');">
	          <input type="hidden" name="id" value="${book.id}">
	          <button class="delete" type="submit">삭제하기</button>
	      </form>
	  </div>
	  
    </div>
  </div>
  <a href="${pageContext.request.contextPath}/admin/books" class="back-button">목록으로</a>
  </c:if>
</body>
</html>
