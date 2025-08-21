<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 책 리스트</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminlist.css?v=1.0">
  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>

  <style>
    /* 행 클릭 UX 보강 */
    table.table-hover tbody tr.clickable-row { cursor: pointer; }
    table.table-hover tbody tr.clickable-row:focus {
      outline: 2px solid #0d6efd33; outline-offset: -2px;
    }
    /* 차트 래퍼: 부모 높이 보장 (반응형) */
    .chart-wrap {
      position: relative;
      min-height: 320px;
      height: clamp(340px, 42vh, 520px);
    }
    @media (min-width: 992px) {
      .chart-wrap { height: 420px; }
    }
    /* 캔버스는 부모를 가득 채움 */
    #bookChart { width: 100% !important; height: 100% !important; display: block; }
  </style>
</head>

<body>

<c:if test="${empty sessionScope.loginUser or not sessionScope.loginUser.role == 'ADMIN'}">
    <c:redirect url="/books"/>
</c:if>

  <header>
    <div class="header-container header-top">
      <div class="logo"><div class="logo-text">SEOIL 서일문고</div></div>

      <!-- [REMOVED] 헤더 검색 폼 -->
      <!--
      <form action="${pageContext.request.contextPath}/admin/books" method="get" class="search-box">
        <input type="text" name="keyword" placeholder="도서 검색" value="${keyword}">
        <button type="submit"><i class="fas fa-search"></i></button>
      </form>
      -->

	<div class="user-menu">
        <a href="${pageContext.request.contextPath}/books" class="auth-button userpage-button">사용자 페이지</a>
        <a href="${pageContext.request.contextPath}/admin/addbook" class="auth-button add-button">책 추가</a>
        <a href="${pageContext.request.contextPath}/member/logout" class="auth-button logout-button">로그아웃</a>
    </div>
    </div>
  </header>

  <!-- NAV: 가운데 정렬 라운드 버튼 -->
  <div class="container-fluid my-2">
    <nav class="menu-nav d-flex justify-content-center flex-wrap gap-2 w-auto mx-auto">
      <a href="<c:url value='/admin/books'/>"
         class="btn rounded-pill px-4 py-2 fw-semibold shadow-sm
                ${page eq 'books' ? 'btn-primary' : 'btn-outline-primary'}"
         aria-current="${page eq 'books' ? 'page' : ''}">
        📚 책 리스트
      </a>
      <a href="<c:url value='/admin/adminmemberlist'/>"
         class="btn rounded-pill px-4 py-2 fw-semibold shadow-sm
                ${page eq 'members' ? 'btn-primary' : 'btn-outline-primary'}"
         aria-current="${page eq 'members' ? 'page' : ''}">
        👥 회원 리스트
      </a>
      <a href="<c:url value='/admin/adminorderlist'/>"
         class="btn rounded-pill px-4 py-2 fw-semibold shadow-sm
                ${page eq 'orders' ? 'btn-primary' : 'btn-outline-primary'}"
         aria-current="${page eq 'orders' ? 'page' : ''}">
        🧾 주문 리스트
      </a>
    </nav>
  </div>

  <!-- =========================
       상단 대시보드: 좌측 그래프 / 우측 필터
       ========================= -->
  <div class="container-fluid my-3">
    <div class="row g-3">
      <!-- 좌: 인기 도서 Top N -->
      <div class="col-12 col-lg-8">
        <div class="card">
          <div class="card-header">인기 도서 Top ${paramLimit} (판매량)</div>
          <div class="card-body">
            <div class="chart-wrap">
              <canvas id="bookChart"></canvas>
            </div>
            <script>
              (function(){
                var labelsRaw = [
                  <c:forEach var="s" items="${bookSalesStats}" varStatus="st">
                    '<c:out value="${s.label}"/>'<c:if test="${!st.last}">,</c:if>
                  </c:forEach>
                ];
                var counts = [
                  <c:forEach var="s" items="${bookSalesStats}" varStatus="st">
                    <c:out value="${s.count}"/><c:if test="${!st.last}">,</c:if>
                  </c:forEach>
                ].map(Number);

                // 데이터 없으면 안내문
                if (!labelsRaw.length) {
                  var canvas = document.getElementById('bookChart');
                  var info = document.createElement('div');
                  info.className = 'text-muted';
                  info.innerText = '해당 조건의 데이터가 없습니다.';
                  canvas.replaceWith(info);
                  return;
                }

                // 라벨 길면 컷(가독성)
                var labels = labelsRaw.map(function(l){
                  return l.length > 18 ? l.substring(0, 18) + '…' : l;
                });

                var minC = Math.min.apply(null, counts);
                var maxC = Math.max.apply(null, counts);

                var ctx = document.getElementById('bookChart').getContext('2d');

                // 차트 생성
                window.bookChart = new Chart(ctx, {
                  type: 'bar',
                  data: {
                    labels: labels,
                    datasets: [{ label: '판매 수량', data: counts }]
                  },
                  options: {
                    indexAxis: 'y',         // 수평 막대
                    responsive: true,
                    maintainAspectRatio: false, // 부모(.chart-wrap) 높이에 맞춤
                    animation: false,
                    plugins: { legend: { display: true } },
                    scales: {
                      x: {
                        title: { display: true, text: '판매 수량' },
                        beginAtZero: false,
                        suggestedMin: (minC > 1) ? (minC - 1) : minC,
                        suggestedMax: (maxC >= minC) ? (maxC + 1) : undefined,
                        ticks: {
                          stepSize: 1,
                          precision: 0,
                          callback: function(v){ return Number.isInteger(v) ? v : ''; }
                        }
                      },
                      y: { title: { display: false } }
                    },
                    // 바 클릭 → 해당 책 제목으로 필터링 (Chart.js v4 시그니처: onClick(evt, elements, chart))
                    onClick: function(evt, elements, chart) {
                      var pts = chart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, false);
                      if (!pts || !pts.length) return;
                      var idx = pts[0].index;
                      var title = labelsRaw[idx]; // 잘리지 않은 원본 제목
                      var base = '<c:url value="/admin/books"/>';
                      var url = base
                        + '?keyword=' + encodeURIComponent(title)
                        + '&startDate=' + encodeURIComponent('${paramStartDate}')
                        + '&endDate=' + encodeURIComponent('${paramEndDate}')
                        + '&limit=' + encodeURIComponent('${paramLimit}');
                      window.location.href = url;
                    }
                  }
                });

                // ===== 리사이즈 안정화 처리 (최소화→복원, 탭전환 등) =====
                function safeResize(){
                  if (window.bookChart) {
                    requestAnimationFrame(function(){ window.bookChart.resize(); });
                  }
                }
                function debounce(fn, ms){ var t; return function(){ clearTimeout(t); t=setTimeout(fn, ms); }; }

                window.addEventListener('resize', debounce(safeResize, 120));
                window.addEventListener('focus', safeResize);
                window.addEventListener('pageshow', safeResize);
                document.addEventListener('visibilitychange', function(){ if (!document.hidden) safeResize(); });

                if (window.ResizeObserver) {
                  var ro = new ResizeObserver(debounce(safeResize, 120));
                  ['.chart-wrap', '.card', '.col-12.col-lg-8', '.container-fluid'].forEach(function(sel){
                    var el = document.querySelector(sel);
                    if (el) ro.observe(el);
                  });
                }
                // 부트스트랩 UI 토글들 복원 시
                ['shown.bs.collapse','shown.bs.offcanvas','shown.bs.tab','shown.bs.modal']
                  .forEach(function(ev){ document.addEventListener(ev, safeResize); });

                // 초기 레이아웃 안정화용 한번 더
                setTimeout(safeResize, 0);
              })();
            </script>
          </div>
        </div>
      </div>

      <!-- 우: 필터 -->
      <div class="col-12 col-lg-4">
        <div class="card">
          <div class="card-header">판매 통계 필터</div>
          <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/books" method="get" class="vstack gap-3">
              <div class="row g-2">
                <div class="col-6">
                  <label class="form-label">시작일</label>
                  <input type="date" name="startDate" class="form-control" value="${paramStartDate}">
                </div>
                <div class="col-6">
                  <label class="form-label">종료일</label>
                  <input type="date" name="endDate" class="form-control" value="${paramEndDate}">
                </div>
                <div class="col-12">
                  <label class="form-label">Top N</label>
                  <input type="number" min="3" max="50" step="1" name="limit" class="form-control" value="${paramLimit}">
                </div>
              </div>
				
			  <div class="col-12">
		          <label class="form-label"></label>
		          <input type="text" name="title" class="form-control" value="${title}" placeholder="제목">
		      </div>

			  <div class="col-12">
		          <label class="form-label"></label>
		          <input type="text" name="author" class="form-control" value="${author}" placeholder="작가">
		      </div>			  
              <!-- 기존 키워드 파라미터 유지(차트 클릭 후 돌아올 때 보존 용도) -->
              <input type="hidden" name="keyword" value="${keyword}">

              <div class="d-grid mt-2">
                <button type="submit" class="btn btn-primary">적용</button>
                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-outline-secondary mt-2">초기화</a>
              </div>
            </form>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- 책 리스트 테이블: 행 클릭 이동 -->
  <div class="container-fluid">
    <div class="card">
      <div class="card-header">책 리스트</div>
      <div class="card-body p-0">
        <table class="table table-hover mb-0">
          <thead class="table-light">
            <tr>
              <th style="width: 10%">도서 ID</th>
              <th style="width: 40%">제목</th>
              <th style="width: 25%">저자</th>
              <th style="width: 15%">가격</th>
              <th style="width: 10%">재고</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="book" items="${books}">
              <tr class="clickable-row"
                  data-href="<c:url value='/admin/books/detail'><c:param name='id' value='${book.id}'/></c:url>"
                  tabindex="0" role="button" aria-label="도서 상세로 이동: ${book.title}">
                <td>${book.id}</td>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td><fmt:formatNumber value="${book.price}" type="number" pattern="#,###" /> 원</td>
                <td>
                  ${book.stock}
                  <c:if test="${book.stock <= 5}">
                    <span class="badge text-bg-danger ms-1">낮음</span>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty books}">
              <tr><td colspan="5" class="text-center text-muted py-4">조회된 도서가 없습니다.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- 행 클릭/키보드 이동 스크립트 -->
  <script>
    (function(){
      var rows = document.querySelectorAll('tr.clickable-row');
      rows.forEach(function (tr) {
        tr.addEventListener('click', function (e) {
          if (e.target && e.target.closest && e.target.closest('a,button,input,label,select,textarea')) return;
          var href = tr.getAttribute('data-href');
          if (href) window.location.href = href;
        });
        tr.addEventListener('keydown', function (e) {
          if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            var href = tr.getAttribute('data-href');
            if (href) window.location.href = href;
          }
        });
      });
    })();
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
