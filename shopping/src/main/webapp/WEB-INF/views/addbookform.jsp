 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>책 추가</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">책 추가하기</h2>
    <form action="/admin/save" method="post" enctype="multipart/form-data" class="row g-3">

        <div class="col-md-6">	
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>

        <div class="col-md-6">
            <label for="price" class="form-label">가격</label>
            <input type="number" class="form-control" id="price" name="price" required>
        </div>

        <div class="col-12">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="content" rows="4" ></textarea>
        </div>
        
        <div class="col-12">
            <label for="imagepath" class="form-label">이미지 파일</label>
            <input type="file" class="form-control" id="imagepath" name="imagepath">
        </div>

        <div class="col-12">
            <button type="submit" class="btn btn-primary">등록</button>
        </div>
    </form>
</div>
</body>
</html>
