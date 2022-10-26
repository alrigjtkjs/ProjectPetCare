<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Pet Care</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap"
	rel="stylesheet">

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
	<%@include file="../header.jsp"%>

	<section class="hero-wrap hero-wrap-2"
		style="background-image: url('/images/bg_2.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text align-items-end">
				<div class="col-md-9 ftco-animate pb-5">
					<p class="breadcrumbs mb-2">
						<span>Free Board<i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-0 bread">자유 게시판</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section bg-light">
    <div class="container">
    	<h3>게시물 수정</h3>
	    <form action="update" method="post">
	    <input type="hidden" name="fb_seq" class="form-control" value="${freeboardList.fb_seq}">
	    <table class="table">
	    	<tr>
				<td>제목</td>
				<td><input type="text" class="form-control" name="title" value="${freeboardList.title}"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td colspan="3">${freeboardList.email}</td>
			</tr>
			<tr id="content">
				<td>글내용</td><!-- id="editor-container" -->
				<td colspan="3"><input type="text" class="form-control" name="content" value="${freeboardList.content}"></td>
			</tr>
	    </table>
	    <div class="update-btn" align="right">
	    	<button class="btn btn-primary btn-outline-primary btn-sm" type="submit">수정</button>
			<button class="btn btn-primary btn-outline-primary btn-sm" type="button" onClick="location.href='/freeboard/list'">목록</button>
		</div>
	  </form>
    </div>
	</section>
	
	<%@include file="../footer.jsp"%>

	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"	stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>

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