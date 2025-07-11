<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
</head>
<body>
    <h2>로그인</h2>

    <form method="post" action="${pageContext.request.contextPath}/member/login">
        <label for="id">아이디:</label>
        <input type="text" name="id" id="id" required /><br/><br/>

        <label for="password">비밀번호:</label>
        <input type="password" name="password" id="password" required /><br/><br/>

        <button type="submit">로그인</button>
    </form>

    <c:if test="${not empty errorMsg}">
        <p style="color:red;">${errorMsg}</p>
    </c:if>
</body>
</html>
`
