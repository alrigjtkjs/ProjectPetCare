<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <style>
    	.contents{
    		border-top: 3px solid #545454;
    		border-bottom: 1px solid #98a1a6;
    	}
    	.contenttop{
    		border-bottom: 1px solid black;
    		background: #f6f7f8;
    	}
    	.contenttop h2{
    		margin-bottom: 20px;
    	}
    	.contenttop li{
    		list-style-type: none;
    		display: inline;
    	}
    	.contenttop li::before{
        	content: "|";
    	}
    	.contenttop li:first-child::before {
        	content: none
    	}
    	.contenttop ul{
    		list-style-type: none;
    	}
    	.contentfile{
    		position: relative;
		    padding: 15px 40px 20px 140px;
		    font-size: 18px;
		    color: #80898e;
		    border-bottom: 1px solid #dee2e4;
    	}
    	.contentfile span{
    		position: absolute;
		    top: 15px;
		    left: 40px;
    	}
    	.contentfile a{
			display: inline-block;
		    margin-right: 20px;
		    padding-left: 22px;
		    font-size: 15px;
    	}
    	.contentcenter{
    		padding:30px;
    	}
    	.btn{
    		float:right;
    	}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Information <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">공지사항(상세)</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    <div class="contents">
    	<div class="contenttop">
    		<h2>${infolist.title}</h2>
    		<ul><li>${infolist.wdate}</li>
    		<li>${infolist.view}</li></ul>
    	</div>
    	<c:choose>
    	<c:when test="${empty filelist}">
    	</c:when>
    	<c:otherwise>
    	<div class="contentfile">
    		<span class="name">첨부 파일</span>
    		<c:forEach var="filelist" items="${filelist}">
				<a>${filelist.ofname}</a><br>
			</c:forEach>
    	</div>
    	</c:otherwise>
    	</c:choose>
    	<div class="contentcenter">
    		<div class="contentview" style="white-space:pre-wrap">${infolist.content}</div>
    	</div>
		</div>
		<div class="btn">
		<button type="button" class="btn btn-outline-info btn-lg" id="listButton" onclick="location.href='/info/list.do'">
		목록</button>
		<button type="button" class="btn btn-info btn-lg" id="updateButton" onclick="location.href='/info/infoupdate.do?n_seq=${infolist.n_seq}'">
		수정</button>
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/js/google-map.js"></script>
  <script src="/js/main.js"></script>

    
  </body>
</html>