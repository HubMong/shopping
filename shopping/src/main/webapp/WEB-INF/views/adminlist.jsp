 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
	<title>관리자 책 리스트</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"/>
</head>
<body>
<div class="container mt-5">
	<h2>관리자 페이지 리스트 </h2>
	
	<div class="mb-4 text-right">
		<a href="/admin/addbook" class="btn btn-primary">책 추가</a>
	</div>
	
	<div class="row">
		<c:forEach var="book" items="${books}">
			<div class="col-md-3 mb-4">
				<div class="card h-100">
					<img src="${pageContext.request.contextPath}/images/${book.imagepath}"
					     class="card-img-top"
					     alt="책 이미지"
					     style="height: 250px; object-fit: cover;">
					<div class="card-body text-center">
						<h5 class="card-title">${book.title}</h5>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>
