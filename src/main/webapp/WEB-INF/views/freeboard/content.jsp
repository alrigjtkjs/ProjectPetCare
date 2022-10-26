<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
          	<p class="breadcrumbs mb-2"><span>Free Board<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">자유 게시판</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
	    <div class="container">
	    <h3>게시글</h3>
	    <form>
	    <input type="hidden" name=g_seq value="${list.fb_seq}">
	    <p class="text-right">
	    	<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>${list.likes}
	    	<i class="fa fa-eye" aria-hidden="true"></i>${list.views}
	    	<i class="fa fa-clock-o" aria-hidden="true"></i>${list.wdate}
	    </p>
          <table class="table">
             <tr>
               <td>제목</td>
               <td colspan="3">${list.title}</td>
             </tr>
             <tr>
               <td>작성자</td>
               <td>${list.email}</td>
             </tr>
             <tr id="content">
               <td row="50">글내용</td>
               <td colspan="3">${list.content}
               <button class="btn btn-primary btn-outline-primary"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i>도움이 됐어요</br></button></td>
             </tr>
          </table>
         </form>
	    <div class="content-btn" align="right">
	      <button class="btn btn-primary btn-outline-primary btn-sm" type="submit" onclick="location.href='/freeboard/update?fb_seq=${list.fb_seq}'">수정</button>
          <button class="btn btn-primary btn-outline-primary btn-sm" type="submit" onclick="location.href='/freeboard/delete?fb_seq=${list.fb_seq}'">삭제 </button>
          <button class="btn btn-primary btn-sm" type="button" onclick="location.href='/freeboard/list'">목록</button>
        </div>
    </div>
   </section>
    
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
  <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/>
  <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

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