<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Pet Care</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
<link rel="stylesheet" href="/css/animate.css">
<link rel="stylesheet" href="/css/owl.carousel.min.css">
<link rel="stylesheet" href="/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/css/magnific-popup.css">
<link rel="stylesheet" href="/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/css/jquery.timepicker.css">
<link rel="stylesheet" href="/css/flaticon.css">
<link rel="stylesheet" href="/css/style.css">
<style>
#page-title{
	padding-bottom:30px;
}
.col-sm-6.col-md-4{
	margin-bottom:25px;
}
#imgThumnail{
	display:none;
}
.card {
	margin-bottom:25px;
	box-shadow: 0 4px 6px 0 rgba(22, 22, 26, 0.18);
	border-radius: 0;
	border: 0;
	transition: transform 0.2s ease;
}
image{
	object-fit: cover;
}
.card:hover {
   transform: scale(1.05);
   transition: transform 0.3s;
   filter: brightness(0.7);
}
#contentTitle {
      display: -webkit-box; /* crom */
      display: -ms-flexbox; /* firefox */
      display: box;
      /*margin-top:1px;*/
      max-height:90px; /*글박스 높이 */
      overflow:hidden; /*오버되는 글 숨기기 */
      /* vertical-align:top; */
      text-overflow:ellipsis; /*ellipsis=생략  */
      word-break:break-all; /*텍스트가 내용 상자를 넘칠 때마다 줄 바꿈을 표시할지 여부를 설정  */
      -webkit-box-orient:vertical;
      -webkit-line-clamp:1 /* 2줄 이상은 ... 처리 */
 }
/*Content Modal*/
.modal-body{
	margin:0;
	padding:0;
}
.modal-body-text{
	margin:0;
	padding:10px;
	/*overflow:hidden;*/
}
.modal-body p {
    word-wrap: break-word;
}
.rounded-circle{
	width:35px;
	height:35px;
	margin-right:10px;
}
.realtime-text{
	color:light-gray;
}
/*Write Modal*/
.modal-body#writeModalBody{
	padding:10px;
}
</style>
</head>
<body>
<%@include file="../header.jsp"%>
<section class="hero-wrap hero-wrap-2"
	style="background-image: url();"
	data-stellar-background-ratio="0.5">
	<div class="overlay">
		<div class="container">
			<div class="row no-gutters slider-text align-items-end">
				<div class="col-md-9 ftco-animate pb-5">
					<p class="breadcrumbs mb-2">
						<span>Gallery<i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-0 bread">갤러리</h1>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="ftco-section">
	<div class="container">
		<div class="text-center" id="page-title">
			<h3>내가 쓴 게시물</h3>
			<div align="right">
				<button class="btn btn-primary btn-outline-primary btn-sm" onClick="location.href='/freeboard/galleryList'">목록</button> 
			</div>
		</div>
		<!--갤러리 썸네일 시작-->
		<div class="row">
			<c:choose>
			<c:when test="${empty galleryMyList}">
				<span class="text-align"><h5>데이터가 없습니다</h5></span>
			</c:when>
			<c:otherwise>
			<c:forEach items="${galleryMyList}" var="myGallery" varStatus="status">
				<div class="col-sm-6 col-md-4">
					<div class="card text-white">
						<img src="/freeboard/display?imgNames=${imgNames[status.index]}" class="card-img scale" alt="${imgNames[status.index]}">
						<div class="card-img-overlay">
							<!-- Modal 클릭링크-->
							<a href="#myModal" class="modal-link" data-toggle="modal" 
							data-gseq="${myGallery.g_seq}" data-email="${myGallery.email}" data-cont="${myGallery.content}" data-likes="${myGallery.likes}" 
							data-views="${myGallery.views}" data-wdate="${myGallery.wdate}"	data-imgs="${imgNames[status.index]}">
								<span class="card-text">
								<i class="fa fa-heart" aria-hidden="true"></i>${myGallery.likes}
								<i class="fa fa-eye" aria-hidden="true"></i>${myGallery.views}
								<i class="fa fa-clock-o" aria-hidden="true"></i>${myGallery.wdate}
								<h5 class="card-title text-white" id="contentTitle"><strong>${myGallery.content}</strong></h5>
							</span> 
							</a>
						</div>
					</div>	
					<div class="link">
						<a href="galleryDelete.do?g_seq=${myGallery.g_seq}" class="card-link" id="seq-btn"><small>삭제</small></a>
						<a href="galleryUpdate.do?g_seq=${myGallery.g_seq}" class="card-link"><small>수정</small></a>
					</div>
				</div>
			</c:forEach>
			</c:otherwise>
			</c:choose>
			<button type="button" class="btn btn-outline-primary btn-lg btn-block" id="readMore">
			<i class="fa fa-plus" aria-hidden="true"></i> 더보기</button>
			<!--갤러리 썸네일 끝-->

			<!-- Modal 시작 -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
					<input type="hidden" id="gseq" value="gseq">
						<!-- Modal 헤더 -->
						<div class="modal-header">
							<img src="https://source.unsplash.com/user/erondu/400x300" class="rounded-circle" alt="img1" width="35px;" height="35px;">
							<h5><span class="modal-email" id="email"></span></h5> 
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal 바디 -->
						<div class="modal-body">
							<img src="" class="card-img" alt="imgs" id="imgs">
							<div class="modal-body-text">
								<i class="fa fa-heart" aria-hidden="true"></i><span class="modal-likes" id="likes"></span>
								<i class="fa fa-eye" aria-hidden="true"></i><span class="modal-views" id="views"></span>
								<i class="fa fa-clock-o" aria-hidden="true"></i><span class="modal-wdate" id="wdate"></span>	
								<p class="modal-cont" id="cont"></p>
							</div>
						</div>
						<!-- Modal 푸터 -->
						<div class="modal-footer">
							<c:choose>
								<c:when test="${sessionScope.email != null}"><!-- ${sessionScope.email != gallery.email} -->
									<input type="text" class="form-control" name="comment" placeholder="댓글을 입력해주세요">
									<button type="button" class="btn btn-primary btn-outline-primary btn-sm" id="like-btn"><i class="fa fa-heart-o" aria-hidden="true"></i></button>
									<button type="submit" class="btn btn-primary btn-sm" id="comment-btn">입력</button>
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" placeholder="로그인 회원만 댓글을 작성할 수 있습니다" readonly>
									<button type="button" class="btn btn-primary btn-outline-primary btn-sm" id="like-btn" onClick="alert('로그인 회원만 이용가능합니다.')">
										<i class="fa fa-heart-o" aria-hidden="true"></i></button>
									<button type="submit" class="btn btn-primary btn-sm" id="comment-btn" onClick="alert('로그인 회원만 이용가능합니다.')">입력</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
			<!-- Modal 끝 -->
		</div>
	</div>
