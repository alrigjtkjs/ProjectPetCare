<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link rel="stylesheet"
    	href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap">
    <link rel="stylesheet" 
    	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/animate.css">
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>FreeBoard<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">자유게시판</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
      <label><h2>Q&A</h2></label>
		<table class="table table-hover">
		  <thead class="thead-dark">
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col" colspan="2">작성자</th>
		      <th scope="col">제목</th>
		      <th scope="col">작성일</th>
		      <th scope="col">조회수</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:choose>
			  <c:when test="${empty list}">
			  	<td align="center" colspan="6">데이터가 없습니다</td>
			  </c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="freeboard">
						<tr>
							<th scope="row">${freeboard.fb_seq}</th>
				      		<td colspan="2">${freeboard.email}</td>
							<c:choose>
								<c:when test="${sessionScope.email != null}">
									<td><a href="content?fb_seq=${freeboard.fb_seq}">${freeboard.title}</a></td>
								</c:when>
								<c:otherwise>
									<td><a href='' onclick="alert('로그인 회원만 이용가능합니다.')">${freeboard.title}</a></td>
								</c:otherwise>
							</c:choose>
							<td>${freeboard.wdate}</td>
				      		<td>${freeboard.views}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
		  </c:choose>
		  </tbody>
		</table>
		<div class="write-btn" align="right">
			<button type="button" class="btn btn-primary btn-outline-primary btn-sm" onclick="location.href='/freeboard/write'">글작성</button>
		</div>
    </div>
    </section>
<%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  	<script src="/js/jquery.min.js"></script>
	<script src="/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="/js/popper.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script src="/js/jquery.easing.1.3.js"></script>
	<script src="/js/jquery.waypoints.min.js"></script>
	<script src="/js/jquery.stellar.min.js"></script>
	<script src="/js/jquery.animateNumber.min.js"></script>
	<script src="/js/bootstrap-datepicker.js"></script>
	<script src="/js/jquery.timepicker.min.js"></script>
	<script src="/js/owl.carousel.min.js"></script>
	<script src="/js/jquery.magnific-popup.min.js"></script>
	<script src="/js/scrollax.min.js"></script>
	<script src="/js/main.js"></script>
  </body>
</html>