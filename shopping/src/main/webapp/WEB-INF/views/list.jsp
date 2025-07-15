<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>도서 목록</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f7f3f0;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 40px;
            color: #333;
        }

        .book-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .book-card {
            background-color: #fff;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

        .book-card:hover {
            transform: translateY(-5px);
        }

        .book-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
        }

        .book-title {
            margin-top: 12px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .book-price {
            margin-top: 6px;
            color: #777;
            font-size: 14px;
        }
    </style>
</head>
<body>

<h1>SEOIL 도서</h1>

<div class="book-container">
    <c:forEach var="book" items="${bookList}">
        <div class="book-card">
            <img src="${pageContext.request.contextPath}${book.imagePath}" alt="${book.title}" />

            <div class="book-title">${book.title}</div>
            <div class="book-price">${book.price} 원</div>
        </div>
    </c:forEach>
</div>

</body>
</html>
