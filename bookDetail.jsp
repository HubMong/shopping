<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>책 상세페이지</title>
  <style>
    body {
      font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
      margin: 0;
      padding: 40px 20px;
      background-color: #f9fafb;
      color: #222;
    }
    .book-container {
      max-width: 960px;
      background: #fff;
      margin: 0 auto;
      padding: 32px;
      box-shadow: 0 2px 16px rgba(0,0,0,0.05);
      border-radius: 12px;
      display: flex;
      flex-wrap: wrap;
      gap: 32px;
    }
    .cover {
      flex: 0 0 220px;
      text-align: center;
    }
    .cover img {
      max-width: 100%;
      border-radius: 8px;
      border: 1px solid #ccc;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .info {
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    .info h1 {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 12px;
      color: #111;
    }
    .author {
      font-size: 1.05rem;
      color: #555;
      margin-bottom: 8px;
    }
    .price {
      font-size: 1.3rem;
      font-weight: bold;
      color: #d32f2f;
      margin-bottom: 16px;
    }
    .description {
      font-size: 1rem;
      line-height: 1.6;
      color: #444;
    }
    .buttons {
      margin-top: auto;
      display: flex;
      gap: 8px;
    }
    .buttons button {
      flex: 1;
      padding: 12px 0;
      font-size: 1rem;
      font-weight: 600;
      border-radius: 6px;
      border: 1px solid #3f51b5;
      background-color: #fff;
      color: #3f51b5;
      cursor: pointer;
      transition: all 0.2s ease;
    }
    .buttons button:hover {
      background-color: #f3f6fd;
    }
    .buttons .buy-now {
      background-color: #3f51b5;
      color: #fff;
    }
    .buttons .buy-now:hover {
      background-color: #303f9f;
    }
    @media (max-width: 768px) {
      .book-container {
        flex-direction: column;
        padding: 24px;
      }
      .cover, .info {
        flex: 1 1 100%;
      }
      .buttons button {
        flex: unset;
        width: 100%;
      }
    }
  </style>
</head>
<body>
  <c:if test="${book == null}">
    <script>
      alert("찾으시는 책 정보가 없습니다.");
      window.location.href = "/books";
    </script>
  </c:if>
  <c:if test="${book != null}">
  <div class="book-container">
    <div class="cover">
      <img src="${book.coverUrl}" alt="책 표지">
    </div>
    <div class="info">
      <h1>${book.title}</h1>
      <p class="author">저자: ${book.author}</p>
      <p class="price">${book.price}원</p>
      <p class="description">${book.description}</p>
      <div class="buttons">
        <button class="add-to-cart">장바구니</button>
        <button class="buy-now">바로 구매</button>
      </div>
    </div>
  </div>
  </c:if>
</body>
</html>
