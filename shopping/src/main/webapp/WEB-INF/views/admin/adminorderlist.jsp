<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 주문 리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminlist.css?v=1.0">

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>

<style>
  /* 상단 레이아웃 보조 */
  .dashboard-row { margin: 16px 0 8px; }
  .card { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
  .card-header { font-weight: 600; }
  .table-hover tbody tr { cursor: pointer; }

  /* [ADDED] 차트 반응형 높이 컨테이너 */
  .chart-wrap {
    position: relative;
    min-height: 320px;
    height: clamp(340px, 42vh, 520px); /* 화면 높이에 비례 */
  }
  @media (min-width: 992px) {
    .chart-wrap { height: 420px; }     /* 데스크톱에서 더 큼 */
  }
  /* 캔버스는 부모를 가득 채움 */
  #ordersChart { width: 100% !important; height: 100% !important; display: block; }
</style>
</head>

<body>

<c:if test="${empty sessionScope.loginUser or not sessionScope.loginUser.role == 'ADMIN'}">
    <c:redirect url="/books"/>
</c:if>

<header>
  <div class="header-container header-top">
    <div class="logo"><div class="logo-text">SEOIL 서일문고</div></div>

    <!-- 상단 검색 제거 (중복 UX) -->

<div class="user-menu">
        <a href="${pageContext.request.contextPath}/books" class="auth-button userpage-button">사용자 페이지</a>
        <a href="${pageContext.request.contextPath}/admin/addbook" class="auth-button add-button">책 추가</a>
        <a href="${pageContext.request.contextPath}/member/logout" class="auth-button logout-button">로그아웃</a>
    </div>
  </div>
</header>

<div class="container-fluid my-2">
  <nav class="menu-nav d-flex justify-content-center flex-wrap gap-2 w-auto mx-auto">
    <a href="<c:url value='/admin/books'/>"
       class="btn rounded-pill px-4 py-2 fw-semibold shadow-sm
              ${page eq 'books' ? 'btn-primary' : 'btn-outline-primary'}">
      📚 책 리스트
    </a>
    <a href="<c:url value='/admin/adminmemberlist'/>"
       class="btn rounded-pill px-4 py-2 fw-semibold shadow-sm
              ${page eq 'members' ? 'btn-primary' : 'btn-outline-primary'}">
      👥 회원 리스트
    </a>
    <a href="<c:url value='/admin/adminorderlist'/>"
       class="btn rounded-pill px-4 py-2 fw-semibold shadow-sm
              ${page eq 'orders' ? 'btn-primary' : 'btn-outline-primary'}">
      🧾 주문 리스트
    </a>
  </nav>
</div>

<!-- =========================
     상단 대시보드: 좌측 그래프 / 우측 검색·필터
     ========================= -->
<div class="container-fluid">
  <div class="row dashboard-row g-3">
    <!-- 좌측: 주문 수 그래프 -->
    <div class="col-12 col-lg-8">
      <div class="card">
        <div class="card-header">
          주문 추이 (집계 단위:
          <c:out value="${empty period ? '일' : (period=='year'?'연':(period=='month'?'월':'일'))}" />)
        </div>
        <div class="card-body">
          <!-- [CHANGED] 래퍼 추가 + canvas에서 height 속성 제거 -->
          <div class="chart-wrap">
            <canvas id="ordersChart"></canvas>
          </div>

          <script>
            (function() {
              // ===== JSP → JS 데이터 바인딩 =====
              var rawLabels = [
                <c:forEach var="stat" items="${orderStats}" varStatus="s">
                  '<c:out value="${stat.label}"/>'<c:if test="${!s.last}">,</c:if>
                </c:forEach>
              ];
              var period = ('${period}' || 'day');

              // 0 패딩 제거 (month/day)
              var labels = rawLabels.map(function(l) {
                if (period === 'month') {
                  var p = l.split('-');          // [YYYY, MM]
                  return p[0] + '-' + parseInt(p[1], 10);
                } else if (period === 'day') {
                  var p2 = l.split('-');         // [YYYY, MM, DD]
                  return p2[0] + '-' + parseInt(p2[1], 10) + '-' + parseInt(p2[2], 10);
                }
                return l; // year는 그대로
              });

              var counts = [
                <c:forEach var="stat" items="${orderStats}" varStatus="s">
                  <c:out value="${stat.count}"/><c:if test="${!s.last}">,</c:if>
                </c:forEach>
              ].map(Number);

              var minCount = counts.length ? Math.min.apply(null, counts) : 0;
              var maxCount = counts.length ? Math.max.apply(null, counts) : 0;

              // ===== 차트 생성 =====
              var ctx = document.getElementById('ordersChart').getContext('2d');
              window.ordersChart = new Chart(ctx, {
                type: 'line',
                data: {
                  labels: labels,
                  datasets: [{ label: '주문 수', data: counts, tension: 0.3, fill: false }]
                },
                options: {
                  responsive: true,
                  maintainAspectRatio: false, // 부모(.chart-wrap) 높이 따라감
                  animation: false,            // 리사이즈 반응 빠르게
                  plugins: { legend: { display: true } },
                  scales: {
                    x: { title: { display: true, text: '기간' } },
                    y: {
                      title: { display: true, text: '건수' },
                      beginAtZero: false,
                      suggestedMin: (minCount > 1) ? (minCount - 1) : minCount,
                      suggestedMax: (maxCount >= minCount) ? (maxCount + 1) : undefined,
                      ticks: {
                        stepSize: 1,
                        callback: function(v){ return Number.isInteger(v) ? v : ''; }
                      }
                    }
                  }
                }
              });

              // ===== 리사이즈 안정화 처리 =====
              function safeResize() {
                if (window.ordersChart) {
                  requestAnimationFrame(function() {
                    window.ordersChart.resize();
                    // 필요하면 다음 줄도 사용 가능: window.ordersChart.update('none');
                  });
                }
              }
              function debounce(fn, ms){ var t; return function(){ clearTimeout(t); t=setTimeout(fn, ms); }; }

              // 창/탭/복원 이벤트
              window.addEventListener('resize',             debounce(safeResize, 120));
              window.addEventListener('focus',              safeResize);           // 최소화→복원
              window.addEventListener('pageshow',           safeResize);           // bfcache 복원
              document.addEventListener('visibilitychange', function(){
                if (!document.hidden) safeResize();
              });

              // 컨테이너 크기 변화 감지(사이드바/레이아웃 전환)
              if (window.ResizeObserver) {
                var ro = new ResizeObserver(debounce(safeResize, 120));
                ['.chart-wrap', '.card', '.col-12.col-lg-8', '.container-fluid']
                  .forEach(function(sel){
                    var el = document.querySelector(sel);
                    if (el) ro.observe(el);
                  });
              }

              // Bootstrap 컴포넌트 표시 후 강제 리사이즈 (접힘/탭/모달 등)
              ['shown.bs.collapse','shown.bs.offcanvas','shown.bs.tab','shown.bs.modal'].forEach(function(ev){
                document.addEventListener(ev, safeResize);
              });
            })();
          </script>
        </div>
      </div>
    </div>

    <!-- 우측: 검색/필터 폼 (거래ID, 회원이름, 기간, 집계단위) -->
    <div class="col-12 col-lg-4">
      <div class="card">
        <div class="card-header">검색 / 기간 필터</div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/adminorderlist" method="get" class="vstack gap-3">
            <div class="row g-2">
              <div class="col-12">
                <label class="form-label">거래 ID</label>
                <input type="text" name="transactionId" class="form-control" value="${param.transactionId}">
              </div>
              <div class="col-12">
                <label class="form-label">회원 이름</label>
                <input type="text" name="memberName" class="form-control" value="${param.memberName}">
              </div>
              <div class="col-6">
                <label class="form-label">시작일</label>
                <input type="date" name="startDate" class="form-control" value="${param.startDate}">
              </div>
              <div class="col-6">
                <label class="form-label">종료일</label>
                <input type="date" name="endDate" class="form-control" value="${param.endDate}">
              </div>
            </div>

            <div class="mt-2">
              <label class="form-label d-block mb-1">집계 단위</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="period" id="p-year" value="year" ${period=='year'?'checked':''}>
                <label class="form-check-label" for="p-year">연</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="period" id="p-month" value="month" ${period=='month'?'checked':''}>
                <label class="form-check-label" for="p-month">월</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="period" id="p-day" value="day" ${(empty period || period=='day')?'checked':''}>
                <label class="form-check-label" for="p-day">일</label>
              </div>
            </div>

            <div class="d-grid mt-2">
              <button type="submit" class="btn btn-primary">검색</button>
              <a href="${pageContext.request.contextPath}/admin/adminorderlist" class="btn btn-outline-secondary mt-2">초기화</a>
            </div>
          </form>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- =========================
     테이블: 3개 컬럼만 유지, 행 클릭으로 상세 이동
     ========================= -->
<div class="container-fluid">
  <div class="card">
    <div class="card-header">주문 리스트</div>
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead class="table-light">
          <tr>
            <th style="width: 20%">거래 ID</th>
            <th style="width: 40%">회원 이름</th>
            <th style="width: 40%">결제 일시</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="entry" items="${groupedOrders}">
            <c:set var="firstOrder" value="${entry.value[0]}" />
            <tr onclick="location.href='${pageContext.request.contextPath}/admin/adminorderlist/detail?transactionId=${entry.key}'">
              <td>${entry.key}</td>
              <td>${firstOrder.member.name}</td>
              <td><fmt:formatDate value="${firstOrder.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
            </tr>
          </c:forEach>
          <c:if test="${empty groupedOrders}">
            <tr><td colspan="3" class="text-center text-muted py-4">조회된 주문이 없습니다.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
