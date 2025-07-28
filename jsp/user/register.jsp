<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css">
</head>
<body>
    <div class="register-container">
        <h2>회원가입</h2>
        
        <form id="registerForm" method="post" action="${pageContext.request.contextPath}/member/join">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" required>
                <div id="idError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
                <div id="passwordError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <div id="confirmPasswordError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required>
                <div id="nameError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
                <div id="emailError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" required>
                <div id="phoneError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" required>
                <div id="addressError" class="error-message"></div>
            </div>
            
            <button type="submit">회원가입</button>
        </form>
        
        <div class="login-link">
            이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/member/loginform">로그인</a>
        </div>
        
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/books">← 메인 페이지로 돌아가기</a>
        </div>
    </div>
    
    <script>
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmPasswordError = document.getElementById('confirmPasswordError');
            
            if (password !== confirmPassword) {
                e.preventDefault();
                confirmPasswordError.textContent = '비밀번호가 일치하지 않습니다.';
            } else {
                confirmPasswordError.textContent = '';
            }
        });

        // 서버에서 전달된 오류 메시지 표시
        window.onload = function() {
            const idError = "${idError}";
            const passwordError = "${passwordError}";
            const nameError = "${nameError}";
            const emailError = "${emailError}";
            const phoneError = "${phoneError}";
            const addressError = "${addressError}";
            const generalError = "${generalError}";

            if (idError) document.getElementById('idError').textContent = idError;
            if (passwordError) document.getElementById('passwordError').textContent = passwordError;
            if (nameError) document.getElementById('nameError').textContent = nameError;
            if (emailError) document.getElementById('emailError').textContent = emailError;
            if (phoneError) document.getElementById('phoneError').textContent = phoneError;
            if (addressError) document.getElementById('addressError').textContent = addressError;
            if (generalError) alert(generalError); // 일반 오류는 alert로 표시
        };
    </script>
</body>
</html> 