</section>
<%@include file="../footer.jsp"%>

<!-- loader -->
<div id="ftco-loader" class="show fullscreen">
	<svg class="circular" width="48px" height="48px">
		<circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
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
<script>
/* .modal-link에서 데이터 뽑아서 각 태그에 뿌려줌 */
$(".modal-link").click(function(){
	var gseq = $(this).data('gseq');
	var email = $(this).data('email');
	var cont = $(this).data('cont');
	var views = $(this).data('views');
	var likes = $(this).data('likes');
	var wdate = $(this).data('wdate');
	var imgs = $(this).data('imgs'); 
	var imgSrc = "/freeboard/display?imgNames="+imgs;
	console.log("gseq:"+gseq+" email:"+email+" cont:"+cont+" views:"+views+" likes:"+likes+" wdate:"+wdate+" imgs:"+imgs);
	
	$(".modal-gseq#gseq").html(gseq);
	$(".modal-email#email").html(email);
	$(".modal-cont#cont").html(cont);
    $(".modal-views#views").html(views);
    $(".modal-likes#likes").html(likes);
    $(".modal-wdate#wdate").html(wdate);
    $(".card-img#imgs").attr("src", imgSrc);
});
/* 더보기 버튼 */
$(function(){
	//var isHidden = $(".col-sm-6.col-md-4:hidden").val
    //var isShown = $(".col-sm-6.col-md-4").val
    $(".col-sm-6.col-md-4").slice(0, 9).show();
    if($(".col-sm-6.col-md-4").length < 9){ 
    	$("#readMore").remove();
    }
    $("#readMore").click(function(e){
        e.preventDefault();
        $(".col-sm-6.col-md-4:hidden").slice(0, 9).show();
        if($(".col-sm-6.col-md-4:hidden").length == 0){
        	$("#readMore").hide();
        }
        alert("더 이상 항목이 존재하지 않습니다.");
    });
});
</script>
</body>
</html>