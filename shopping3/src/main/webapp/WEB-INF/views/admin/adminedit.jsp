<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title} - 도서 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_adminedit.css">
</head>
<body>

<div class="container">
    <h2>도서 정보 수정</h2>
    <!-- multipart로 변경 -->
    <form action="${pageContext.request.contextPath}/admin/books/update" method="post" enctype="multipart/form-data">
        
        <div>
        	<input type="hidden" name="id" value="${book.id}">
        </div>
        
        <div>
            <label>도서 제목</label><br>
            <input type="text" name="title" value="${book.title}" required>
        </div>
        
        <div>
            <label>저자</label><br>
            <input type="text" name="author" value="${book.author}" required>
        </div>
		
		<div>
            <label>가격</label><br>
            <input type="number" name="price" value="${book.price}" required>
        </div>
        
        <div>
            <label>도서 설명</label><br>
            <textarea name="content" rows="5">${book.content}</textarea>
        </div>

        <div>
			<label for="imagePath">도서 이미지 업로드</label><br>
	        <input type="file" name="imagePath" accept="images/*"><br>
	        
	        <c:if test="${not empty book.imagePath}">
	            <img src="${pageContext.request.contextPath}/resources/images/${book.imagePath}" alt="도서 이미지" style="max-width:150px;"><br>
	            <small>※ 새 이미지를 선택하지 않으면 기존 이미지가 유지됩니다.</small>
	        </c:if>
	        
		    <!-- 기존 이미지 경로 hidden 필드로 전달 -->
		    <input type="hidden" name="originImage" value="${book.imagePath}">
	    </div>
        
        <div class="buttons">
            <button type="submit">수정 완료</button>
            <a href="${pageContext.request.contextPath}/admin/books/detail?id=${book.id}">취소</a>
        </div>
    </form>
</div>

</body>
</html>