<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Pet Care</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css"> <!-- 부트스트랩 사용시 필요코드 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/animate.css">
<link rel="stylesheet" href="/css/owl.carousel.min.css">
<link rel="stylesheet" href="/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/css/magnific-popup.css">
<link rel="stylesheet" href="/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/css/jquery.timepicker.css">
<link rel="stylesheet" href="/css/flaticon.css">
<link rel="stylesheet" href="/css/style.css">

<script src="http://code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>

<style>
.rating .star {
	width: 0;
	overflow: hidden;
}
.rating .star-wrap {
	width: 18px;
	display: inline-block;
}
.bi-star-fill {
	color: red;
}
</style>
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
						<h1 class="mb-0 bread">돌봄 후기</h1>
					</div>
				</div>
			</div>
		</section>


		
		<section class="ftco-section bg-light">
			<div class="container">
			<center><button><a href="write.do">후기쓰기</a></button></center>
				<div class="row d-flex">
					<c:forEach items="${list}" var="carereview">
					
						<div class="col-4 ftco-animate">
							<div class="blog-entry align-self-center">
						   	 		 
									<a href="content.do?cr_seq=${carereview.cr_seq}" class="block-20 rounded"
										style="background-image: url('/images/img.jpg');">
									</a>

									<div>
									<div>작성자:${carereview.writer}</div>
									<div class="review">
									  <div class="rating" data-rate="${carereview.star}">
									        <div class="star-wrap"><div class="star"><i class="bi bi-star-fill"></i></div></div>
									        <div class="star-wrap"><div class="star"><i class="bi bi-star-fill"></i></div></div>
									        <div class="star-wrap"><div class="star"><i class="bi bi-star-fill"></i></div></div>
									        <div class="star-wrap"><div class="star"><i class="bi bi-star-fill"></i></div></div>
									        <div class="star-wrap"><div class="star"><i class="bi bi-star-fill"></i></div></div>
									  </div>
									  </div>

									<div>${carereview.wdate}</div>
									<h5 class="textlength">
										<a href="content.do?cr_seq=${carereview.cr_seq}">${carereview.content}</a>
									</h5>
									<div class="text p-4">
										<div class="meta mb-4">																																
											<div>Comment</div>
											<div>
												<a href="#" class="meta-chat"> <span
													class="fa fa-comment"></span> 댓글
												</a>
											</div>
										</div>
									</div>
									<div class="blog-entry align-self-center">
											<h6>
												<a ${carereview.cr_seq}>돌보미:${carereview.dolbomy}</a>
											</h6>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</section>

		<%@include file="../footer.jsp"%>

		<!-- loader -->
		<div id="ftco-loader" class="show fullscreen">
			<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
					stroke-width="4" stroke="#eeeeee" />
			
			<circle class="path" cx="24" cy="24" r="22" fill="none"
					stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
		</div>
		<script>
			   $(function(){
				      var rating = $('.rating');
				      
				      rating.each(function(){
				         var $this = $(this);
				         var targetScore = $this.attr('data-rate');
				         var firstdigit = targetScore.split('.');
				         console.log(firstdigit);
				         if(firstdigit.length>1){
				            for(var i=0;i<firstdigit[0];i++){
				               $this.find('.star').eq(i).css({width:'100%'});
				            }
				            $this.find('.star').eq(firstdigit[0]).css({width:firstdigit[1]+'0%'});
				         }else{
				            for(var i=0;i<targetScore;i++){
				               $this.find('.star').eq(i).css({width:'100%'});
				            }
				         }
				      });
				   });
		</script>
		
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
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
		<script src="/js/google-map.js"></script>
		<script src="/js/main.js"></script>
</body>
</html>