<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title} - 도서 수정</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            width: 700px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
        }

        textarea {
            resize: vertical;
        }

        .buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .buttons button,
        .buttons a {
            padding: 10px 20px;
            font-size: 1em;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }

        .buttons button {
            background-color: #3498db;
            color: #fff;
        }

        .buttons a {
            background-color: #e74c3c;
            color: #fff;
        }
    </style>
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